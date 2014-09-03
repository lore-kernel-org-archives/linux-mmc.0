From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 3/7] mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
Date: Wed, 3 Sep 2014 20:04:59 +0800
Message-ID: <1409745903-26550-4-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.guo@linaro.org, b29396@freescale.com, chris@printf.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The uSDHC has an ADMA Length Mismatch errata ERR004536 which may
cause ADMA work abnormally. The errata has already been fixed for
i.MX6Q TO1.2 and i.MX6DL TO1.1 by enable the bit 7 in 0x6c register.
Unfortunately this fix is not included in i.MX6SL.
So we disable ADMA for i.MX6SL and use SDMA instead.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9594bf8..dc0e384 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -114,6 +114,12 @@
 #define ESDHC_FLAG_STD_TUNING		BIT(5)
 /* The IP has SDHCI_CAPABILITIES_1 register */
 #define ESDHC_FLAG_HAVE_CAP1		BIT(6)
+/*
+ * The IP has errata ERR004536
+ * uSDHC: ADMA Length Mismatch Error occurs if the AHB read access is slow,
+ * when reading data from the card
+ */
+#define ESDHC_FLAG_ERR004536		BIT(7)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -141,7 +147,7 @@ static struct esdhc_soc_data usdhc_imx6q_data = {
 
 static struct esdhc_soc_data usdhc_imx6sl_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
 };
 
 struct pltfm_imx_data {
@@ -1050,6 +1056,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
+		/*
+		 * errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
+		 * TO1.1, it's harmless for MX6SL
+		 */
+		writel(readl(host->ioaddr + 0x6c) | BIT(7),
+			host->ioaddr + 0x6c);
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
@@ -1061,6 +1074,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP,
 			host->ioaddr + ESDHC_TUNING_CTRL);
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
-- 
1.7.8
