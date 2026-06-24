Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6E280037
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326923; cv=none; b=RL8OdlI8ZdElEpE9AaOhbY3VSvhAJlvLT3r7KJ3u6H5mpPKhuGhwhTJz2CyaLZj4RwkWJy7x/Uxo5MNBp8dEgwft/usGeMZB6IKc7F4ERXwaY//Pf0Dp24eOT9QTIOOp43Ftc0hMB6t09wnmgEHk3nJsZatoGrv8QmVuuI1pjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326923; c=relaxed/simple;
	bh=FEWdXdT2cjuJD1zbB4Jc/J0repjF+XZ5Zbjr/ztk9lY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLV7SWsKUHvmpAXdZGYaSx6V27hWceduZZnTE5nvaQOQZzJUKVie+TI9jF6+FYO3SWkjh5l5/l3UfN650IwquRGYvGJ1D/rAeM0GmibgmWntZHA6ZCH/qF2df70AyGp/o0A9msGNRlumZVACHCqgrYWphun1ORbMFgvI05B0Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icr+Phrx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icr+Phrx"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so2584657a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326921; x=1782931721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03DWepEJBd6lfjBynqByKo0zsThAoWP0t0TWAttzb+U=;
        b=icr+PhrxhZhmqryDXnwTpCq5nmGf781ljWN27r4FMhv4offmKJk5ZikfMfLkJp/Hz4
         YSJJ064ajsCdjLMw9t8G2dzXZdpefGzPYq34Ss3G2UTu0jiW51Q4mg70ZlpUKNltyL9d
         CnE/8fhccef6fw1mfh3jHVAin4DxlZBLSs4QPpl2DVLBSdmsRsPcmWCsKJSnY60QKwYG
         sQuaQsoL5d+TsYkKiQ0mQaGyKw8b17sYY10IzO/nJVPgbGXm3uPx3K1fRPzUytgrG6v/
         QTm9zs7vTmhnFyNk8mYjSpt+7RFn9mfqPduwP/Q/GX4g1kLA/YISdk2pzsAWgkSxmHjT
         3BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326921; x=1782931721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03DWepEJBd6lfjBynqByKo0zsThAoWP0t0TWAttzb+U=;
        b=FZOLjvHdIiDcig38UZUol3QvtB6boGXfJi7shXP4pIni+2Cn/AAAA5CH56P10D4ESS
         44KkOVgFJAe+mlcKjbxlDyzhV+AZda74aj1dVWzO/o6VbF04DOVS7DPNBAOMOlI3ZQly
         JgpuGFC2Zl865bNi0ST2+kXG2Ta743++Eky8cw/H4EKqpqGCLTZABCYwJBiO9volVoI6
         J0EFoXGVXXV+C0Cma9IldF39FOwJBVt4kwE1tVN/3vR4iY3m6KOz+EiBl0VFWUsCorxs
         RybgUQQ54/LmyPGhsz12I+T8vcAnj9MEYDY+LUIKWeDvowsiG2YpqH6P5RPtiTqoQwTb
         +PrA==
X-Gm-Message-State: AOJu0YzSEkjGoJsJgZnALH77oF8f04wHjg7rNHRKwWBI6dCsR+rERneG
	EnjLDGIqKP8vxnmUTYc7fmnxNJ178V29zKAmu0DJsLjC6ahLptA3JetD1Ks73Q==
X-Gm-Gg: AfdE7cmAUp4kEdIqSk67Wmup+jbkeTd1BkqG/U9IPepWZv4B7bOER/295hPAIxvBR4G
	PorZdnovaidm9OyfQUkVN7ezNlwYaiAezjrbCaoqxogf7i09bA/grsnmJPwDe2rtRoJ+Mdabkh8
	wBvIDoTDbBo89Wj3QNuvlxRpCedFAohlNk4sgarT7F7EKtuMFGv3R3+GMv4XddIvbrgnsTrefvU
	ybFtREnrfNk3kwOc2b4Yp0hLmGsK0t0WDZJLFZjNAql0ZASgLbsVEqiDo2gLFUG6OPSPkRyK2XJ
	TRGyKBkoLZeCeAl+o4IAFv/JBvv5p3/kt/TphUa24fRZkyEulkZfQVKU7am6Cw8imqJXOrgxgBe
	xXpxG00n6XNiy6qr+O2Of5H0kKYERMd2y3kU9xU9Ji1osFlannKWCiINT3y7NwlUcTVBjC2Z62B
	dAYNCvJ4VwzLNp5cmG4jXLjLiZKIc=
