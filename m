From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v5 0/6] mmc: imx: a few fixes and new feature
Date: Mon, 10 Aug 2015 16:18:02 +0800
Message-ID: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0139.outbound.protection.outlook.com ([157.56.110.139]:29703
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753269AbbHJIP7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 04:15:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: johan.derycke@barco.com, mkl@pengutronix.de, haibo.chen@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Changes for v5:
-move the clear exist timing setting to a common place rather than only in HS200 mode.
-put the patch 6 ahead of patch 5.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  mmc: sdhci-esdhc-imx: add compatible string in bingding doc
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
  mmc: sdhci-esdhc-imx: change default watermark level and burst length

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 116 ++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 4 files changed, 132 insertions(+), 4 deletions(-)

-- 
1.9.1

