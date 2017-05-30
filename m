From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [PATCH v3 5/5] mmc: sdhci-esdhc-imx: Remove the ENGcm07207 workaround
Date: Tue, 30 May 2017 11:14:11 +0200
Message-ID: <1496135651-90007-5-git-send-email-benoit@wsystem.com>
References: <1496135651-90007-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp73.register.it ([195.110.101.57]:63430 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750951AbdE3JOq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2017 05:14:46 -0400
In-Reply-To: <1496135651-90007-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>

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

SDHCI_QUIRK_BROKEN_ADMA has nothing to do with ENGcm07207, so set
ESDHC_FLAG_ERR004536 for the devices that had ESDHC_FLAG_ENGCM07207 set
in order to continue getting SDHCI_QUIRK_BROKEN_ADMA.

Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes v1 -> v2:
 - Spelling fixes moved to a separate patch (suggested by Adrian
   Hunter).
 - Comments added about SDHCI_QUIRK_BROKEN_ADMA.
Changes v2 -> v3: none.
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e31265a..85140c9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -115,11 +115,6 @@
  */
 #define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
 /*
- * The flag enables the workaround for ESDHC erratum ENGcm07207 which
- * affects i.MX25 and i.MX35.
- */
-#define ESDHC_FLAG_ENGCM07207		BIT(2)
-/*
  * The flag tells that the ESDHC controller is an USDHC block that is
  * integrated on the i.MX6 series.
  */
@@ -134,6 +129,8 @@
  * The IP has erratum ERR004536
  * uSDHC: ADMA Length Mismatch Error occurs if the AHB read access is slow,
  * when reading data from the card
+ * This flag is also set for i.MX25 and i.MX35 in order to get
+ * SDHCI_QUIRK_BROKEN_ADMA, but for different reasons (ADMA capability bits).
  */
 #define ESDHC_FLAG_ERR004536		BIT(7)
 /* The IP supports HS200 mode */
@@ -149,11 +146,11 @@ struct esdhc_soc_data {
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
@@ -1285,11 +1282,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(imx_data->pins_default))
 		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
-		/* Fix erratum ENGcm07207 present on i.MX25 and i.MX35 */
-		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
-			| SDHCI_QUIRK_BROKEN_ADMA;
-
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
2.7.4

