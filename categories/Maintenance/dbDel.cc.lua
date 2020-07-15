{{/*
	This command is a tool for deleting DB entries by ID or key.
	Usage: `-dbDel <userid> <id> -id` or `-dbDel <userid> <key>`.

	Recommended trigger: Command trigger with trigger `dbDel`.
*/}}

{{ $args := parseArgs 2 "" (carg "int" "userID") (carg "int" "id") (carg "string" "type") }}
{{ $isId := false }}
{{ if $args.IsSet 2 }}
	{{ if in (cslice "-i" "-id") ($args.Get 2) }} {{ $isId = true }} {{ end }}
{{ end }}
{{ if $isId }}
	{{ dbDelByID ($args.Get 0) ($args.Get 1) }}
{{ else }}
	{{ dbDel ($args.Get 0) ($args.Get 1) }}
{{ end }}
Successfully deleted!