From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
Date: Wed, 29 Jul 2015 17:03:53 +0800
Message-ID: <1438160637-28061-3-git-send-email-haibo.chen@freescale.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: fabio.estevam@freescale.com, devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johan.derycke@barco.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

tuning-step is the delay cell steps in tuning procedure. The default value
of tuning-step is 1. For imx6 series usdhc, tuning procedure can be passed
when the tuning-step value is 1. But imx7d usdhc need the tuning-step value
as 2, otherwise it can't pass the tuning procedure.

So this patch add the tuning-step setting in driver, so that user can set
the tuning-step value in dts.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 9 +++++++++
 include/linux/platform_data/mmc-esdhc-imx.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b441eed..158f93b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -75,6 +75,7 @@
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP		0x1
+#define ESDHC_TUNING_STEP_SHIFT		16
 
 /* pinctrl state */
 #define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
@@ -472,6 +473,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			u32 tuning_ctrl;
 			if (val & SDHCI_CTRL_TUNED_CLK) {
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
 			} else {
@@ -482,6 +484,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
+				if (imx_data->boarddata.tuning_step)
+					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
+					writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -949,6 +956,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (gpio_is_valid(boarddata->wp_gpio))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
+	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
+
 	if (of_find_property(np, "no-1-8-v", NULL))
 		boarddata->support_vsel = false;
 	else
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index e1571ef..95ccab3 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -45,5 +45,6 @@ struct esdhc_platform_data {
 	int max_bus_width;
 	bool support_vsel;
 	unsigned int delay_line;
+	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.9.1
