From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/6] mmc: sdhci-esdhc-imx: manually reset MIX_CTRL for usdhc
Date: Mon, 21 Jan 2013 19:02:25 +0800
Message-ID: <1358766149-9534-3-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:46327
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab3AUKej (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:39 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

It's another violation to SDHC spec that software reset on usdhc
does not reset MIX_CTRL register.  Have to do it manually, otherwise
the preserving of the register bits (e.g. AC23EN) may cause mmc card
fail to be initialized.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 48832c5..968a70f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -318,8 +318,15 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 	 * circuit relies on.  To work around it, we turn the clocks on back
 	 * to keep card detection circuit functional.
 	 */
-	if ((reg == SDHCI_SOFTWARE_RESET) && (val & 1))
+	if ((reg == SDHCI_SOFTWARE_RESET) && (val & 1)) {
 		esdhc_clrset_le(host, 0x7, 0x7, ESDHC_SYSTEM_CONTROL);
+		/*
+		 * The reset on usdhc fails to clear MIX_CTRL register.
+		 * Do it manually here.
+		 */
+		if (is_imx6q_usdhc(imx_data))
+			writel(0, host->ioaddr + ESDHC_MIX_CTRL);
+	}
 }
 
 static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
-- 
1.7.9.5


