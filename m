From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
Date: Tue, 12 Jul 2016 15:46:19 +0800
Message-ID: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Indicating hw auto retuning support for mx6qdl in the fake caps_1
register and enable auto retuning in post_tuning process after
tuning completes.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c90aa07b106f..ac2c83af7440 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -302,7 +302,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 				/* imx6q/dl does not have cap_1 register, fake one */
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 					| SDHCI_SUPPORT_SDR50
-					| SDHCI_USE_SDR50_TUNING;
+					| SDHCI_USE_SDR50_TUNING
+					| (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
 
 			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 				val |= SDHCI_SUPPORT_HS400;
@@ -472,10 +473,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			if (val & SDHCI_CTRL_TUNED_CLK)
+			if (val & SDHCI_CTRL_TUNED_CLK) {
 				new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-			else
+				new_val |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+			} else {
 				new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+				new_val &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+			}
 			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
@@ -761,6 +765,7 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
-- 
1.9.1
