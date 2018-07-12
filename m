From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Date: Thu, 12 Jul 2018 10:07:25 +0200
Message-ID: <20180712080725.14250-2-stefan@agner.ch>
References: <20180712080725.14250-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712080725.14250-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

Fix indent. This also makes disable/enable clock blocks look
alike.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index acacd8481473..aa48f4b2541a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
-		host->ioaddr + ESDHC_VENDOR_SPEC);
+			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
 
 	mdelay(1);
-- 
2.18.0
