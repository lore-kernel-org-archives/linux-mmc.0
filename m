From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: clear f_max in boarddata
Date: Thu, 18 Jun 2015 02:05:36 +0800
Message-ID: <1434564337-24720-6-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0112.outbound.protection.outlook.com ([65.55.169.112]:34022
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755312AbbFQSJF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 14:09:05 -0400
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

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

