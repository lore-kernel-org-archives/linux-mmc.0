From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to bus clock
Date: Mon,  7 Sep 2015 16:48:38 +0530
Message-ID: <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Kevin Liu <kliu5@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Different bus clock may need different pin setting.
For example, fast bus clock like 208Mhz need pin drive fast
while slow bus clock prefer pin drive slow to guarantee
signal quality.

So this patch creates two states,
  - Default (slow/normal) pin state
  - And fast pin state for higher freq bus speed.

And selection of pin state is done based on timing mode.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index c2b2b78..d933f75 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -35,6 +35,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/mbus.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -92,6 +93,10 @@ struct sdhci_pxa {
 	void __iomem *io_pwr_reg;
 	void __iomem *io_pwr_lock_reg;
 	struct sdhci_pxa_data *data;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_fast;
 };
 
 static struct sdhci_pxa_data pxav3_data_v1 = {
@@ -298,6 +303,33 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	pxa->power_mode = power_mode;
 }
 
+static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct pinctrl_state *pinctrl;
+
+	if (IS_ERR(pxa->pinctrl) ||
+		IS_ERR(pxa->pins_default) ||
+		IS_ERR(pxa->pins_fast))
+		return -EINVAL;
+
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
+		pinctrl = pxa->pins_fast;
+		break;
+	default:
+		/* back to default state for other legacy timing */
+		pinctrl = pxa->pins_default;
+		break;
+	}
+
+	return pinctrl_select_state(pxa->pinctrl, pinctrl);
+}
+
 static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -353,6 +385,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	dev_dbg(mmc_dev(host->mmc),
 		"%s uhs = %d, ctrl_2 = %04X\n",
 		__func__, uhs, ctrl_2);
+
+	pxav3_select_pinstate(host, uhs);
 }
 
 static void pxav3_voltage_switch(struct sdhci_host *host,
@@ -416,7 +450,6 @@ static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
 		/* TX internal clock selection */
 		pxav3_set_tx_clock(host);
 	}
-
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
@@ -586,6 +619,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		}
 	}
 
+	pxa->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(pxa->pinctrl)) {
+		pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
+		if (IS_ERR(pxa->pins_default))
+			dev_err(dev, "could not get default pinstate\n");
+		pxa->pins_fast = pinctrl_lookup_state(pxa->pinctrl, "fast");
+		if (IS_ERR(pxa->pins_fast))
+			dev_info(dev, "could not get fast pinstate\n");
+	}
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
-- 
1.9.1
