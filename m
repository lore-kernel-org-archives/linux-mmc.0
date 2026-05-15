Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BB31A56C
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834115; cv=none; b=T0XlBZJ4jp4tDUVMD4nA5fOxQCnoFZMp3vzVm5JN107aPWpTjLYU6lKbCizccw0WmWEsVgHXRiEPpYoLFahX/Z5FpewXLqRHPKHtFlwq1zclA2OOvJRMJEKA0OnhP+Oz+lCawc5VpzdTbKqEpeeaANnNoDUOHTl3OR7M0jXBdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834115; c=relaxed/simple;
	bh=Y+kAFJeJC++xYwwWIhfiXNx3JdTmbQE1PsgX0RwVW1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUV/ABUqy3B8GrzuoHVuz18kcir1pZxZGUtonAI9fqk0zdvIZ25X6CYTukS0plsDg+4yurU3Ag0O5jhmDMK4svs4ScHgKJJ8sRRuae8i8W2FvW7Uh+gY4Yh/flMNrJpJjWyiGA69Qh60bjlJHYKReb6hEtwAsifJJC1TC5FBbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIYW8CPH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIYW8CPH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso1349111766b.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834113; x=1779438913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3LlWg8vNrIB0CpACmW6MxylQI0xekFJgDhSjcStUhI=;
        b=nIYW8CPH1tHA/Ed96H5TBSLHGzFI184+bqg+aJVQTLVPgdbCDKHWI+Y/yBkjN03OSq
         wyMQbnhOA51i2Cs22ROFcN45JCDTIjXErfefSf2SUEHRg42EvqunU9853xPQjLw0z/x+
         KlqNX18lyBOffh6J1RjRcrjXrdFATpxaB1q8wLSF5+mbv1+7jH5Vo5w5mS2rwY3eDBAj
         XhV6nKw1Ri9caVpD72UvglvczRofF0Vmq2DzIXwUentsJDMu2i1UkfahS8Robskpn3bX
         0cg+qLub90MBGozVAwMOWChqsdX4nt4Kteg8EQFnmGyywHGV9PACCtTIsR8SPatpHQ5E
         0q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834113; x=1779438913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3LlWg8vNrIB0CpACmW6MxylQI0xekFJgDhSjcStUhI=;
        b=ifk0/HScXXQIyaSesIBDG4K4WkeOy2YA3czdv0OI3Lv6ePRCNhiihWdr4YMJoQ2CyR
         JIEEb6Zhdnkpiox1DSdfad8GbdtxtToBnuugRLUZVgcCFXFf2x0dXv7ljvt7n4y8tM6N
         HkOyC0M4Dy44M2QfmHc/EOk8aGSjEf2l/8szQX3eIr4YDuYUzw2p6XIVREPn9YIIlyjs
         cBPsBfO0EgNXluTrf3ROhCvuIilXfMdkR99Ph8Dw6jxVZV6TV8gW0EloG8rwC81L/aZ+
         afqvn+QWLOVMG86VniyHTx/atbMDpNF4QfDZmkYZZE4oYu0eUhHZdW6pMpUvRug0s+lE
         zFcA==
X-Gm-Message-State: AOJu0Yx3xhXk+dzEpV6B3K514Uy3mhhWV6oFC/bPGoMt5YYlJUmiN5cz
	UVw1XkHh/VoTDcuR4HgLQQFQWz68H1yvBmt9kPZKtpP+BJu1T8NHkFHD6R4xHqKt
X-Gm-Gg: Acq92OGSqaWxHYpeY9GhAjW8GtQRcOGGAqlhZidGXLI835N2lE9r9/tfiZqlvCtut2b
	zU4nSczCQUDsg4Aq/+5tUtd16ciHca1RiJ3rAmc3SA8qPZ45JD9OZyJrhqAS9llrQLGEpRjZX0M
	kpYh/hAl91/5LbVGo/g9jHgcYkxsR5I7oTfYUDKrZ0T7RW3qYo/Joq1/5oMs3X+FmOY7yjJTPhJ
	4n1KoL/OFp/bqqdiJ5vw5AQoOq/rUnm/owVZSj97ld2mXigK/CCCgAL1e7PFNR85Ob0e0qEYdug
	efGRlitVuA1suJm6WHWV09VZzATi4f18JDLjUJwM/UePvUuUo247/6jlT+r0nJaMGqCC99ylrB4
	H5BpOiJt2DXfN3bzcNgmOwcrnf6RLdlSG07Ar3VvFjxGy/SIHuJKK+8+XHSfBnDaaB3lUH+81Wk
	Fb6CTCYhNdZb6j9G+838TtNBKzGMmCDnxKI5OZ
X-Received: by 2002:a17:907:a01:b0:bc7:73f8:9f50 with SMTP id a640c23a62f3a-bd517acd34cmr149814966b.42.1778834112598;
        Fri, 15 May 2026 01:35:12 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:a66:143b:cd2f:c4ae])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm189493566b.32.2026.05.15.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:35:12 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH 0/4] mmc-utils: improve lsmmc usability
Date: Fri, 15 May 2026 10:34:53 +0200
Message-ID: <20260515083457.3690804-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend the lsmmc usability updates as an ordered series after the
previous submission could not be applied cleanly from patchwork or b4.

This adds external manufacturer ID files, accepts /dev and /sys/block
paths for register reads, adds an mmc list command, and installs bash
completion for mmc-utils.

Torstein Eide (4):
  mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
  mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
  mmc-utils: lsmmc: Add mmc list command
  mmc-utils: Add bash completion

 Makefile           |  11 +-
 completion/mmc     |  62 +++++++
 docs/HOWTO.rst     |  77 +++++++-
 lsmmc.c            | 434 ++++++++++++++++++++++++++++-----------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 +++
 8 files changed, 452 insertions(+), 178 deletions(-)
 create mode 100644 completion/mmc
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

-- 
2.53.0
