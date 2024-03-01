Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BE6A8C7
	for <linux-mmc@vger.kernel.org>; Fri,  1 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287662; cv=none; b=QLLPM38oaQSt2em5YNnZB1+2Z5yKgoWczjSwmaVWQqCVv5HL31e89q0FgAOnt+b6cZoKVNa+fKpfOv+F2tgblcNELqKBBK7vywjOpq3VRVw3f1Te3XLTwJ7boYuUr3KiVmjFXjOGH7KILSFofPpjwX+mUj1p06BH2hbv24WRMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287662; c=relaxed/simple;
	bh=T+CeEodRAGx5wTa5V2kHse2MzIoJ34vXtnubphzB1Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlOuz2WlFLPHAE6hy7F01kRCj6I8y35kvMNRQK868+VAqstaEs0TEZjxK/5ocuvlPvloiR7nj892HWe1bPGfp4v7iT7MpyAoJFvmzVZ7Fg1HCdKlMCg9NchEtxuGpWzVJi2kWOxWsivxPcJ/hwx1IPUIzpKq5fP3GVYLz62qlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgSscS3S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgSscS3S"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1999780e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Mar 2024 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709287658; x=1709892458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUPZXtRPhnydBr3X5VYxad+Y/Ik9MF6OjDOuWG4R5Aw=;
        b=kgSscS3SLgJ3mLjYQkAMwK54ruVzmgkJrXjReySkGX3F0OjHpOIdHPPSudKw7d/sYe
         lZFcrxg6mgdCzr93kmvvr5qdfYQSdDb0qBc4/RpAw2UmtddAy68dWcOaAefNpyNIOVCp
         pkWeaDtHA2CjX5OZwuh2zPwXnc9O7SihFx9jB8JbAs2bmWF611LCDsyPobKOQvgjqVib
         U9Yf5+mi4ckX2cZ0UwJXUFRcyEbgxtMyBN7XBlkUDx+3l4uy0jrsHuoueJBFXl1hHRzH
         WiBWh5+gE7SojNh/fH7ssBiGxzfJCq5C88SvEqZk8+vqk0pCGSXsgmunjeu6f4AlhJvu
         hdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709287658; x=1709892458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUPZXtRPhnydBr3X5VYxad+Y/Ik9MF6OjDOuWG4R5Aw=;
        b=fRpB2Zxm4jNi8jeFIcMcYJNPhb2UX6KRsEuNRXtZLEPbwq3uUR9X6QtzuWKNn8QkrZ
         ODVVoBXYV7ysE8jzia12xuuAsY220ckpE64JiwkLt7SLP65etoCKc2uBJ5ohFyyRKbt3
         ea0jJPvBxrTTbaVO5IZ1A3rI2i2rsnuCsdns/f2yPm3PQwllht366+jq4mqy2V6bPWJ9
         n6Wge55wnM+XCx5RNIUJUsyNAgtSNpqLBChNfNj6GJqRLKHuiRmTWFIQtXit/Iej6+kT
         XwXnbgir00RtcxKmvZdbH+YnfB514ruinmz5mS0ARMIcc0p5Xd8pRkCo+zODf3ATHdzD
         5+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcBrfcwMxKHyPtVsl8xWPE2duMnp05wieIdqcjKYYq/04ScRh8ixqXBWVN9iDdTfk3uRdfkra+tdsD3mtqrwSYItiWuNaS9Lx3
X-Gm-Message-State: AOJu0YzLEogPWx7yKQMQiN5Nw+LGkOfRRDqEwb4gnjKN4B0kFKVj7p16
	+NAwJLcZWH62ueUIcvDmQf+jpIyhAAxqXzE6gManOzq+4zlK9yWdJViQZYxYAcc=
X-Google-Smtp-Source: AGHT+IFEV//EQP+uWHWDC+jyQET8gGjbngKP3FkjLTWfTZ2DjXgwAipWjK9lrHzmTVgLCnxZW1E4XQ==
X-Received: by 2002:a19:ca57:0:b0:513:201e:cac2 with SMTP id h23-20020a19ca57000000b00513201ecac2mr888999lfj.21.1709287658414;
        Fri, 01 Mar 2024 02:07:38 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a3-20020a19f803000000b0051323e9be6fsm565934lff.213.2024.03.01.02.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:07:37 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.8-rc7
Date: Fri,  1 Mar 2024 11:07:36 +0100
Message-Id: <20240301100736.3789777-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.8-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc4

for you to fetch changes up to 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129:

  mmc: sdhci-xenon: add timeout for PHY init complete (2024-02-28 13:41:35 +0100)

----------------------------------------------------------------
MMC core:
 - Fix eMMC initialization with 1-bit bus connection

MMC host:
 - mmci: Fix DMA API overlapping mappings for the stm32 variant
 - sdhci-xenon: Fix PHY stability issues

----------------------------------------------------------------
Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Elad Nachman (2):
      mmc: sdhci-xenon: fix PHY init clock stability
      mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

 drivers/mmc/core/mmc.c              |  2 ++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 24 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon-phy.c  | 48 ++++++++++++++++++++++++++++++-------
 3 files changed, 65 insertions(+), 9 deletions(-)
