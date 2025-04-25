Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50D241CB7
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579666; cv=none; b=ZV9n7Cxa6rY0IXzUaFjBPh8lLKLqipAC71GpBmOk7HB5g/dRMxP1wsO/lO6jz5t6Q0+GX7/B72CyrGDOsdhS3a9wmq0NpXLqU9b9MJWRx7hRldwntO+KIRt3lD7/ai08zORHSDIp49Zn+1IdkF2COLwAqpJc0AZ91Mzw79VKuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579666; c=relaxed/simple;
	bh=MqSP8Z0nXc/8f7+BF/EBoJufCUw7KWFrf+2ELO3mUyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNjVqUgvPtNsSMOlmpz81QQ5qmn7yPAj8jIBPS3FgGdkwm+gwCzToPWBlaJLdOvxtci9VlSv+TfQA0BugLG+mjDb/2nn9iHmptQvsSBRV3ZmAhMmJwYrCgI5wgpLgCnZwzC8/dr9ko4VvUDg7N20owXYZ+sDKIQ63f/v6Vmsqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dn38agaD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dn38agaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LKxsj0nnE+lfD3
	mVQ8izaMHHIpOy8/rQMYt7k5L622s=; b=dn38agaDMahHu4LoALW9s6sNr3NP3y
	WLGeuX1acyIIzU4uaPYGEfWxRCAtLeIaDCqUSoUGY12YZ3sCNjDax1jztVGQMjkZ
	6ydN6OlDCkadPmJc3/1geOFYRiTlK8eOjEe7BMJpiFg9jSBUQ9U8CmqRg2y//7Ji
	wVZF1241/DeTBOCYhbTpMBoFotbo7/flpDhuAEWTL2t/KapTjW5VKXfRQ+2ji6fy
	eGVKnPX66jcylv3Z1FEGcPBiaHH5aOrxOyAOykzO2G5gz7xRiRs3Y4h38aoPLpv/
	pIxsBKLWGl7pIOPb6qp2czFGeQ4UAnztCvwZMDkyDDIEGGRdJ7z9NRgw==
Received: (qmail 3801015 invoked from network); 25 Apr 2025 13:14:16 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:16 +0200
X-UD-Smtp-Session: l3s3148p1@A2dRb5gzWoYujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Aubin Constans <aubin.constans@microchip.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hu Ziji <huziji@marvell.com>,
	imx@lists.linux.dev,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH 00/11] mmc: rename mmc_retune_* to mmc_host_retune_*
Date: Fri, 25 Apr 2025 13:13:56 +0200
Message-ID: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed previously[1], here is the next set of MMC core function
renaming to indicate if an action is relevant for the host or for the
card. Local build tests went fine, buildbots were happy too.

[1] https://lore.kernel.org/r/CAPDyKFpsJpLre2bO9T7gsSthsta9f3JXoXTGZbjTjWVXH47gCw@mail.gmail.com

Wolfram Sang (11):
  mmc: rename mmc_retune_enable() to mmc_host_retune_enable()
  mmc: rename mmc_retune_disable() to mmc_host_retune_disable()
  mmc: rename mmc_retune_hold() to mmc_host_retune_hold()
  mmc: rename mmc_retune_release() to mmc_host_retune_release()
  mmc: rename mmc_retune() to mmc_host_retune()
  mmc: rename mmc_retune_pause() to mmc_host_retune_pause()
  mmc: rename mmc_retune_unpause() to mmc_host_retune_unpause()
  mmc: rename mmc_retune_clear() to mmc_host_retune_clear()
  mmc: rename mmc_retune_hold_now() to mmc_host_retune_hold_now()
  mmc: rename mmc_retune_recheck() to mmc_host_retune_recheck()
  mmc: rename mmc_retune_needed() to mmc_host_retune_needed()

 drivers/mmc/core/block.c           | 16 +++++++-------
 drivers/mmc/core/core.c            | 28 ++++++++++++------------
 drivers/mmc/core/host.c            | 34 +++++++++++++++---------------
 drivers/mmc/core/host.h            | 22 +++++++++----------
 drivers/mmc/core/mmc.c             |  8 +++----
 drivers/mmc/core/mmc_ops.c         | 12 +++++------
 drivers/mmc/core/mmc_test.c        |  4 ++--
 drivers/mmc/core/sdio.c            |  6 +++---
 drivers/mmc/core/sdio_io.c         |  4 ++--
 drivers/mmc/host/sdhci-acpi.c      |  4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c |  6 +++---
 drivers/mmc/host/sdhci-of-arasan.c |  2 +-
 drivers/mmc/host/sdhci-of-at91.c   |  2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
 drivers/mmc/host/sdhci-omap.c      |  2 +-
 drivers/mmc/host/sdhci-pci-core.c  |  6 +++---
 drivers/mmc/host/sdhci-pltfm.c     |  2 +-
 drivers/mmc/host/sdhci-pxav3.c     |  4 ++--
 drivers/mmc/host/sdhci-s3c.c       |  4 ++--
 drivers/mmc/host/sdhci-spear.c     |  2 +-
 drivers/mmc/host/sdhci-st.c        |  2 +-
 drivers/mmc/host/sdhci-xenon.c     |  2 +-
 drivers/mmc/host/sdhci.c           |  2 +-
 drivers/mmc/host/sdhci_am654.c     |  2 +-
 drivers/mmc/host/tmio_mmc_core.c   |  4 ++--
 include/linux/mmc/host.h           |  2 +-
 26 files changed, 92 insertions(+), 92 deletions(-)

-- 
2.47.2

