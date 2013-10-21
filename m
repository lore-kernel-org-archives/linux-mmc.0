From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 7/7] mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
Date: Mon, 21 Oct 2013 22:27:07 +0800
Message-ID: <1382365627-26816-8-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:15410
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab3JUOo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2013 10:44:26 -0400
In-Reply-To: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de, ulf.hansson@linaro.org

Add support for eMMC 4.5 cards to work on hs200 mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index baa27c7..d4ba277 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -825,6 +825,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 		pinctrl = imx_data->pins_100mhz;
 		break;
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
 		pinctrl = imx_data->pins_200mhz;
 		break;
 	default:
@@ -852,6 +853,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
 		break;
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
 		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
 		break;
 	case MMC_TIMING_UHS_DDR50:
-- 
1.7.2.rc3


