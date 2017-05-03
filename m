From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: Allow all supported prescaler values
Date: Wed,  3 May 2017 12:05:24 +0200
Message-ID: <1493805925-3644-3-git-send-email-benoit@wsystem.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp79.register.it ([195.110.122.164]:44117 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751601AbdECKLJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 May 2017 06:11:09 -0400
In-Reply-To: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>

On i.MX, SYSCTL.SDCLKFS may always be set to 0 in order to make the SD
clock frequency prescaler divide by 1 in SDR mode, even with the eSDHC.
The previous minimum prescaler value of 2 in SDR mode with the eSDHC was
a code remnant from PowerPC, which actually has this limitation on
earlier revisions.

In DDR mode, the prescaler can divide by up to 512.

The maximum SD clock frequency in High Speed mode is 50 MHz. On i.MX25,
this change makes it possible to get 48 MHz from the USB PLL
(240 MHz / 5 / 1) instead of only 40 MHz from the USB PLL
(240 MHz / 3 / 2) or 33.25 MHz from the AHB clock (133 MHz / 2 / 2).

Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4ee82e1..fa60d13 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -674,7 +674,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	unsigned int host_clock = pltfm_host->clock;
-	int pre_div = 2;
+	int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
+	int pre_div = 1;
 	int div = 1;
 	u32 temp, val;
 
@@ -689,28 +690,23 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		return;
 	}
 
-	if (esdhc_is_usdhc(imx_data) && !imx_data->is_ddr)
-		pre_div = 1;
-
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	while (host_clock / pre_div / 16 > clock && pre_div < 256)
+	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
+			pre_div < 256)
 		pre_div *= 2;
 
-	while (host_clock / pre_div / div > clock && div < 16)
+	while (host_clock / (div * pre_div * ddr_pre_div) > clock && div < 16)
 		div++;
 
-	host->mmc->actual_clock = host_clock / pre_div / div;
+	host->mmc->actual_clock = host_clock / (div * pre_div * ddr_pre_div);
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
 		clock, host->mmc->actual_clock);
 
-	if (imx_data->is_ddr)
-		pre_div >>= 2;
-	else
-		pre_div >>= 1;
+	pre_div >>= 1;
 	div--;
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-- 
2.7.4

