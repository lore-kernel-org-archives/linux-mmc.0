Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EED30E0E5
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376279; cv=none; b=GD6pDKpUI5Pgh3XSVuMmgX4QdylDKCaXfDbwOjRMJIt6JyPJfIyC6os+46AYb+x+zZoTpBfaBFWPfjZ3Ysid2aBMeFQmSO/YXcKCeYLWPgng7zawfmH6dHx+UljPIfcXX5nu6ZzH21MBDDFKiN4g4qQqbzNJbw8j7Z71RlbFC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376279; c=relaxed/simple;
	bh=x8DmvlcgOwwiiOGjzQiTCDtbFefAvKFgFH76DKsbwnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frwax1mMv74RlHSQQIBnW6BeRCFqTkkbph9ypWR6UgowZ6OsFFOK6KT3BFWsihgaglo76Iry9Y9qyIzvq1HGYmRwOm83RyMfqWLx8AA9gSlgKF0FHwhWtWjsp39iG2K8VxeetMs/evel9lxuDRsFvdrhf7FpJmW5bAzMtV0uJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXXJf6Lu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXXJf6Lu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so3037019a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376275; x=1786981075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pP7WjT0exd0B+vIGyPL1D5mikb8cn57i/gwpKQgd/bk=;
        b=JXXJf6LucIwS+ODhLvn2wTFOVbi9nxwlg7PiDhSppWqMcaVbs1pJdyo0wNJp8qDEHs
         JYOr+E0Bsifgo3wELCM55amNb/y0Uw6QLuX5he6FVofSt7InjESWLjVqA7hB1XSvg5NE
         vvWgXjTJCw16565crC7Qa/lqsuBqa6ezcp31bLgQAhK5xiYh19zvWfTwy/iR3993n+pp
         7/a4FsdtD29ss7/y5iNp/IxGdax8Imn75325Xpm2BRj7hWvi0XKLSeDJAPe2Ktj9Czc9
         ChEUh4ViARdi/+HEZ+fFt+E3Z4jeZvhTzKLU9ZoENdbLaYTZEwALFyqPpTCDqA4cV/T0
         ogSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376275; x=1786981075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pP7WjT0exd0B+vIGyPL1D5mikb8cn57i/gwpKQgd/bk=;
        b=DimUeeaeTr0aXUWLq74CYZ0IHVw7t9ZSMif5iEUTtghBICo+VhpRFpI000gG9n0JNF
         uao1En7jKARiuh19PdmszF5aGHASYAAutwWzpP2mmzop7h02TGGshO919JXvOvJ+PMla
         cbm4jnghChaJStzDGyhNK+Fu5SHE3ecaeZJQW3GftvG5G3NorHbyQdp6AnepDkorHNXv
         9uqJWpOYlpPAa0HDnaOKbdJszNg4+TCrF/cp10rPFr8pBf1uRdDrvuWdYav4HbwSUOBP
         wGpx4lL4uA7c/VAZF+Ydcmy2DdUR13ix+S1HEyR8WcW9cRhh5Mqj8xHHjGNNdjjhOHRw
         jyqw==
X-Gm-Message-State: AOJu0YxRfjjXa5kz+uQekPXq2jiLCGNZ748PpMHrb6gKsbdrGF+rntzE
	fztYFuIZ/Dq0V+t8drmm8uRPT+ORrv3rj4+Iq+RjxpzUlSO0obtELIRx5velgdOD
X-Gm-Gg: AR+sD13xgGAQbU+yPkbC+nI3hyBlOEeIe5a2jh9IGeQP4ugFFys24DwoP43CvzI+nnW
	0gI11ElZkXHnzHdfqyMBNO4h2CRXeKPnzg0e+ts31/k4Pgc8sZtdvGh2LbiHgfJ1uQL5e9APQpY
	E49XYSUmK9dNm9cZBN+cxqmO/MWmmkZjV9rcSw2rJ/q8QnuaViRLYUGHmbgQBDJDWWu1x+xOJ/i
	+bqoQU4De2N//ZEngBo99Gg2LifRjLISNBNfrc1TCqF49wWMM487d2BDClM7RkVoQzamc13dkVF
	cz3Atf8vs9G3FhSYBHWJB24R9Oxpn+kK2j83NbJ287Vzof1QimprwVJWVK4QAv4sAo+gQqj8xdC
	4wfGDvhqVlXRXcVtieoqqtLRb7mSqpnjTfNcQg6N8dvU0CqlNgtv04mBGtCQiqeSCSRzZPhCyEG
	t71ifZ7gpoDnnl10d8yQwWLjHyofplVoquwHlhHO3fqKAf0JSYsilo7lSIWksvA/p1m3lYWlQr7
	jb/h1O0/9BV1o8yf8FNZ8Y=
X-Received: by 2002:a17:907:3c88:b0:c1c:5ec9:1954 with SMTP id a640c23a62f3a-c207ed873d1mr1171313166b.32.1786376275270;
        Mon, 10 Aug 2026 08:37:55 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:9fe:dfd2:946e:90f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080ab2e41sm411057366b.26.2026.08.10.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:37:54 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2] mmc-utils: Add bash completion
Date: Mon, 10 Aug 2026 17:37:34 +0200
Message-ID: <20260810153734.139186-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Changes since v1:
- Makefile: use 'bashcompletiondir ?=' instead of '='.
- completion/mmc: match rpmb, bootN, and partition device nodes in
  addition to the base mmcblkN device.

 Makefile       |  3 +++
 completion/mmc | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/HOWTO.rst |  6 ++++++
 3 files changed, 63 insertions(+)
 create mode 100644 completion/mmc

diff --git a/Makefile b/Makefile
index bf8c006..6eb584b 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,7 @@ AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
 	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
 	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
 CFLAGS ?= -g -O2
+bashcompletiondir ?= /usr/share/bash-completion/completions
 objects = \
 	mmc.o \
 	mmc_cmds.o \
@@ -63,6 +64,8 @@ install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
+	$(INSTALL) -m 644 completion/mmc $(DESTDIR)$(bashcompletiondir)/mmc
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/completion/mmc b/completion/mmc
new file mode 100644
index 0000000..1ac053b
--- /dev/null
+++ b/completion/mmc
@@ -0,0 +1,54 @@
+_mmc_complete() {
+	local cur prev words cword
+	_init_completion || return
+
+	local devices
+	# Include rpmb, bootN, and partition nodes alongside the base device.
+	devices=$(compgen -G "/dev/mmcblk*" 2>/dev/null | grep -E '^/dev/mmcblk[0-9]+(rpmb|boot[0-9]+|p[0-9]+)?$')
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
+complete -F _mmc_complete ./mmc
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

