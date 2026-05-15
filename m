Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A73ED13C
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881101; cv=none; b=PAFdGuQfuTN2a5amIUVXg+bSqoDjaCaSAKtxd6CutpWoIPnfcvgLevn8OvbYXIcXZQnao2p7hbO8Rfo61VrlNZpp44vdRP9oXEXYMI+ZygsYAtaDu51olW9Br3E4NEfyGvgkm5ZCoTrZprZ0ikvc60aSLTRjdaCGmzm/05Q1vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881101; c=relaxed/simple;
	bh=WXxWYuc7h4mUBsM2fwkHgiJ1nmHgMc0USb4YER0FhDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkkjincK4OI3ampO6DQclRonx+CSZRItkFuvdebEiLkE7gtWXNFFCoVB3fVKr1mOLJBZwOCMD/ygvj9QPUZvo7/K69zvMVTBS/wm2mPy6c/N0mZ0LlBZaE/2smA+DpfQfoa7ZWfb+tSW9SZMZQMWRPVuvJDxRDcUTZEV4lDOG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imVoqtUf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imVoqtUf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so710761a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881099; x=1779485899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEXnM3M8drdkTd1r4wcRZ5/ieWs20RjKb+wroDvCD14=;
        b=imVoqtUfehLxHwdJv7zjBGGddcQ75fRevdWrs9UzEj86vlNUk4Zbuc5d9/FXHnUav/
         44Et9w26wPQldvz30M75IHiZ6B2aLPCbqNxFtCPwxzmm6d0kYng/uw1Es7R1Uo6FH6cj
         rB6FEDBci1tXdGHDrDAIhSuZfxpRT/uqQ0qDw5swuZGiVtujbfgEEOp+0bYD+WB6LEC/
         SDgVUIi6K8wglnwNFXh63f+KZh6+YOlqqgCBCn+cVLiFOxRyKQHjeDAYIdTfC1Jk9KTp
         wb5lpnaXExvTfV+jXW2/0HGg2auZuXVS7SHZG1nfnVfSX9TvUPzyKOR++chYQEhL1MV/
         PbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881099; x=1779485899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEXnM3M8drdkTd1r4wcRZ5/ieWs20RjKb+wroDvCD14=;
        b=hPOTbO2Ovf3ILlRxygfz2MmtBADJnVSdYEqBifo9ve3e+7e8VBTdEiBr1RUl2LgqPo
         MDTnBshjbrzNLNqvL6h84cGPn2HefQDaWLbZIWYORr1CE42ox+6o07LU7BRyfuMf3i9E
         wwE2I5iICeRJGSoEazU9dSE9riDEQmmjwiL7lLVub1qbS8W++xgWZr21sFKzFJSOui1p
         WukaYfWUPNEZasdrF6Q6fAt+/VASMJ5d2zMvpiaPFmj9NAxNiwgrV0HIjdT4Ki2Eq181
         oZF4go21jLEz8v4uHS7G1Tqh5RHhO84HrVSQH1Z2cY9JFDVbw/a0uY7OUu2msV9/a87a
         BCqw==
X-Gm-Message-State: AOJu0YzsnLaNl7gmkL9YuMOPmMkmCpCHmrTyivymmExKrCI7PL4Aj5Jn
	j5XaXRICBsF0HbdnURxQgjbX7cDVATSw9MiUH1RonsqFeX+d8RPhJGPGGKtJm8bI
X-Gm-Gg: Acq92OHcn1Xend8zvkYj0J2xo6ZTIHG5Mzra7P2JqVBarabcZWjwtHKwherHgem3UWh
	as5gsoXyp+/u1fWUhoTCitVbRPRv4s8tOqZQOZdTiyA4tXoeYzG5vp0QCdv3wWmR/R5JPTrBXIB
	dNOs1ljtX4WLw3aYO4hWNFlpuzGI8RQyNTNCyEL7SjZ0z0ftb17tj0XqtQ9Lmkh4eiU+uRzfcxj
	xpma9hk3V/fF1csQWFZdmI0kpP0Bjdsn3LTlHfxBwtz654U1PZVVB/u/c5L+8SpWIXj7u9DBtTS
	leakF6kGpVyGJsFbDtu7Jwpo0yzueiOhRu0hSOqJ/Ow83+nGRf6xxZ361bHUnEHiOGF8F7lCRFP
	5nZyq6yaxQage2OeX0JB4CFmZTZLYPz9cHaW3XTifT9zjHyVsZCt+9jJtr/5CZci5iStTVIPusm
	7d8UtpkTSHKterOTUjMPcozGjHVhEYpMR9Hp2dLNirkzvr4vwpqrc73wBVhw==
X-Received: by 2002:aa7:c4e7:0:b0:670:8b38:5717 with SMTP id 4fb4d7f45d1cf-683bd581a49mr2084443a12.24.1778881098713;
        Fri, 15 May 2026 14:38:18 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:17 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 5/5] mmc-utils: Add bash completion
Date: Fri, 15 May 2026 23:37:47 +0200
Message-ID: <20260515213747.1452692-6-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515213747.1452692-1-torsteine+linux@gmail.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
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
index 11685b9..e447e54 100644
--- a/Makefile
+++ b/Makefile
@@ -5,6 +5,8 @@ AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
 	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
 	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
 CFLAGS ?= -g -O2
+idsdir = /usr/share/misc
+bashcompletiondir = /usr/share/bash-completion/completions
 objects = \
 	mmc.o \
 	mmc_cmds.o \
@@ -21,7 +23,6 @@ override CFLAGS := $(CHECKFLAGS) $(AM_CFLAGS) $(CFLAGS)
 INSTALL = install
 prefix ?= /usr/local
 bindir = $(prefix)/bin
-idsdir ?= /usr/share/misc
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
index 167a153..460d016 100644
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

