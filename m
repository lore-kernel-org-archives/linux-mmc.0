Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EED40756E
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834136; cv=none; b=Bf9TVIVjWGIHRChse4L0/6qxDQY/9e84ASF+17jFJizyHg14HDYAPl55T2LsQcCg0SbmE4LuIShiHE4NhVBGN40FqBpDQhyD8De9LFDixvqrk+S2LpM8PHRBniuAHe+a+7AigK2L+CelFz6RMnAwPbjgdQj1uz2njsJrJ99dYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834136; c=relaxed/simple;
	bh=96mNJw9f1BgqS8uU5GhJPZZf1KnnwThecQBZUYxu46s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJyjLIdXwl86wcDKQq7UtP+nYzI++N3X9dSBojlm5XeKuHi08WbYnoSpYlRs0CCIPg/drzJTqGwz9zDKqL7MvzfbC1w+fohWw/YJleHfgIjK/tHFKKoARCIR+CO2+qHqC91SxqK1mKhF5E5+KOtGSyh1Qc8lGn0n9p+qrYfnp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgA1aavO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgA1aavO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso15227999a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834134; x=1779438934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBeJSKAWF7Gtl5mZlo2O/+2W9wWBVsqONsnUlmKaMr8=;
        b=YgA1aavOShuWxnqjqVmWkltb5jrt3a+Lvre+sSWLcTdEvuiRHLX4/ijuWyDyUBilcb
         YIKhna2hQreLC6Xl7Cg+pKYqOiAdQeVxwNWTLNFrtvEJ0Vm8H1LV++F3SX8u0GaZrDtx
         bTxYGJJ3XmUh85TWiMD9NJ6HAH5dMJ48Mo2EAsyV6xTD5TaFhA26a/JMa9ubX58HtJM/
         +YRUF5bAv4LlI08aYW1Wmcf8u7UMDUGLX72uTwcf6IFsXj+VTJKXbYUQDndbQlXzwPcI
         w3AoDA4vWTwZO8MimuqshNbnPpDB0S95D94jUQ5Y96iSr6J/bHg5msmlZIkys0PiiIcf
         lz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834134; x=1779438934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBeJSKAWF7Gtl5mZlo2O/+2W9wWBVsqONsnUlmKaMr8=;
        b=OKVffYzKRRFnWiR0w9HuaiJp4LRJkLwBgctLbGrzLNYoL4io2OsHzZXKj3uokrzLFW
         hubwkTxf7LGOpYXPbZvHxtN1f8ZS5LYxKDbuqVrRGCP/RYUaPWJ5ROhpw1rZSCEdPBbV
         1HdRZdISMjV7dCqdPHvZlhFjjgpxgkNImmWp2VzbOyNw2zqS5zH/WC8Hqk37vBaR7yCC
         +wz1hH8ThKfdZwj3toWctfxnPHfZiv6MvdsQj6K4hGtDS3CBjq1iQW/h52EmMl5X7jgS
         WtRPMOO6osmlqUqYHptceciuxiwiYGCV+8e9i+lTrXsjO5eLEp5ytOkOnFpucHLKAmma
         PWzQ==
X-Gm-Message-State: AOJu0YyNxg/vrR8TMInIMAJSdu6SA7NIW47VdN9BXfrqaITYNeBxAcWs
	XYOeP/ku9CGnRnh41d2mtfGdihgtCMlHclsWJRHpQcKxGqlV7Z+8gYuxf96Pcls3
X-Gm-Gg: Acq92OE/vWjVdENRK/1oji9OV6iahyNgdSWgHAm1habnx7IPfzoAlBADcpLHaKoZXKe
	6ffzZURy45L6r9IHab+5MwjZ7z/+BuZV4GOY3O6cFWRosRKnvoPQJ5me4cq2IDbFENuxQl+mgJR
	uv8gaGQDDd2WP3omiV8WfEo5Fa+HB8b7L+R3UcRKrXhNh4CMzGCh9LYF9TBPnCM0VI7xmcZP3RK
	AMOKEleGMCvXaNoYN28foKeTVtUB/6sZR3uKmQJ92YUu2t6h4cy3ZV2BEO2Wy0ev8NpAUnWBLA1
	VVhdVfHyp2EKT5v1bxHMZE37lNlAqOA4b7cgztqFt7aCsGha2+XwQNlE4Q7gUl6PVwkpCGbqe51
	l7DqglNqZNXIhXcxs8fEOPcubNntTsX/v2ExP/D/FNrvp25550HJ/A866TixZHvfzW5NJ06kMml
	7pYmtHV2gocavnMqfCB1cVFJu1pXjCilEa2HGr
X-Received: by 2002:a17:907:1b1c:b0:bd2:387:6bd with SMTP id a640c23a62f3a-bd5177afa91mr144363166b.4.1778834133580;
        Fri, 15 May 2026 01:35:33 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:a66:143b:cd2f:c4ae])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm189493566b.32.2026.05.15.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:35:33 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH 4/4] mmc-utils: Add bash completion
Date: Fri, 15 May 2026 10:34:57 +0200
Message-ID: <20260515083457.3690804-5-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515083457.3690804-1-torsteine+linux@gmail.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
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

