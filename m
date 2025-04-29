Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF426A0A6
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959568; cv=none; b=XqTAiRMuoPZG4iPmgqlNx9spz6WxSY4PIZ/mETN6NQ5smQwMCc8ZUP/LGPOcwRhbtAU8h0khkF6Rxx6VVS0JsUwuU+pcg1fDvKy4N4/5DLtBKX3OAwXKDYrwD6286uWsQKEJkUf82Vaw75EYzP+bGyPQMBGQjotXp2Ha/HtCK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959568; c=relaxed/simple;
	bh=b1i7Oiq8VFHbbF3djLlZfHnEoM/NeUuDRhdh117Z1bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2TO/Otg8U7oC5zjYLMpQ0vTdRTkmg33b7HEpKKpntkNfw2eiRUp+cb9LLxgKDbGYXDJN2FcqinZ1Dl8/mGJPqx2x9dZlLwL1N2SPXkIluLRfJGDw9oVkJkBd44K0I8SAPE75nmmME7ECd4beUEvBjQNSPcj1XalboDxSPuKR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8WkTGHC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8WkTGHC"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54d6f933152so8790108e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745959562; x=1746564362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/4zHTkk4RA8Bdrk3b8sTr8Stn91NAdSB8LOZDVLuso=;
        b=j8WkTGHCBgK/wxLfbrIW9qzgP4bhY+KMLnppVla0k9JRyQXGe4HXj+rwblwMXFuJFt
         QwWgmVSrw754SK8MYE/QtC8u6tC2S2CHSfERpY6tO1dUUWOF05bf1HudiiCwwGvE7eL9
         gxsqDaWPXigg3bkrZxP7Y+B9AzdN78F3W9PqGiT0kC/h7/lDGfDjEpOIny3lqz8U+nmC
         DkBpKToeqkyndSwyzMzxZq62G/LpXFNmHpj0g4dwihI2RcoVKYAQ2Yiz8EW98KaUmxNP
         ngJYdErVZ6NP0tRXu6C+HWFCZ45yz2j5T4sbDeJKsDRdpiUXYNuOcxtvQC4CRlcHiEFL
         5PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745959562; x=1746564362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/4zHTkk4RA8Bdrk3b8sTr8Stn91NAdSB8LOZDVLuso=;
        b=kuiYLzAyn7eKPrektElpDEmc/Wj00iXG5sZf2TLcRhORYd9wzRZfDnDTLTXPZZgCsH
         DFjFIbw+HZfRALC0+rqCP8Kmb6ph6FuaRZd95INSsjXoSQQ1rRrwv/ws41ev14dFtH7w
         g5KiwK2abgkZU5BQk0mWD/WfxG7tnNnhs/wa1EI4StB3hzEX4QzjCAhJq9b6U8Wd6+W/
         BjDAK1jceKa0+KtiBq7yKrueTYfe+/ZmGM8LGN5oV62KQ76+pnCWOH4UEDlvfd59/r3T
         ppbSRQNM6kMbn3EB5qyX4ws6alGa9EoNTEk/xqIAVX/OAgmjJ47HYU7/jW5FOR9bvbJe
         j/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUh4naXk1I80IC3b+cIGG2FASY284+jdxuKjn1mVDpa6RudKOGimGjUiGOjbEROrAgS4pLWebGbcsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6uRsFhGAc8a8DiAwaswxBYlEawaUbe5taYsxQp9ePvNhqWEE
	GSI4bwh5VcOZX/MePYZ+IaKNAvSvG4TUOivxwSgpkqa8fVsr2fT7bO/e0alPFjM=
X-Gm-Gg: ASbGncvNSOwYYqb/OEBSdSEI/sPXM7hFmxbFu6w0dV3f5O2UKppBDF3fdD2hxRTFImh
	A+um6+pPygKONDLtznivZPKxvgOwvCN9hqjiZ/GAr2n02V7b+uxSWQRh0b5APOzPVSM2WNJDJoN
	dvx83Sh3MrtKcsAotGBLZV45Ur5jjwOiJfLc0MSYUVZXjlnCLzQnax0Fm1p0KWVjTVV+k5CJEyP
	ZjZJRup3yxjC8OfQIl1BDEJvxzmrm9tYBnPlnOtgHyI+4SxXTHNHnUyX068eBOH9ZHvCjh0Xbxg
	ixjTvWQZUq3gzhz4xNVm6XlDSUEyrphFUednQ8d5moFujClfIcyiUgETXHV1JUHqYNDghPxGJ4x
	a4jPt5tNh9CX8DA4=
X-Google-Smtp-Source: AGHT+IHPYjzimBIFPkgeGK9SX48JxJc5HDD75O9G5aYZLS5ww1nZYuM142Ib3m8L89hZ9aqiC7cKNA==
X-Received: by 2002:a05:6512:401a:b0:545:4d1:64c0 with SMTP id 2adb3069b0e04-54ea3ac85admr25479e87.27.1745959561913;
        Tue, 29 Apr 2025 13:46:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb262b5sm2006777e87.36.2025.04.29.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:46:01 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.15-rc5
Date: Tue, 29 Apr 2025 22:46:00 +0200
Message-ID: <20250429204600.176542-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.15-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc1

for you to fetch changes up to 77183db6b8dbd8c352816030b328dd55993dc330:

  mmc: renesas_sdhi: disable clocks if registering regulator failed (2025-04-07 17:58:41 +0200)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: Fix error-paths in probe
 - renesas_sdhi: Fix build-error when CONFIG_REGULATOR is unset

----------------------------------------------------------------
Arnd Bergmann (1):
      mmc: renesas_sdhi: add regulator dependency

Ruslan Piasetskyi (1):
      mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe

Wolfram Sang (1):
      mmc: renesas_sdhi: disable clocks if registering regulator failed

 drivers/mmc/host/Kconfig             |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)
