{{/*
	Example of manually parsing into a .CmdArgs like array from textual content.
	Usage: `-cmdArgs <content>`.

	Recommended trigger: Command trigger with trigger `cmdArgs`.
*/}}

{{ $regex := `\x60(.*?)\x60|"(.*?)"|[^\s]+` }}
{{ $clean := cslice }}
{{ range reFindAllSubmatches $regex .StrippedMsg }}
	{{ $clean = $clean.Append (or (index . 2) (index . 1) (index . 0)) }}
{{ end }}
**Args:**
{{ joinStr "\n" $clean.StringSlice }}