Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B7385D86
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605964; cv=none; b=iLYNbhKl0Tmzv/0t3ctA2ty68n4Dce2a3AoWMW8IkzL0XBdRMRBp/npsi+noLcoQ0exkeRnLIdhiGslSC3qHMQ0hwb+0YQanHzaAbtRaj6ipLYEkvSfJDDjSDCW5JGKfEJ1P6BegCQlpW6w12OJsvLStlSd6oJdBt/eHNbdRhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605964; c=relaxed/simple;
	bh=65e6me75/aY0XRNZiDvvDhfOqMhs5FsVpu7CFXop4C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajssrWKevCRz53SVbccpaJ8zeAU4CrRs2AaftbnOF+6xpAfTpbr15bHLnSzw9kXUB0K1AHCfipZSAyZ4UNCyjGr+yC8XUKD8KPLb2DZ9zYkUdFnqT+vshL8Sk98RaGhntQTWwPMl6dfRu2CTYKj347CblgsAqj94J0txpnyabRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBP2F2Y7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBP2F2Y7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bccd251d622so507660066b.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605962; x=1779210762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaaA+amYJPx7JCMYQtgdQ4D83o0gxhn6VwOvhkZ0VWM=;
        b=HBP2F2Y7yRjWfJ5qgrbURc3GDMC9wa4bRvRSLSmYdChlcGohNy+YaUbxLGkMGkCfvW
         cYLGvNlpSI6tklLaO8J9sDubmP7+toFCzkreaMxwRBFJpmBOL3l1hRJo5Px2Dx7tPS5W
         8EldI/mzJfEd1FYpsFAYIlJDLueVPOgzHTmu6fcfKEa+MCgimahKPGb0YyuNY1ozrHZz
         eWXMOraSOfCooH5d4ayAmhV91QOpuwwQ7X+o8DnBFdLt7EJg3LI8Uz7+DGptv1H++rGz
         Qi2vJiSb158ajc1olovclJuhS8ULVKDSY40OSruCbehEYNvsWascotGCVp8+TW5W+mWT
         +ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605962; x=1779210762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaaA+amYJPx7JCMYQtgdQ4D83o0gxhn6VwOvhkZ0VWM=;
        b=e4BDVKNmvKXg1Xo1k0KjNSVhECGHGerW1ekNGqWhwE9z0TQVrYXqhVBGEX9mbvvGhJ
         O1FFJonPLisfPckzQzJdLaELqo+o66nyIv+b1wDIUTY/+Pml3msqulIDTQarhjhfrtmR
         jCPPqPe+uokelAGOYkSpg+9alCO1+bi40+cBtftHRU5JZ2vN/aVEq0uy7o/6/C6JuH1P
         aTLdjUP+nbS/4f+1K6+S6DSlrRqMyOrFpFLMQzGzfH1ebinGY5a0xloS9M/zKB1VxjcK
         KxJd72bO6BZkaoogrW/ui0weWvAru+f0htHcF0tGUAE+m2ojfUmS9zV4h06JEC9D0a00
         G6lw==
X-Gm-Message-State: AOJu0YwEe0G8WCqP0ZB+Mh3ML0BvC7K5ja5tJcXogpM965tps5n+oFU5
	v4RyD2KSEv4UNwkmtBaNkG6i741bVPgl7LTBb714JOAAnTNQCOeAV2lFTpWxuepvLac=
X-Gm-Gg: Acq92OHxdeiZDiQDf308eIAnIpc9hTf+Nb7JNiFb0nK+dGQyg2b8np0CyzUAhMa6OM8
	tXeHg9MAPRNS4Ol9Qgc0VdNB0pnh5Lc9gp6iGQr613+DSKUFz/buIN/9RoAMjR54K/Sj/+j/k5q
	UslEB6VcEf4KaaXfRpBkp+BJZS7hEO27h7PnV/LZ/m19r11onDG2SnTM9Lz5ymPM8JNg69ZJ+Wp
	kTBb/9lysVIj6t23nGh56nUTOhvFdpp1nKwJpDE5+KuLuuRa28HWkvjFkxQiJIItBq9sWSVSNsR
	+ttd4ou+47ZgsLR56itj2OMUUqjWllFQUIkMnAW1eA4FzZ0VsOIhYY/dv6LQDO1s/IO672+0B2z
	+c1F82a94sAjdOvHmAUPtonOVP07HLH/Fgj3EIptQpNegeu//3851FRSfdutZaybqZh9S2BHAQh
	NFInbdwKUgf79V8DVjtiT8fsXpo+XOcLtg+3IW+2DnrpB1QDg1
X-Received: by 2002:a17:907:971c:b0:bc7:73f8:9f50 with SMTP id a640c23a62f3a-bd28fdbdbebmr318048866b.42.1778605961599;
        Tue, 12 May 2026 10:12:41 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:132c:48b3:4466:1640])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd1ca4e43b0sm250325666b.32.2026.05.12.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:12:41 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein EIde <torsteine+linux@gmail.com>
