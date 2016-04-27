From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v5 4/4] mmc: usdhi6rol0: add pinctrl to set pin drive strength
Date: Wed, 27 Apr 2016 17:21:29 +0200
Message-ID: <7e860ee256bfecba899d432bcb3cadf48694a4d8.1461770066.git.larper@axis.com>
References: <cover.1461770066.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some boards need different pin drive strength for the UHS mode. Add an
optional pinctrl setting with two pin states covering UHS speeds and
other speeds.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 drivers/mmc/host/usdhi6rol0.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 743e200..1bd5f1a 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
@@ -198,6 +199,11 @@ struct usdhi6_host {
 	struct dma_chan *chan_rx;
 	struct dma_chan *chan_tx;
 	bool dma_active;
+
+	/* Pin control */
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_uhs;
 };
 
 /*			I/O primitives					*/
@@ -1147,12 +1153,35 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
+{
+	if (IS_ERR(host->pins_uhs))
+		return 0;
+
+	switch (voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+	case MMC_SIGNAL_VOLTAGE_120:
+		return pinctrl_select_state(host->pinctrl,
+					    host->pins_uhs);
+
+	default:
+		return pinctrl_select_state(host->pinctrl,
+					    host->pins_default);
+	}
+}
+
 static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	int ret;
 
 	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret < 0)
+		return ret;
 
+	ret = usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
+	if (ret)
+		dev_warn_once(mmc_dev(mmc),
+			      "Failed to set pinstate err=%d\n", ret);
 	return ret;
 }
 
@@ -1740,6 +1769,25 @@ static int usdhi6_probe(struct platform_device *pdev)
 	host->wait	= USDHI6_WAIT_FOR_REQUEST;
 	host->timeout	= msecs_to_jiffies(4000);
 
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto e_free_mmc;
+	}
+
+	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
+	if (!IS_ERR(host->pins_uhs)) {
+		host->pins_default = pinctrl_lookup_state(host->pinctrl,
+							  PINCTRL_STATE_DEFAULT);
+
+		if (IS_ERR(host->pins_default)) {
+			dev_err(dev,
+				"UHS pinctrl requires a default pin state.\n");
+			ret = PTR_ERR(host->pins_default);
+			goto e_free_mmc;
+		}
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(host->base)) {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
