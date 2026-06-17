Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFB346E70
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717081; cv=none; b=GpsQ7wS4QwXZU+PSTjkiicFgOJXYogx+pcBRMQ2gY8xAURoEB0aYpmbrwPEezrUqHolPb6dLjCfYoSVvPyMn0xcdm4Mzx5uo6NDx3vgYnmCKCFYfBHs3zPEZjBx9G8ml04OJTP+P192/HYjPwoOAEh5cvBeaIiN6eKPM0JbsDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717081; c=relaxed/simple;
	bh=pcHf1pa0/GHWBzIttZYoAreUXayllb7b8H6yxUAV37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiCPF23Ig+pf0BJXZK2RBFwzZNHpsKE0ONT8FvaoNYdVey2NpMfW9NHfLPzk3syOCJ5jJ7LjfStpMtHuIHsnLjQ10MLQdsqhz31DAZWXt3Ok2hNuNShQnndZD1zSBahy/hfBds4A0uUl+g3fiByEUi7A3jKJMmrrV0b0Ej23xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSqEQMwZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSqEQMwZ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec4639953dso1026067266b.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717079; x=1782321879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f7qEcIt6BOyNo3yrQQonpfeE0fBI5o4BNYicVsF3vk=;
        b=VSqEQMwZ4+0RRuTMOM3n+JRhpeKnmZurNtDtqmv+FDEmjQX+GAQ/wvfC9JxTNp6XcK
         +lgmW/RTAWLQIdHQ0B4o9FCPT7NiT8brCPsmJg91+J5FK/VVy+4BSvw+bZ1/0g174yNH
         5WNRMdpW44QJo1YRyqEYS/E0QJOe2CR7mRGmwXc9LOtOZCt7BzGjZJEdSP7pgZwOR6dO
         ewTdQ+R62uEh4nHD7vGyYCjuljI48I7XXTcKTzAQThsgRqPPf/hDV1HQIYn/DdrpYNS1
         1GEK7L6uy4kDYoIxt8aOc3qQqQ7VAiE9YQokfBNTgjRTEBbmJ64bAnpIxFY0yqzifc2w
         rkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717079; x=1782321879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+f7qEcIt6BOyNo3yrQQonpfeE0fBI5o4BNYicVsF3vk=;
        b=Wk4WCqcPODlpaPU35VQMUYf0ThwhD1a86Sb+vtvdYDBBk6MYN5GYm4/j5MBNXdd+eE
         r4rXzJAekrfVF2VJesuc5td9YR9t1wNxB6Mmm7auecOO4+h0bifoydn6A480NZE919tT
         9MoMHcpmRl1/3JQeWrbGI4aIVk8qWqCOVsiUyyhrsXmOkH6jY1vQHkY9ESyCRJkmyq1W
         xUSZtilDKmDsW12NfKwtqxzx8yT3ITW8ADAxyM7079BXNojKQM04S46ynrWrkqOEAw8o
         bo6OKGs0sW1fzJ+VjUABdBVAyU6k1x3HDh3aVjU+77+rjEZNi6MDoAU1WQs2v8bNU67i
         lqCQ==
X-Gm-Message-State: AOJu0YwoiS79uhjwyLlNwJURaUCJ0OqIgoVX8U3t0LF9ibpm+7DNystL
	2Ofz8HQa4FsfFO2RFeXKLEfEIzZSxtnA/bROauUlZCJf2TFP8xXKHGv0pyKjTA==
X-Gm-Gg: Acq92OEjCVUEnSZqRe789u4BmWOqbK4GiIFdarVbFgiN6Gm+bhTVJhHjbd28WKumg8K
	gwBPkyu0xMlj3M8nkGnSvuxGRDml1D4fJiHsi8bhyahNM6TrrnAcMTCsPPIW973sjBDu/JDh/DT
	/gKbiazxRgRakppFFHaZV9ExTP58yi93HawKg/HVp2OPM/iyCF+8VA6NdnstzQPbtthyWuY1I/J
	6yZYgjouQOV7PMZQaK6MG2dHwRD05FxtieP0Ggqe+9PqdnQ3kNcz5czgWdqX+BtY6QLx8MV2aqJ
	1CYJVw24H9m1V2EG/6zqgSDUPD7SprK+PeoEz5hpPjMBzeWbFFmSU3j4fZsqG75VxIzrzbUViJa
	D6JPS9UhLx9RY+dCXhR8BZTlwolKkXnFh7kkHFd8mNrrdKz7qDKGNq09LGeFsNhOaynQlPkbFiu
	yiPOaAgEeMAmeQ4hXfPZq77CtIXck=
X-Received: by 2002:a17:907:1998:b0:bec:ab0c:2442 with SMTP id a640c23a62f3a-c05a4b0fa8fmr329999866b.2.1781717078622;
        Wed, 17 Jun 2026 10:24:38 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:ec6d:6f56:be28:aea2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm323873766b.51.2026.06.17.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:24:37 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v3 4/4] mmc-utils: Add bash completion
Date: Wed, 17 Jun 2026 19:24:11 +0200
Message-ID: <20260617172411.42805-5-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617172411.42805-1-torsteine+linux@gmail.com>
References: <20260617172411.42805-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bash completion script in completion/mmc that completes subcommands
and /dev/mmcblkN device paths for all mmc commands.

The completion directory is named 'completion/' rather than
'bash-completion/' so shell-specific scripts for other shells (zsh,
fish, etc.) can be placed alongside it without renaming.

Add bashcompletiondir variable to the Makefile (defaulting to the
standard /usr/share/bash-completion/completions) and install the
script as part of 'make install'. The install path can be overridden
at build time with make bashcompletiondir=<path>.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 Makefile       |  5 +++-
 completion/mmc | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/HOWTO.rst |  6 +++++
 3 files changed, 72 insertions(+), 1 deletion(-)
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
index 0000000..c759972
--- /dev/null
+++ b/completion/mmc
@@ -0,0 +1,62 @@
+_mmc_complete() {
+	local cur prev words cword
+	_init_completion || return
+
+	local devices
+	devices=$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E '^/dev/mmcblk[0-9]+$')
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

