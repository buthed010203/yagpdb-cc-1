{{/*
	Working keypad using reactions as an interface. Usage: `-keypad`.

	Recommended trigger: Command trigger with trigger `keypad`.
*/}}

{{ $colors := sdict "success" 0x50C878 "failure" 0xDC143C "neutral" 0xFF7900 }}
{{ $reactions := cslice "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣" "7️⃣" "8️⃣" "9️⃣" }}

{{ with .ExecData }}
	{{ with and (dbGet .MessageID "keypad") (getMessage nil .MessageID) }}
		{{ $embed := index .Embeds 0 }}
		{{ editMessage nil .ID (cembed
			"title" $embed.Title
			"footer" (sdict "text" "This keypad has timed out.")
			"color" $colors.failure
		) }}
		{{ deleteAllMessageReactions nil .ID }}
	{{ end }}
{{ else }}
	{{ $generated := "" }}
	{{ range seq 0 4 }}
		{{ $generated = joinStr "" $generated (randInt 1 10) }}
	{{ end }}
	{{ $ret := sendMessageRetID nil (cembed
		"title" (printf "❯ Keypad: %s" $generated)
		"footer" (sdict "text" "React with the numbers shown above, in order.")
		"color" $colors.neutral
	) }}
	{{ addMessageReactions nil $ret $reactions.StringSlice }}
	{{ dbSetExpire $ret "keypad" (sdict "expect" $generated "current" "") 15 }}
	{{ execCC (toInt .CCID) nil 14 (sdict "MessageID" $ret) }}
{{ end }}