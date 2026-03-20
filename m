Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB330594F
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003649; cv=none; b=D3mzuZAPUMJ2uMkXJh62XVhH3et6w3iMCe4L1rl+ETqxAlpqwrml4MLmdUYByzO2SIN+H6V5TZKaZUvtp7mqU1YM3xqn9zVlzTugegILb9yr9B31eFq5JYcu2JokvAy2crcRq0vBN2LtGTzVfmBVuVPu1T1DGuEWtIBjYiIZXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003649; c=relaxed/simple;
	bh=BqB6IhOpppv/38rj/kAQMySj/dBLdqi05G20q4IaUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIt+whCFC2nVQ4ipIGfmzzRRzgHDdQgWECUzvgWmCqgdBliyEAAmO7APbzmnJJvQXdHrqVtOpoPTYysJbVyVqECSLfoH+fEYoO49vK2hXY4uzlBsQoC3129r80NvJmRwDSsJu1BwGoezYQ2x39IGIm/N9QAzLIkzFFH57qXTEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z200e+m6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z200e+m6"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so1327523e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774003646; x=1774608446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5o1nE04l/AcCDXlX/hHJ6EMENyH0Y4hW2L4dBTraWU=;
        b=Z200e+m6LpZuZS6lBR9V8Jnco80ee3Vapm8llkIie1+XZeT9MxadH0ABkQVqhjdwEH
         uaR/oh71Q8chJWYHU53Nx6CXYIkHswlzboDHKe6lJPFOYpwL3ILs/yj7SI0Oqci1XFj9
         yX2DMaaXQsrlvdrAjVjNY3zBdzxHzQo+hJvP6uKT5IOwdGt4z2v0tVyMYoe/U/L/9fgL
         dKKw6A8dxopHmM6CpQC2hK+RgRob9rHP3WoE9D5aZPar/ERZO81ImtL6Dqk6uFXSzIm4
         o1WZDKSz8W8QcKqgtirmUokX2MjT8RsF75vXtMG4J9JlhIE6zdJ7JuRiyPEZ9gJomQz3
         Lugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774003646; x=1774608446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5o1nE04l/AcCDXlX/hHJ6EMENyH0Y4hW2L4dBTraWU=;
        b=rM36ZMmG6MtbWCLN6HAcFGdQ3ly8qnlv4ELr1wgj5Pp+4ifswGXT6/yijouuuXhhXz
         dRjrVa33hbCeghgTRALmB19CQRDDl+7zEqvZVkxMK9ShOjGNP+sCZcIjKDgz0Q79Kqgu
         ICrBCoEnImY+Qzz633v0Fd4GR7lvVABB9FccbjfzLZgSZ00LQyKHyjUnIrnSTKqmpjcC
         5ZPhovexO7biVbqq0S6qvWtjci9BGBwOqxJxuXvW+veMNfBnkQYthR/p2d8vEszc79PK
         D2GykyQSpwEze3hZoVQWDD+DF23bbOTfoH6G57ZlkX189isZhRCfs0XF4CS1gI6uEJ7y
         p9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqVOPA8IHApAmus6jROoJSFpqhJaH41QRpqMFsSAZ6WnbRu7MedEvyKtngbQZrkIc2ECkFoyuLIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GNNp7YsHgce6yrcsQ2i9odtssvwAZ0oI5fdeSEKAfL4mNhHv
	y59sVKliJ+n48oSnPh6HYRaW09Kh2qkLupBJrzLo+JV5jXIeYTVTZYhZWvtnqEd5FnQ=
X-Gm-Gg: ATEYQzxPoLsY4yQxRDOBrBq7OM929K7Uw0lQ5gE7OM+uZsI0VEmNPbc+k94TwJ45r6K
	K5aOGlcsoPSKHOb4cH4v2i1JyNaQ74vljkZJWqeBD/S6zKt2507oy2egZRsmvDqWwtLVvIXhQMV
	L2YjhKf45+68dmGQkF2kgZSzeXGZX9MhRdsWSU0j6KWquf3/GDXEP/2ZjY187WHORZcjjTVKvyZ
	kOFo0PQNPcYncQ1EUx2DoKS56tvsBQq6yQLGaONsrNflc2TegSD3fRmj9uqoLArwOFpvuUAvJeC
	YpOkgpDX2D5oGTzDDPTVfeHT7udwyaNJgWFngIabskUiJs6dGzoukRsrdO46MhJwzym1aXI1Mk6
	pkL5AfMa4CFPbnUI1pw+RrD2vec4xQSEVt00mVGGYviH2gIgyJW44RsKq8qWMN/ndAVqjcU+Mzz
	AhXqYAChvb2ijasqv8B10zmXuA8IL8R/x0/q0zQeV0G5SKsClPsioyj7QBRBrYKqh/aedDxVb/
X-Received: by 2002:a05:6512:402a:b0:5a1:3fa6:8c62 with SMTP id 2adb3069b0e04-5a285b54b9emr884819e87.24.1774003646289;
        Fri, 20 Mar 2026 03:47:26 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530bd55sm455578e87.72.2026.03.20.03.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:47:25 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v7.0-rc5
Date: Fri, 20 Mar 2026 11:47:25 +0100
Message-ID: <20260320104725.2043499-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.0-rc5.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 901084c51a0a8fb42a3f37d2e9c62083c495f824:

  mmc: core: Avoid bitfield RMW for claim/retune flags (2026-02-23 13:45:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-2

for you to fetch changes up to 5e3486e64094c28a526543f1e8aa0d5964b7f02d:

  mmc: sdhci: fix timing selection for 1-bit bus width (2026-03-16 16:08:54 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix timing selection for 1-bit bus width
 - sdhci-pci-gli: Fix DMA write corruption for GL9750

----------------------------------------------------------------
Luke Wang (1):
      mmc: sdhci: fix timing selection for 1-bit bus width

Matthew Schwartz (1):
      mmc: sdhci-pci-gli: fix GL9750 DMA write corruption

 drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
 drivers/mmc/host/sdhci.c         | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)
