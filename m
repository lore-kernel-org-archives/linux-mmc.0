From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/7] mmc: sdhci-esdhc-imx: remove duplicated lines
Date: Wed, 3 Sep 2014 20:04:57 +0800
Message-ID: <1409745903-26550-2-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:17627
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932185AbaICM0w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Sep 2014 08:26:52 -0400
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

There is already the same register check above, no need the later one.
Move them into one place and delete the later one.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 587ee0e..256c901 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -315,6 +315,11 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			data |= ESDHC_CTRL_D3CD;
 			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
 		}
+
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
+		}
 	}
 
 	if (unlikely((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
@@ -335,13 +340,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			}
 	}
 
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-		if (val & SDHCI_INT_ADMA_ERROR) {
-			val &= ~SDHCI_INT_ADMA_ERROR;
-			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
-		}
-	}
-
 	writel(val, host->ioaddr + reg);
 }
 
-- 
1.7.8

