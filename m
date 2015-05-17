From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4/6] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Sun, 17 May 2015 01:29:09 +0100
Message-ID: <1431822549.4222.171.camel@xylophone.i.decadent.org.uk>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Implement voltage switch, supporting modes up to SDR-50.

Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 354f4f335ed5..b96d7c084c2e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -30,6 +30,9 @@
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinctrl-state.h>
+#include <linux/regulator/consumer.h>
 
 #include "tmio_mmc.h"
 
@@ -86,6 +89,8 @@ struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
 	struct tmio_mmc_dma dma_priv;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_3v3, *pinctrl_1v8;
 };
 
 static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
@@ -136,6 +141,47 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 }
 
+static int sh_mobile_sdhi_start_signal_voltage_switch(
+	struct tmio_mmc_host *host, unsigned char signal_voltage)
+{
+	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct pinctrl_state *state;
+	int min_uV, max_uV;
+	int ret;
+
+	if (IS_ERR(priv->pinctrl) || IS_ERR(host->mmc->supply.vqmmc))
+		return -EOPNOTSUPP;
+
+	switch (signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		min_uV = 2700000;
+		max_uV = 3600000;
+		state = priv->pinctrl_3v3;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		min_uV = 1700000;
+		max_uV = 1950000;
+		state = priv->pinctrl_1v8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+
+	ret = regulator_set_voltage(host->mmc->supply.vqmmc, min_uV, max_uV);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_select_state(priv->pinctrl, state);
+	if (ret)
+		return ret;
+
+	usleep_range(5000, 5500);
+	return 0;
+}
+
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
@@ -228,6 +274,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(priv->pinctrl)) {
+		priv->pinctrl_3v3 = pinctrl_lookup_state(priv->pinctrl,
+							 PINCTRL_STATE_DEFAULT);
+		priv->pinctrl_1v8 = pinctrl_lookup_state(priv->pinctrl,
+							 "1v8");
+	}
+
 	host = tmio_mmc_host_alloc(pdev);
 	if (!host) {
 		ret = -ENOMEM;
@@ -239,6 +293,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_enable	= sh_mobile_sdhi_clk_enable;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
+
+	host->start_signal_voltage_switch
+				= sh_mobile_sdhi_start_signal_voltage_switch;
+
 	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
 	if (resource_size(res) > 0x100)
 		host->bus_shift = 1;
-- 
1.7.10.4




