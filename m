From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 4/6] mmc: sdhci-of-esdhc: get SVR from global utilities registers
Date: Mon, 14 Dec 2015 12:24:25 +0800
Message-ID: <1450067067-44869-5-git-send-email-yangbo.lu@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0125.outbound.protection.outlook.com ([207.46.100.125]:55967
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752093AbbLNErt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Dec 2015 23:47:49 -0500
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Most of silicon errata about the eSDHC need to be identified through
the SoC version/revision. This patch makes the driver get these
information from SVR(system version register) of global utilities
registers.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- Got SVR through iomap instead of dts
Changes for v3:
	- Managed GUTS through syscon instead of iomap in eSDHC driver
Changes for v4:
	- Got SVR by GUTS driver instead of SYSCON
---
 drivers/mmc/host/sdhci-of-esdhc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 83b1226..9105888 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -18,6 +18,8 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/svr.h>
+#include <linux/fsl/guts.h>
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -28,6 +30,8 @@
 struct sdhci_esdhc {
 	u8 vendor_ver;
 	u8 spec_ver;
+	u32 soc_ver;
+	u8 soc_rev;
 };
 
 /**
@@ -566,18 +570,27 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_esdhc *esdhc;
+	struct ccsr_guts __iomem *guts;
+	u32 svr;
 	u16 host_ver;
 
 	pltfm_host = sdhci_priv(host);
 	esdhc = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_esdhc),
 			     GFP_KERNEL);
+	pltfm_host->priv = esdhc;
+
+	guts = guts_regmap();
+	if (guts) {
+		svr = guts_get_reg32(&guts->svr);
+		esdhc->soc_ver = SVR_SOC_VER(svr);
+		esdhc->soc_rev = SVR_REV(svr);
+	} else
+		dev_err(&pdev->dev, "unable to get SVR value!\n");
 
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
 	esdhc->spec_ver = host_ver & SDHCI_SPEC_VER_MASK;
-
-	pltfm_host->priv = esdhc;
 }
 
 static int sdhci_esdhc_probe(struct platform_device *pdev)
-- 
2.1.0.27.g96db324