Subject: [PATCH 1/1] mmc-utils: Add bash completion
Date: Tue, 12 May 2026 19:12:27 +0200
Message-ID: <20260512171227.36584-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Torstein EIde <torsteine+linux@gmail.com>

Add a bash completion script in completion/mmc that completes subcommands
and /dev/mmcblkN device paths for all mmc commands.

The completion directory is named 'completion/' rather than
'bash-completion/' so shell-specific scripts for other shells (zsh,
fish, etc.) can be placed alongside it without renaming.

Add bashcompletiondir variable to the Makefile (defaulting to the
standard /usr/share/bash-completion/completions) and install the
script as part of 'make install'. The install path can be overridden
at build time with make bashcompletiondir=<path>.
---
 Makefile       |  3 +++
 completion/mmc | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/HOWTO.rst | 14 ++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 completion/mmc

diff --git a/Makefile b/Makefile
index 11685b9..5389bf9 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,7 @@ INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
 idsdir ?= /usr/share/misc
+bashcompletiondir ?= /usr/share/bash-completion/completions
 LIBS=
 RESTORE_LIBS=
 mandir = /usr/share/man
@@ -61,6 +62,8 @@ install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
+	$(INSTALL) -m 644 completion/mmc $(DESTDIR)$(bashcompletiondir)/mmc
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/completion/mmc b/completion/mmc
new file mode 100644
index 0000000..07e4c25
--- /dev/null
+++ b/completion/mmc
@@ -0,0 +1,62 @@
+_mmc_complete() {
+	local cur prev words cword
+	_init_completion || return
+
+	local devices
+	devices=$(compgen -G "/dev/mmcblk[0-9]" 2>/dev/null)
+
+	case $cword in
+	1)
+		local verbs="extcsd writeprotect disable gp enh_area \
+			write_reliability status bootpart bootbus hwreset bkops \
+			sanitize rpmb cache csd cid scr ffu opt_ffu1 opt_ffu2 \
+			opt_ffu3 opt_ffu4 erase gen_cmd softreset preidle \
+			boot_operation list"
+		COMPREPLY=($(compgen -W "$verbs" -- "$cur"))
+		;;
+	2)
+		case $prev in
+		extcsd)
+			COMPREPLY=($(compgen -W "read write" -- "$cur")) ;;
+		writeprotect)
+			COMPREPLY=($(compgen -W "boot user" -- "$cur")) ;;
+		bootpart)
+			COMPREPLY=($(compgen -W "enable" -- "$cur")) ;;
+		bootbus)
+			COMPREPLY=($(compgen -W "set" -- "$cur")) ;;
+		hwreset)
+			COMPREPLY=($(compgen -W "enable disable" -- "$cur")) ;;
+		bkops)
+			COMPREPLY=($(compgen -W "enable" -- "$cur")) ;;
+		rpmb)
+			COMPREPLY=($(compgen -W "read-counter read-block write-block write-key" -- "$cur")) ;;
+		cache)
+			COMPREPLY=($(compgen -W "enable disable" -- "$cur")) ;;
+		csd|cid|scr)
+			COMPREPLY=($(compgen -W "read" -- "$cur")) ;;
+		gen_cmd)
+			COMPREPLY=($(compgen -W "read" -- "$cur")) ;;
+		status)
+			COMPREPLY=($(compgen -W "get" -- "$cur")) ;;
+		gp)
+			COMPREPLY=($(compgen -W "create" -- "$cur")) ;;
+		enh_area|write_reliability)
+			COMPREPLY=($(compgen -W "set" -- "$cur")) ;;
+		sanitize|softreset|preidle|ffu|opt_ffu1|opt_ffu2|opt_ffu3|opt_ffu4|erase|boot_operation)
+			COMPREPLY=($(compgen -W "$devices" -- "$cur")) ;;
+		esac
+		;;
+	3)
+		case ${words[1]} in
+		writeprotect)
+			COMPREPLY=($(compgen -W "get set" -- "$cur")) ;;
+		csd|cid|scr|extcsd|gen_cmd|status|bootpart|bootbus|hwreset|bkops|cache|gp|enh_area|write_reliability)
+			COMPREPLY=($(compgen -W "$devices" -- "$cur")) ;;
+		esac
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$devices" -- "$cur")) ;;
+	esac
+}
+
+complete -F _mmc_complete mmc
diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 45c440b..9a460e4 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -2,6 +2,13 @@
 
 Running mmc-utils
 -----------------
+**Bash completion**
+    Source ``completion/mmc`` to enable tab-completion for all subcommands and
+    device paths. When installed via ``make install``, the file is placed in
+    ``$(bashcompletiondir)`` (default: ``/usr/share/bash-completion/completions/mmc``)
+    and loaded automatically by bash-completion.
+
+

-- 
2.53.0

