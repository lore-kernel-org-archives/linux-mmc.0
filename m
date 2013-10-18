From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/8] mmc: sdhci-esdhc-imx: add std tuning for mx6sl and DDR mode support
Date: Fri, 18 Oct 2013 18:54:13 +0800
Message-ID: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:42930
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752946Ab3JRLKl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 07:10:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The i.MX6SL supports standard tuning as defined in standard host control spec v3.0.
So this patch series add std tuning support for i.MX6SL.
(NOTE i.MX6SL can also work on the old manual tuning mode as i.MX6Q/DL)
In the meanwhile, it also adds DDR mode support.
Then SD3.0 cards which can only support DDR50 can work properly now
with this patch series.

Patch 1~3 add stardard tuning support for i.MX6SL.
Patch 4~5 add DDR mode and delay line support
Patch 6~8 some other related minor fixes.

Tested on i.MX6SL EVK board.

The patch series is generated based on the latest mmc-next branch with Shawn's
(1)[PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type in Chris' tree.

1. http://www.spinics.net/lists/arm-kernel/msg280517.html

ChangeLog:
v1->v2:
 - Only a few minor changes on patch 1 and 5 based on comments from Shawn
   while other patches have no change.
 - rebase on Shawn's patch series
   [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type

Dong Aisheng (8):
  mmc: sdhci-esdhc-imx: add std tuning support for mx6sl
  mmc: sdhci-esdhc-imx: fix reading cap_1 register value for mx6sl
  mmc: sdhci: report error once the maximum tuning loops exhausted or
    timeout
  mmc: sdhci-esdhc-imx: add DDR mode support for mx6
  mmc: sdhci-esdhc-imx: add delay line setting support
  mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
  mmc: sdhci-esdhc-imx: add preset value quirk for mx6
  mmc: sdhci: remove unneeded call when have preset value quirk

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    5 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  134 +++++++++++++++++---
 drivers/mmc/host/sdhci.c                           |    4 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |    1 +
 4 files changed, 122 insertions(+), 22 deletions(-)

-- 
1.7.2.rc3


