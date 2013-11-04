From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Mon, 4 Nov 2013 16:38:24 +0800
Message-ID: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:5602
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab3KDI6f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 03:58:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org

We disable root clock in runtime pm to save power.

Patch 2~4 are some fixes needed for enable runtime pm or it may
break the UHS cards(SD3.0/eMMC4.5).

Below are some tests result i ran which passed mmc_test tool after enable rpm:
SDHC UHS1 on imx6q sabreauto
eMMC 4.5 on imx6sl evk
SDXC UHS1 on imx6sl evk
eMMC DDR on imx6q sabresd
SDHC on imx6q sabresd

ChangeLog:
v1->v2: only patch 5 changed. Add pm_runtime_set_active
	based on Ulf's comments.

Dong Aisheng (5):
  mmc: sdhci-pltfm: export pltfm suspend/resume api
  mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
  mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect
    other bits
  mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
  mmc: sdhci-esdhc-imx: add runtime pm support

 drivers/mmc/host/sdhci-esdhc-imx.c |   81 ++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci-pltfm.c     |    6 ++-
 drivers/mmc/host/sdhci-pltfm.h     |    2 +
 3 files changed, 74 insertions(+), 15 deletions(-)

-- 
1.7.2.rc3


