Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06521C9EA
	for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137461; cv=none; b=ghGvhfzrgHmh4JMKIWXGq6ES+BweztQtyLCanQLC+f2Fa9c814c2Toae1W5q84j2iyaCsDzmsAwoZ4GqYtL6HBGC5R+zB9dtpTbEnOy4C3ekrYMND1Ap8gMihLVQgBUVK8dI+aJg77gokwruPMmfbjm2B9INc/O4sYxxTGZghK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137461; c=relaxed/simple;
	bh=AAH3gykku4WXMbVa4R4ap3QvBxN1BQpueLp+VgSoMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBW+IXSgi6IoF9zZA/zw+OIWyVGhx6U1RMC3Y06W7lwK9CfKb/iA+ZVtgxSdGtzwXPjrP7jxYcCXbuydp0UFOVe/PZNXEwNDZ3Jqqm3pECg5uD+qVnsUHDG5jRlLXa0/cPHr43axdtINaCEpCviZbjJyjN46hhKm5or/QbyErEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrWCa8Ot; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrWCa8Ot"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594270ec7f9so2018410e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763137458; x=1763742258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFl8EoaueIezYiwgXnmhWkB61WZ82tpzKdrxrqQ73kg=;
        b=VrWCa8Ot3b4lIfhvz7BBEJ0DmJFBmq38Oli3gJErUShZhHEYmnS5vVsHsOGsTO3YN9
         T9lFBqHi3S+8CGFpK6goOQQU9SVNsvYkHexnN/x/JRjgT0CkXQ9YB9yCc3CeBmWwP9Uv
         IKs1PpL3SP+Kio4PpiyKgq3nkDc8C2GjJw8nnz0SqFCeQBv7UZu6pOxWvvpdLXTcWNjp
         Y2Hjp69QCA+qKEdwZiccGnupFwQVn/cnktkTMVfPV+BSIl0ogorYRBiw3mCkCZs484hN
         ACm5Ci0XAI9V1mfYnrobZeej7LysNI8YrojkjDk3yo2j8fsNgXbQ3Rv2kmGt54vT4uAo
         mamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137458; x=1763742258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFl8EoaueIezYiwgXnmhWkB61WZ82tpzKdrxrqQ73kg=;
        b=hRkJcejqaDTFIoscjBujCidk8HrNPTBoAxbzs+sv3yW5+nj3wR72CIQfS6LwQA4bc9
         xOc3kBQf+6BUOMZTdTUPprqlr9aVI52LXBEF1FGCJ/pS6+1enVMMqNAfGop0xNnNV0m8
         2fjAeWGa6DHa8kPmDDGD6dCkuUvLgAFnc6nXlsd4qefU9NKvEmWA7QRxoUgN++5HFPka
         vtTdJmAvMl8A7u5JkbyjUsRLOaWgtioZCmlumgKh6ywEpCoXR852q7+YZSc3aY7eYo1+
         ePYGGARZOMRCwwxeH03mzs7bFaGHyFQJiBK3d2bxIHwnkJM1fDezUEatYKbjiipepTkW
         NlzA==
X-Forwarded-Encrypted: i=1; AJvYcCXR99e0ooM9FGxRx0WLNbjUrW0NFUoBWP9cDYDohuU5YgadsJ4Dh96fYsXYCBOzs/uDTDezc0FtlFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6GDm4Pdg8KGlF8c0jE3G/wtM/HN7Gq2b9c4/tUEncb1et7gD
	3l6279iF7UAPrlbJnyosE7Z8+MVEG1YfuD0iPq77FYqJLEGofyhdGD2os64ZbsfvP/4=
X-Gm-Gg: ASbGncuC4v+l4LKLZ+X4DPrHtsPyF7lsP/FU50busgs+peZkFHgfoRvJroTpAYnRBYj
	N0fWTUcykAP0JysgwuTN/o0gbUyn0wy6vbkxpGdUy9Qs65D1co/2+PX82RSaaf7qSGc32bh1804
	cURQCIIPwreIsz2o5TqxtoVBSsyvzL/frL4+DO9YmpgscJccwU0p5iYmGiae6jC7tMkn2fCTDM/
	UBmiWMB7iIg8sLlL7kO/hC1VtopBE+/iik+Yz+sMlA8tZomxwTaAlNvNT5ZKx9gFno4QjMfDY3m
	oYqGt5E/WJVmHPlxhcxTPGJw59bTPUJuYwDwaNUzLo0TtirQK7DHZNEznKqwzD370LA14RAJiUq
	oZlJtX9cONc0OIxywvBmcZp6dmWBD6mNYO/QStwJ2ImW/VuMdWhaNJ1y7bDX2mlxjNsaJUuDFp8
	Iv4G2dSLxenU4HwJrArgzqnMOzKGGdg9G7Zfgk2A0fmKoeK9xTRE2wiX6RuCzi9RBM0+ullq0=
X-Google-Smtp-Source: AGHT+IF9Z2Bhd5+EKzOjBJ/aic2WvX5TGNHu9hx2ffdNP81iBb/ShYffdMtxKNWwcESFG7CYiChiGw==
X-Received: by 2002:a05:6512:3a86:b0:594:7703:dc5a with SMTP id 2adb3069b0e04-595841f8240mr1203569e87.40.1763137458163;
        Fri, 14 Nov 2025 08:24:18 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803acabbsm1164863e87.1.2025.11.14.08.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:24:17 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.18-rc6
Date: Fri, 14 Nov 2025 17:24:15 +0100
Message-ID: <20251114162415.93883-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v6.18-rc6.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2

for you to fetch changes up to 739f04f4a46237536aff07ff223c231da53ed8ce:

  mmc: dw_mmc-rockchip: Fix wrong internal phase calculate (2025-11-11 17:47:47 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc-rockchip: Fix internal phase calculation
 - pxamci: Simplify and fix ->probe() error handling
 - sdhci-of-dwcmshc: Fix strbin signal delay
 - wmt-sdmmc: Fix compile test default

----------------------------------------------------------------
Johan Hovold (1):
      mmc: wmt-sdmmc: fix compile test default

Rakuram Eswaran (1):
      mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs

Shawn Lin (2):
      mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4
      mmc: dw_mmc-rockchip: Fix wrong internal phase calculate

 drivers/mmc/host/Kconfig            |  2 +-
 drivers/mmc/host/dw_mmc-rockchip.c  |  4 +--
 drivers/mmc/host/pxamci.c           | 56 ++++++++++++-------------------------
 drivers/mmc/host/sdhci-of-dwcmshc.c |  2 +-
 4 files changed, 22 insertions(+), 42 deletions(-)
