Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CE1E492D
	for <linux-mmc@vger.kernel.org>; Sun,  9 Aug 2026 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786262861; cv=none; b=mgfWea5N4Ucec+rQ18dCCtBKeu1nbw7n3ZF+GPVUCvFwRGxlwyT0nt9m4Sg7FAqmysS+QKDCspmnwaIlcj0ba+8xFT4BceUSpSO/blbM0QaHNy9Dq6kFWGJaWwbbqEEczeE+gWrst1eYZVDsFZDLKrPiufcadYnk50VKLnGPDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786262861; c=relaxed/simple;
	bh=EkEZoiY/xMhfDiMYannQLy0TwAdB0vuZbM84LwVAzdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wg7TxmSWEfZ1LNVNEyxMOJbKcnNGarCx24gRkjZJCna0rYF/uIZSd/KY5mil5DyUibXPQHfcaLXGav6jgwd6pZhkJckt6HXUQXF152RHTK3fSYnIPvBXrlwWiGVUnbEu70eUHdx6SnsckopiHlM5M2NRM8PwEjpHVHKTfpauK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxLNWlAX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxLNWlAX"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so4860286a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 09 Aug 2026 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786262858; x=1786867658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1+d8JkekWuBZKLCg8kzcKX8Lcv7755OU8LOQFfamDg=;
        b=VxLNWlAXSqsPoKTMmeqsP5YIdykX/iW+S415t1wd2VLGoytt0ENimICIQVTm6+boq8
         gdHbwfiD2+OF9Fn9RSMFOeCCumRBb7gxpUvEAb9ApMN5vT2k2SX/t1HTIZGCS3u1IF8Q
         4hJWMllL3jyJynv5m8SpqqFNXjFFIi7B0F0M/oVrZ7Kj8QnPNe9+nhrreBhxii/1603w
         h9ZyuA8ztJcMIRZw8niiADX3ewycYU6L4zAhNFhOWKuhIcxJZvzXqeCVhAXEsGQK94sW
         rNZHiSeWwz7BJyY/hKWSsf9SzyIeFos5Rw+khdf2prdR4QilKE+Csv8R3+5cyxmgw2qu
         r5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786262858; x=1786867658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1+d8JkekWuBZKLCg8kzcKX8Lcv7755OU8LOQFfamDg=;
        b=ptnBA4DtRceVXMfT7GcKddH9trv7k/8gArkojJeLYRNEsoosPKIXUw2u9AfcuAx/S2
         c0bAkKusVptdKscL35oM+40c1nqyuT2jNWDUAPK3RtokzprA/bqlBc+LsuJtsSCRfNd+
         rVkA1YaJK8JcGutN1F4VY67QUYJm4TYE5Z60jhj17QZEr4dvIDL5R8S7evz/e8Zw2fKa
         t21Lb5PVXRhL267+qucr+u0DnJMq6zpIj3oapaSzFyDEC2KZ6px272slmEOM5mwzuhRI
         C/KQ5Ztdz0jiWXIqKIDx2zdS9Wfpqpe4A9jYLGrr0kWLwahRESzp3TD3ZgfBGbGBQzOj
         BUbg==
X-Gm-Message-State: AOJu0YypS8leaV18SZJ+ykI0gcmIDQkQj9w2lIVo6l3pZmEIpuGTeyJU
	uVwE7UfQaHHjqevxWG1UG3d/K1pLjgKwX2NIaxrzDl2AdaKjR54ofA2KLtdqZQ==
X-Gm-Gg: AR+sD12x07rPLr/W8aNz5SDkq/rY8yqwjC9ZxhAgZ3zo8QZ6f11HIPcdsLtu/L/MyPV
	8xVkWmvE78CIuTlaB7rQNLA3NOybCz/B655EYp38ySCtXPz/iyvImkFBRbVYmdtlQstKo9GA3RE
	IqRMKeDtLa28ipgYxBZC0GGDTtEfo/1qHRTn+SPbMb7eZXGY8j1C35z3l12BcOKR2X2nGXFs+yr
	cd8fKkfKfiyxygSLWY2PTue+hZVf/paFQvBV2nbfHzGSjjnTveCEJb3lRHhGQoApM+S7EAKqgzu
	UvhX4M8sIu0QT+Ltksr6coOjJOm+OGv7xnh4GOImIkmHR0J2hs3cANNizmc+SIyyvA0BZKZegoG
	veIuPe6kGa5ypLgwNi/RLCaBzauuwEseIl5VQYzeB+WkVOWnEjJGRzZQCQkwuGsH6HDLIDO+OV5
	kGD7TPM/kgRN5eE51e6nG/Zed1kO/43ETdlw79PxB/4By1Z/Sq5s3Bw3ZSBnttZKmOd1Y9BXAx8
	sICxJKdl55aAg==
X-Received: by 2002:a17:907:d1a:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c20a2439c32mr240002066b.0.1786262857810;
        Sun, 09 Aug 2026 01:07:37 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:1e75:8b0f:2e1:e0bd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080ab28e6sm237306166b.24.2026.08.09.01.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:07:36 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH] mmc-utils: Add bash completion
Date: Sun,  9 Aug 2026 10:07:14 +0200
Message-ID: <20260809080714.67754-1-torsteine+linux@gmail.com>
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
 Makefile       |  5 ++++-
 completion/mmc | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/HOWTO.rst |  6 ++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
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
index 0000000..0a93bb1
--- /dev/null
+++ b/completion/mmc
@@ -0,0 +1,53 @@
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

