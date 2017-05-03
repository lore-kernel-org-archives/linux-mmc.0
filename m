From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [PATCH 4/4] mmc: sdhci-esdhc-imx: Remove the ENGcm07207 workaround
Date: Wed,  3 May 2017 12:05:25 +0200
Message-ID: <1493805925-3644-4-git-send-email-benoit@wsystem.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
List-Id: linux-mmc@vger.kernel.org

The SDHCI_QUIRK_NO_MULTIBLOCK quirk was used as a workaround for the
ENGcm07207 erratum. However, it caused excruciatingly slow SD transfers
(300 kB/s on average), and this erratum actually does not imply that
multiple-block transfers are not supported, so this was overkill.

The suggested workaround for this erratum is to set SYSCTL.RSTA, but the
simple DAT line software reset (which resets the DMA circuit among
others) triggered by sdhci_finish_data() in case of errors seems to be
sufficient. Indeed, generating errors in a controlled manner on i.MX25
using the FEVT register right in the middle of read data transfers
without this quirk shows that nothing is written to the buffer by the
eSDHC past CMD12, and no extra Auto CMD12 is sent with AC12EN set, so
the data transfers on AHB are properly aborted. For write data
transfers, neither extra data nor extra Auto CMD12 is sent, as expected.
Moreover, after intensive stress tests on i.MX25, removing
SDHCI_QUIRK_NO_MULTIBLOCK seems to be safe.

Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fa60d13..868a51f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -115,11 +115,6 @@
  */
 #define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
 /*
- * The flag enables the workaround for ESDHC errata ENGcm07207 which
- * affects i.MX25 and i.MX35.
- */
-#define ESDHC_FLAG_ENGCM07207		BIT(2)
-/*
  * The flag tells that the ESDHC controller is an USDHC block that is
  * integrated on the i.MX6 series.
  */
@@ -149,11 +144,11 @@ struct esdhc_soc_data {
 };
 
 static struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ENGCM07207,
+	.flags = ESDHC_FLAG_ERR004536,
 };
 
 static struct esdhc_soc_data esdhc_imx35_data = {
-	.flags = ESDHC_FLAG_ENGCM07207,
+	.flags = ESDHC_FLAG_ERR004536,
 };
 
 static struct esdhc_soc_data esdhc_imx51_data = {
@@ -286,7 +281,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		 * ADMA2 capability of esdhc, but this bit is messed up on
 		 * some SOCs (e.g. on MX25, MX35 this bit is set, but they
 		 * don't actually support ADMA2). So set the BROKEN_ADMA
-		 * uirk on MX25/35 platforms.
+		 * quirk on MX25/35 platforms.
 		 */
 
 		if (val & SDHCI_CAN_DO_ADMA1) {
@@ -1278,11 +1273,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(imx_data->pins_default))
 		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
-		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
-		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
-			| SDHCI_QUIRK_BROKEN_ADMA;
-
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
2.7.4
