Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07921D5B0
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169899; cv=none; b=nqchix20+0R72QQ3IaTj5uRXfLFGZDjNxJyXUtQ9J44ZUtHH6R/MimPpQiJK4TQR96SnSUASAPogaF+djNB4fkzXZLRtsPR2PZYdvlBDay9bYIUuDPYQQsCNLCH8JGRBDl9qAjfdVBnziP/BjLH/ixLDmsXwbFP0iegJ44RUvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169899; c=relaxed/simple;
	bh=Lp3o+tSy/M7+YG04tdmmfMV1cyXU4R6LEZua2RNI4+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfvuT9OXfIRPutbJIwPXLHTimG4HNuECmE0dYrqcj8V3X2RrjRW6vk60Ypu7BOUvsb/GT96j2xvQApMG+WY+8NPImoDVvqmJysi7EuKMY/RmQ1zl5fwGu5GsAwS0pFCce5li/AXbpsymiB45wouLqnw0EDmw+vNoqVCfSNuKvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3cP3R+7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3cP3R+7"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59de66fdb53so575641e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 04:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769169896; x=1769774696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goSO9cwNRkNHcU03Rct2+gTP+3bOWRDA8ejCpOj4Uq4=;
        b=D3cP3R+7GwTIq8JjlAQSm5zYtdYUFp/hJez/t6Hw+UPiNULLkmh7aVlDeyvm0cw+dq
         adCHImnxGvW24TA6SsNT4/Wa7fu6kapedTkblxCwxfsbI/lbBykiFOEMkqcuirLc2/OM
         4eU57BBIuxKkQ2ps6y+1HYSzQNl/H6lBklSMbKNCcFeoyeP0pMjA0xQbyaI99Ftm6WIu
         5OLF9ETJFY3i809hoX7QBxZrn61S8I18WFw/FIOEl3qAYQeJk25S9nZynzn77iTGtXDU
         CpR4lCBVxhBQ7bGKnVKio3BsrLlPxJ9adKfOzaE2YsAYbxoZUK02CFmytSvm7dM/lbZ/
         AiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169896; x=1769774696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goSO9cwNRkNHcU03Rct2+gTP+3bOWRDA8ejCpOj4Uq4=;
        b=ArYgRqNK2dILf34m4DU/bT0OTnQW5HkDAezwbNkQ6JuvVUYL8Dt0JnB92yfBr/qfiB
         4DDadVrh43FvrC064USx3zfxSaclt4ERuDGxkf4MvgDA1yqY+6v4k1w3oFwD09do/Rsy
         iRVDFz4NudhT2v4H4dyztQnNCAcEP/fSvl8sk2VsAOGr6yj1y4qfRakhZy/w+xdldfFG
         q7eiFvUG4Kty2RU+tfT/jYBqGxonjLlGpa1oWxN6JZAcJ7Dh6/VPFzExeVrS7XEw4evB
         SafrFquxfvoEXsbNZCxWEpjnIm36a2Br73r4g7FRDD5t3umzKsE4yDWLZrHFx1IfUCAK
         gK+w==
X-Forwarded-Encrypted: i=1; AJvYcCXAl5KO3PiiXImzyemR4cbdkPeVzsatOLaJK6U1gXzYoQwDAcx4DAu38fLhpeOYf6kPNyseIqIG0SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQpQ1cBor4SI7nicXSdGX0mBw6LPRJ3VaHyHt9a7P9G9StfxP
	9dlTUeSDHw1w6aThSroyVaY8VzxBmg8iofxlE+dB/7aVx9mSAa9E7hn8YXctohs3ecY=
X-Gm-Gg: AZuq6aKhuUF8p2jhFrNtihmUSrt6GT6TtLGlCiswrxOkA2nLo2S9L2ti6JyxDvRGnac
	eQflfMKMl4P84plexj6OrfV9gB501WRUHE0qqOeLLa//WOEOHUtjg870/0FYDNSy2TGd/yf00RM
	MVMNcuvlEO0wqRmeA0G+Uzrcv4y/0CMDpJ7+8yv2iG8Icz6sat+lS5ezBSGqs3G/mJjk9e9bADD
	AO6TYTGHeeXBEcdbpvBJ39YfLXnDFkrxp5pZt0kFwV2qHEKy3jKq7Gm/l4H723L2Ju+zHnKaJzB
	Eqn/E1Iy1luC6p/jElof+oOsb5HRvniAs8Yrzt6AqHws5diykmS1xEVuZNW0WDBIH551jeQw/iy
	dPnlEGoxLEJsUQGos9ah54fd1MI/kwhZ4Fi3hqAYXJwMPAiYMsRyyBYWvMApnyOZpExzFGv0ahc
	g1LDl2FhCdcKFbGxNfTPSCau8Y+30cBDj0uqVVm59WbBbOhIklEKOcAQQCN3NE
X-Received: by 2002:a05:6512:10ca:b0:59b:6f90:4a2 with SMTP id 2adb3069b0e04-59de4905108mr1033601e87.16.1769169895794;
        Fri, 23 Jan 2026 04:04:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de49287e1sm623349e87.95.2026.01.23.04.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:04:55 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.19-rc7
Date: Fri, 23 Jan 2026 13:04:54 +0100
Message-ID: <20260123120454.244414-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v6.19-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc3

for you to fetch changes up to 5cfc828502cbd0c827113bdb5694c2658af2c37c:

  mmc: sdhci-of-dwcmshc: Fix DMA 128MB boundary for Eswin EIC7700 (2026-01-22 13:26:08 +0100)

----------------------------------------------------------------
MMC host:
 - rtsx_pci_sdmmc: Fix signal voltage switch
 - sdhci-of-dwcmshc: A couple of fixes for Eswin EIC7700
 - sdhci-of-dwcmshc: Fix support for HS200/HS400 mode

----------------------------------------------------------------
Huan He (2):
      mmc: sdhci-of-dwcmshc: Fix init for AXI clock for Eswin EIC7700
      mmc: sdhci-of-dwcmshc: Fix DMA 128MB boundary for Eswin EIC7700

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode

 drivers/mmc/host/rtsx_pci_sdmmc.c   | 41 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++++++
 2 files changed, 55 insertions(+)