X-Received: by 2002:a05:6402:3583:b0:697:cec5:d056 with SMTP id 4fb4d7f45d1cf-697cec5d170mr6150813a12.0.1782326920888;
        Wed, 24 Jun 2026 11:48:40 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:91be:16ef:9f06:8b10])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm1659189a12.3.2026.06.24.11.48.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:48:40 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Subject: [PATCH v4 3/3] mmc-utils: Add bash completion
Date: Wed, 24 Jun 2026 20:48:24 +0200
Message-ID: <20260624184824.2215718-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184824.2215718-1-torsteine+linux@gmail.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bash completion script in completion/mmc that completes subcommands
and /dev/mmcblkN device paths for all mmc commands.

Subcommand completion is driven by parsing 'mmc help' output rather than
maintaining a parallel hardcoded verb list, so it stays in sync as
commands are added or removed.

The completion directory is named 'completion/' rather than
'bash-completion/' so shell-specific scripts for other shells (zsh,
fish, etc.) can be placed alongside it without renaming.

Add bashcompletiondir variable to the Makefile (defaulting to the
standard /usr/share/bash-completion/completions) and install the
script as part of 'make install'. The install path can be overridden
at build time with make bashcompletiondir=<path>.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 Makefile       |  5 ++++-
 completion/mmc | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/HOWTO.rst |  6 ++++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 completion/mmc

diff --git a/Makefile b/Makefile
index bf8c006..607d372 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,8 @@ AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
 	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
 	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
 CFLAGS ?= -g -O2
+idsdir = /usr/share/misc
+bashcompletiondir = /usr/share/bash-completion/completions
 objects = \
 	mmc.o \
 	mmc_cmds.o \
@@ -23,7 +25,6 @@ override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS) $(CFLAGS)
 INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
-idsdir ?= /usr/share/misc
 LIBS=
 RESTORE_LIBS=
 mandir = /usr/share/man
@@ -63,6 +64,8 @@ install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
+	$(INSTALL) -m 644 completion/mmc $(DESTDIR)$(bashcompletiondir)/mmc
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/completion/mmc b/completion/mmc
new file mode 100644
index 0000000..1924c15
--- /dev/null
+++ b/completion/mmc
@@ -0,0 +1,52 @@
+_mmc_complete() {
+	local cur prev words cword
+	_init_completion || return
+
+	local devices
+	devices=$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E '^/dev/mmcblk[0-9]+$')
+
+	local mmcbin
+	mmcbin=$(type -P "${words[0]}") || return
+
+	# "mmc help" prints one "Usage for command\t<verb words...> <args...>"
+	# line per command. Argument placeholders always start with '<', so
+	# stripping from the first '<' onward leaves just the verb words.
+	local verbs
+	verbs=$("$mmcbin" help 2>/dev/null | sed -n 's/^Usage for command[[:space:]]*//p' | sed 's/<.*//')
+	[[ -z $verbs ]] && return
+
+	local -a typed=("${words[@]:1:cword-1}")
+	local -A next_words=()
+	local have_leaf=
+
+	local line i match
+	while IFS= read -r line; do
+		[[ -z $line ]] && continue
+		local -a w
+		read -ra w <<<"$line"
+		[[ ${#w[@]} -lt ${#typed[@]} ]] && continue
+
+		match=1
+		for ((i = 0; i < ${#typed[@]}; i++)); do
+			if [[ ${w[i]} != "${typed[i]}" ]]; then
+				match=0
+				break
+			fi
+		done
+		[[ $match -eq 0 ]] && continue
+
+		if [[ ${#w[@]} -gt ${#typed[@]} ]]; then
+			next_words[${w[${#typed[@]}]}]=1
+		else
+			have_leaf=1
+		fi
+	done <<<"$verbs"
+
+	if [[ ${#next_words[@]} -gt 0 ]]; then
+		COMPREPLY=($(compgen -W "${!next_words[*]}" -- "$cur"))
+	elif [[ -n $have_leaf ]]; then
+		COMPREPLY=($(compgen -W "$devices" -- "$cur"))
+	fi
+}
+
+complete -F _mmc_complete mmc
diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 0b486e4..3aba86f 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -2,6 +2,12 @@
 
 Running mmc-utils
 -----------------
+**Bash completion**
+    Source ``completion/mmc`` to enable tab-completion for all subcommands and
+    device paths. When installed via ``make install``, the file is placed in
+    ``$(bashcompletiondir)`` (default: ``/usr/share/bash-completion/completions/mmc``)
+    and loaded automatically by bash-completion.
+
 **Name**
     mmc - a tool for configuring MMC storage devices
 **Synopsis**
-- 
2.53.0

