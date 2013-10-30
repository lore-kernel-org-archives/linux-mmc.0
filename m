From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 0/2] mmc: sdhci-esdhc-imx: adding eMMC HS200 mode support
Date: Wed, 30 Oct 2013 22:10:40 +0800
Message-ID: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:43757
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752763Ab3J3OaO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:30:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The tuning in latest tree is broken.
This patch fixed it and add HS200 support for imx usdhc.

Patch 2 had been sent out in:
[PATCH 0/7] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr not supported on sabresd issues
No changes since that.

Dong Aisheng (2):
  mmc: sdhci: replace msleep with mdelay for tuning
  mmc: sdhci-esdhc-imx: add eMMC HS200 mode support

 drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
 drivers/mmc/host/sdhci.c           |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.2.rc3


