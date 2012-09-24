From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mmc: sdhci / i.MX esdhc buswidth patches
Date: Mon, 24 Sep 2012 09:22:22 +0200
Message-ID: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43458 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab2IXHWz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 03:22:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, kernel@pengutronix.de

The first patch is a generic sdhci driver cleanup change, the others
are i.MX specific, adding 8bit bus support and fix version register
readout.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      mmc: sdhci: rename platform_8bit_width to platform_bus_width
      mmc: esdhc i.MX: Fix version register read
      mmc: esdhc i.MX: Support 8bit mode

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
 arch/arm/plat-mxc/include/mach/esdhc.h             |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   77 +++++++++++++++++---
 drivers/mmc/host/sdhci-pci.c                       |    4 +-
 drivers/mmc/host/sdhci-pxav2.c                     |    2 +-
 drivers/mmc/host/sdhci-s3c.c                       |    8 +-
 drivers/mmc/host/sdhci-tegra.c                     |    4 +-
 drivers/mmc/host/sdhci.c                           |    8 +-
 drivers/mmc/host/sdhci.h                           |    2 +-
 9 files changed, 82 insertions(+), 25 deletions(-)

