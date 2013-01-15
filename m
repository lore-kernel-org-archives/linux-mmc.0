From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove D3CD check from SDHCI_HOST_CONTROL write
Date: Tue, 15 Jan 2013 23:36:52 +0800
Message-ID: <1358264213-3611-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:7933
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713Ab3AOPgf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 10:36:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

SDHCI_CTRL_D3CD is not a standard SDHCI_HOST_CONTROL, so there is no
need to check it in SDHCI_HOST_CONTROL write at all.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ac6f971..322eabf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -297,10 +297,8 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 */
 		return;
 	case SDHCI_HOST_CONTROL:
-		/* FSL messed up here, so we can just keep those three */
-		new_val = val & (SDHCI_CTRL_LED | \
-				SDHCI_CTRL_4BITBUS | \
-				SDHCI_CTRL_D3CD);
+		/* FSL messed up here, so we need to manually compose it. */
+		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
 		/* ensure the endianness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* bits 8&9 are reserved on mx25 */
-- 
1.7.9.5


