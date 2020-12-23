$event = Get-Content -Path $env:GITHUB_EVENT_PATH | ConvertFrom-Json
$author = $event.issue ? $event.issue.user.node_id : $event.pull_request.user.node_id

if ($author -eq $null) {
    throw 'No user id found'
}

gh auth status

echo "Looking up sponsorship from $env:GITHUB_ACTOR ..."

$query = gh api graphql --paginate -f owner='devlooped' -f query='
query($owner:  String!, $endCursor: String) {
  organization (login: $owner) {
    sponsorshipsAsMaintainer (first: 100, after: $endCursor) {
      nodes { 
        sponsorEntity {
          ... on Organization { id, name }
          ... on User { id, name }
        }
        tier { monthlyPriceInDollars }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
}
'

$amount = 
    $query | 
    ConvertFrom-Json | 
    select @{ Name='nodes'; Expression={$_.data.organization.sponsorshipsAsMaintainer.nodes}} | 
    select -ExpandProperty nodes | 
    where { $_.sponsorEntity.id -eq $author } | 
    select -ExpandProperty tier | 
    select -ExpandProperty monthlyPriceInDollars

if ($null -eq $amount) { 
    echo "Author is not a sponsor! Nothing left to do."
    return
}

echo "Author is a sponsor!"

$headers = @{ 'Accept'='application/vnd.github.v3+json;charset=utf-8'; 'Authorization' = "bearer $env:GH_TOKEN" }

# Try creating the labels, ignore errors (i.e. already created)
iwr -Body '{ "name":"sponsor :purple_heart:", "color":"ea4aaa", "description":"sponsor" }' "$env:GITHUB_API_URL/repos/$env:GITHUB_REPOSITORY/labels" -Method Post -Headers $headers -SkipHttpErrorCheck -UseBasicParsing | select -ExpandProperty StatusCode
iwr -Body '{ "name":"sponsor :yellow_heart:", "color":"ea4aaa", "description":"sponsor++" }'  "$env:GITHUB_API_URL/repos/$env:GITHUB_REPOSITORY/labels" -Method Post -Headers $headers -SkipHttpErrorCheck -UseBasicParsing | select -ExpandProperty StatusCode

$number = $event.issue ? $event.issue.number : $event.pull_request.number
$labels = $amount -ge 100 ? '{"labels":["sponsor :yellow_heart:"]}' : '{"labels":["sponsor :purple_heart:"]}'

iwr -Body $labels "$env:GITHUB_API_URL/repos/$env:GITHUB_REPOSITORY/issues/$number/labels" -Method Post -Headers $headers -SkipHttpErrorCheck -UseBasicParsing | select -ExpandProperty StatusCode

echo 'Label applied'
