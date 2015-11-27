From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 2/5] mmc: sdhci-of-esdhc: get SVR from global utilities registers
Date: Fri, 27 Nov 2015 11:20:14 +0800
Message-ID: <1448594417-22515-3-git-send-email-yangbo.lu@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0148.outbound.protection.outlook.com ([207.46.100.148]:36928
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753757AbbK0DnA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 22:43:00 -0500
In-Reply-To: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

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
---
 drivers/mmc/host/sdhci-of-esdhc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 83b1226..fce24b7 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -19,6 +19,9 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/fsl-svr.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
@@ -28,6 +31,8 @@
 struct sdhci_esdhc {
 	u8 vendor_ver;
 	u8 spec_ver;
+	u32 soc_ver;
+	u8 soc_rev;
 };
 
 /**
@@ -566,18 +571,28 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_esdhc *esdhc;
+	struct regmap *guts_regmap;
+	u32 svr;
 	u16 host_ver;
 
 	pltfm_host = sdhci_priv(host);
 	esdhc = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_esdhc),
 			     GFP_KERNEL);
+	pltfm_host->priv = esdhc;
+
+	guts_regmap = syscon_regmap_lookup_by_compatible("syscon");
+	if (IS_ERR(guts_regmap)) {
+		dev_err(&pdev->dev, "unable to find global utilities registers\n");
+	} else {
+		regmap_read(guts_regmap, SVR_OFFSET, &svr);
+		esdhc->soc_ver = SVR_SOC_VER(svr);
+		esdhc->soc_rev = SVR_REV(svr);
+	}
 
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

