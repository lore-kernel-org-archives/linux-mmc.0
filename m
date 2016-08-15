From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: correct the max timeout count
Date: Mon, 15 Aug 2016 16:31:33 +0800
Message-ID: <1471249893-32345-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:31822
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751244AbcHPAzq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Aug 2016 20:55:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org
Cc: haibo.chen@nxp.com

i.MX USDHC Reference Manual has a mistake, for the register SYS_CTRL,
the DTOCV(bit 19~16) means the data timeout counter value. When DTOCV
is set to 0xF, it means SDCLK << 29, not SDCLK << 28.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 437c448..ea7d086 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -929,7 +929,7 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
-	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
+	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
 }
 
 static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
-- 
1.9.1

