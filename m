From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: do not touch other bit when config DTOCV
Date: Mon, 15 Aug 2016 16:19:38 +0800
Message-ID: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:63422
	"EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752488AbcHONpd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Aug 2016 09:45:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org
Cc: haibo.chen@nxp.com

Now, when call esdhc_set_timeout() to set the data timeout counter value,
IPP_RST_N(bit 23) is wrongly affected. This patch add a mask to avoid this.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 99e0b33..437c448 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,7 @@
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+#define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 /* VENDOR SPEC register */
@@ -937,7 +938,8 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 
 	/* use maximum timeout counter */
-	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
+			esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
 			SDHCI_TIMEOUT_CONTROL);
 }
 
-- 
1.9.1

