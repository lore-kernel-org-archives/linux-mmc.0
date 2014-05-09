From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/1] mmc: sdhci-esdhc-imx: fix mmc ddr mode regression issue
Date: Fri, 9 May 2014 14:53:15 +0800
Message-ID: <1399618395-359-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:1487
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751298AbaEIIH5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 04:07:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, shawn.guo@linaro.org, fabio.estevam@freescale.com

The regression is caused by the following commit ...

commit 79f7ae7c45a6ccf04e2908337461dee615f6afb0
Author: Seungwon Jeon <tgih.jun@samsung.com>
Date:   Fri Mar 14 21:11:56 2014 +0900

mmc: clarify DDR timing mode between SD-UHS and eMMC

This change distinguishes DDR timing mode of current
mixed usage to clarify device type.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Chris Ball <chris@printf.net>

... and the line below.

@@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
goto err;
	}
		mmc_card_set_ddr_mode(card);
-		mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
+		mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
		mmc_set_bus_width(card->host, bus_width);
	}
}

It's caused by the platform driver was still using MMC_TIMING_UHS_DDR50 for MMC DDR
mode which needs update too.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Reported-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b841bb7..16e4219 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -858,6 +858,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
 		break;
 	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
 		imx_data->uhs_mode = SDHCI_CTRL_UHS_DDR50;
 		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
 				ESDHC_MIX_CTRL_DDREN,
-- 
1.7.8

