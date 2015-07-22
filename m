From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 10/11] mmc: sdhci-esdhc-imx: clear f_max in boarddata
Date: Wed, 22 Jul 2015 20:53:09 +0800
Message-ID: <1437569590-5228-11-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0108.outbound.protection.outlook.com ([65.55.169.108]:14399
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965133AbbGVODw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:03:52 -0400
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

After commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()"),
it's not used anymore.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 7 +------
 include/linux/platform_data/mmc-esdhc-imx.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1b0e618..c6b9f64 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -581,13 +581,8 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
-	if (boarddata->f_max && (boarddata->f_max < pltfm_host->clock))
-		return boarddata->f_max;
-	else
-		return pltfm_host->clock;
+	return pltfm_host->clock;
 }
 
 static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 75f70f6..e1571ef 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -43,7 +43,6 @@ struct esdhc_platform_data {
 	enum wp_types wp_type;
 	enum cd_types cd_type;
 	int max_bus_width;
-	unsigned int f_max;
 	bool support_vsel;
 	unsigned int delay_line;
 };
-- 
1.9.1

