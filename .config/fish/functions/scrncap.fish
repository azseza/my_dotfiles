function scrncap --description 'Screenshot a Hyprland workspace by number: scrncap [-m] <ws>'
    argparse 'm/modify' -- $argv
    or return 2

    set -l ws $argv[1]
    if test -z "$ws"
        echo "usage: scrncap [-m|--modify] <workspace-number>" >&2
        return 1
    end
    if not string match -qr '^\d+$' -- $ws
        echo "scrncap: workspace must be a number, got '$ws'" >&2
        return 1
    end

    set -l monitor (hyprctl workspaces -j | jq -r ".[] | select(.id == $ws) | .monitor")
    if test -z "$monitor"
        echo "scrncap: workspace $ws not found (use hyprctl workspaces to list)" >&2
        return 1
    end

    set -l saved_ws (hyprctl monitors -j | jq -r ".[] | select(.name == \"$monitor\") | .activeWorkspace.id")

    set -l outdir ~/Pictures/screenshots
    mkdir -p $outdir
    set -l outfile $outdir/ws$ws-(date +%Y%m%d-%H%M%S).png

    hyprctl dispatch workspace $ws >/dev/null
    sleep 0.35
    grim -o $monitor $outfile
    set -l rc $status
    if test "$saved_ws" != "$ws"
        hyprctl dispatch workspace $saved_ws >/dev/null
    end

    if test $rc -ne 0
        echo "scrncap: grim failed (rc=$rc)" >&2
        return $rc
    end

    echo $outfile

    if set -q _flag_modify
        if not command -q swappy
            echo "scrncap: --modify needs swappy (pacman -S swappy)" >&2
            return 1
        end
        # Edits saved via Ctrl+S overwrite the file in place.
        swappy -f $outfile -o $outfile
    else
        command -q notify-send; and notify-send "Workspace $ws captured" "$outfile" -t 2500
    end
end
