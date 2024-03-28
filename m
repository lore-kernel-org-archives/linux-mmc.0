Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE057E591
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628395; cv=none; b=D9/kEYolrc74/GEEKA8KSd0GxW/fFO8KaT9Zk7tyOQAcubeaMwbMzEdMeZ7LUffS/eCcxBfGU/l+71q9G5x7gBT6Fbv9KHubm1L5KdLatKFBnPjq9pXXoXWbMJTfJZol6YiGCtziG3heUAvzrQBn/AZ234RB1s/ZWgvNaGH9lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628395; c=relaxed/simple;
	bh=8OC7F9NrLDAVSOLY/GxL9SqlSdsWf60EqN4CyPvbhBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nllnszvb/FBwbcHrYzhiMQpCbMMxsFKOSbuUfY1HbrkR65DaOk0suumtrb3SpI7g5/FWdeFLjio1i32JIKYIq/Xm2lS9y7bQgVREsFYB8jSNxeB+ZpPVnR57crwz/dgcT7BcvMUAC6vTVaRKJktUW2wsfCRXHkHnYtorT/qg/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afww3YBh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afww3YBh"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so10494781fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711628390; x=1712233190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ59ZV3KPsH61i+BFxMy2xWaK2/DKTLO7TLG1i3fEPc=;
        b=afww3YBhCIsTndJMvbQBOAh68Bm9jscthsoQxxvIaRuTRADXLYHjA9oBmb5jHQRTN3
         vA3dhe/rKNJ6q7ESxNk7Fj69aBV/Wd5zfDoMR0EgkFa1JAo72Gb40sGScpm1mHyZNb55
         K5g2nrQd+Y9r41KwfOjRjblU1iMPeqZRYuwfSPSVEihzPvIg+Z2VJnk92s5BZyMF9H3B
         cc7xi9VRUz0y48dAg6YNV8mtJXRTp0AYoBF8Dkpx3JmG0yoBKaicQ6+vinwOGQfJpVtc
         g4e2hjapVbfJ00H1tf9dEu/3VgZpiuWUotdNmKZ7hQ/tdDPAb+RLaDKdgDIC+SknbfB9
         TUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711628390; x=1712233190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ59ZV3KPsH61i+BFxMy2xWaK2/DKTLO7TLG1i3fEPc=;
        b=YOSrjVtl0k3OPf0Hvm5Do2Q7A/6pLMxH0Co62hSI5aWnZkLgWXcLDMlAW5N48GERcH
         +nrOX9MabCMUAT6GxfydZBdCh2raaPoc44+4UMXK/SURY+gdbKaX4XbyJHVd18SDXzqY
         EVGWCC5JFaqb5UBlGHYd0TnbgO7PTe2xmG+o6diRx/1TE/6o/ENM7AvUtCxdrDsI+Jox
         R4IMieevpPI8Lx7+CYxvCK03qXi6zcQdB8hC73OwAzloyFVUOQVj+aGjCAXWOIN+vgI9
         VjnP2cGhwKxy0z8XOemZJvMDitoZU8V1aUa3b8XwErlSAcQCsLyJu0pAyEvcJyyXxfwO
         603g==
X-Forwarded-Encrypted: i=1; AJvYcCX7egF0S0rU+USfGUv4JmUpFub4M4FnHKk6r1/NXLs+/HHSZwuFPhxYcjXYk2eptb0zTRcsVOBxmVrEQYYF7ZM3Tlhd8iExD+RE
X-Gm-Message-State: AOJu0Yz3RBh/1DKCdXJ53wAc04aFy78jym6Ljw+mYbkVszUwznRJjuaF
	EpPFUISrWWZeKrIxJEiNR67F5MvEslQ7385AJZn5k5rj+M4SRAgHuFHmyM5b2v4=
X-Google-Smtp-Source: AGHT+IE5kTiwn0boBAb+g9bwIMv2CFjPpN/NZUh/cWHgxep/P4SsFHtV0a7s/GhSXkBxUMdOr7WB5w==
X-Received: by 2002:a05:651c:2320:b0:2d6:90e4:1ced with SMTP id bi32-20020a05651c232000b002d690e41cedmr2267038ljb.22.1711628390399;
        Thu, 28 Mar 2024 05:19:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b002d494896784sm209411ljb.55.2024.03.28.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:19:50 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.9-rc2
Date: Thu, 28 Mar 2024 13:19:47 +0100
Message-Id: <20240328121947.2533033-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.9-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc1

for you to fetch changes up to 03749309909935070253accab314288d332a204d:

  sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove() (2024-03-25 13:12:46 +0100)

----------------------------------------------------------------
MMC core:
 - Fix regression for the mmc ioctl

MMC host:
 - sdhci-of-dwcmshc: Fixup PM support in ->remove_new()
 - sdhci-omap: Re-tune when device became runtime suspended

----------------------------------------------------------------
Liming Sun (1):
      sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Romain Naour (1):
      mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

 drivers/mmc/core/block.c            |  4 ++--
 drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
 drivers/mmc/host/sdhci-omap.c       |  3 +++
 3 files changed, 22 insertions(+), 13 deletions(-)
