From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 3/3] mmc: dw_mmc: k3: support hi6220
Date: Fri,  1 May 2015 09:46:58 +0800
Message-ID: <1430444818-7740-4-git-send-email-zhangfei.gao@linaro.org>
References: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33336 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbbEABrY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 21:47:24 -0400
Received: by pacwv17 with SMTP id wv17so77211382pac.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 18:47:24 -0700 (PDT)
In-Reply-To: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, "Jorge A. Ramirez-Ortiz" <jorge.ramirez-ortiz@linaro.org>, Dan Yuan <yuandan@hisilicon.com>

Signed-off-by: Jorge A. Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Dan Yuan <yuandan@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc-k3.c | 104 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 650f9cc..ab3dc59 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -8,16 +8,29 @@
  * (at your option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
+#define AO_SCTRL_SEL18		BIT(10)
+#define AO_SCTRL_CTRL3		0x40C
+
+#define SDMMC_CMD_DISABLE_BOOT	BIT(26)
+
+struct k3_priv {
+	struct regmap	*reg;
+};
+
 static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	int ret;
@@ -33,8 +46,95 @@ static const struct dw_mci_drv_data k3_drv_data = {
 	.set_ios		= dw_mci_k3_set_ios,
 };
 
+static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
+{
+	struct k3_priv *priv;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->reg = syscon_regmap_lookup_by_phandle(host->dev->of_node,
+					 "hisilicon,peripheral-syscon");
+	if (IS_ERR(priv->reg))
+		priv->reg = NULL;
+
+	host->priv = priv;
+	return 0;
+}
+
+static int dw_mci_hi6220_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct k3_priv *priv;
+	struct dw_mci *host;
+	int min_uv, max_uv;
+	int ret;
+
+	host = slot->host;
+	priv = host->priv;
+
+	if (!priv || !priv->reg)
+		return 0;
+
+	min_uv = 1800000;
+	max_uv = 1800000;
+
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
+		ret = regmap_update_bits(priv->reg, AO_SCTRL_CTRL3,
+					 AO_SCTRL_SEL18, 0);
+		if (ret) {
+			dev_dbg(host->dev, "switch voltage failed\n");
+			return ret;
+		}
+		min_uv = 3000000;
+		max_uv = 3000000;
+	}
+
+	if (IS_ERR_OR_NULL(mmc->supply.vqmmc))
+		return 0;
+
+	ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
+	if (ret) {
+		dev_dbg(host->dev, "Regulator set error %d: %d - %d\n",
+				 ret, min_uv, max_uv);
+		return ret;
+	}
+
+	ret = regulator_enable(mmc->supply.vqmmc);
+	if (ret) {
+		dev_dbg(host->dev, "Regulator enable error %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(5000, 5500);
+
+	return 0;
+}
+
+static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	int ret;
+	unsigned int clock;
+
+	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
+
+	ret = clk_set_rate(host->biu_clk, clock);
+	if (ret)
+		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
+
+	host->bus_hz = clk_get_rate(host->biu_clk);
+}
+
+static const struct dw_mci_drv_data hi6220_data = {
+	.switch_voltage		= dw_mci_hi6220_switch_voltage,
+	.set_ios		= dw_mci_hi6220_set_ios,
+	.parse_dt		= dw_mci_hi6220_parse_dt,
+};
+
 static const struct of_device_id dw_mci_k3_match[] = {
 	{ .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
+	{ .compatible = "hisilicon,hi6220-dw-mshc", .data = &hi6220_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
-- 
1.9.1

