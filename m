From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Mon, 18 Apr 2016 11:38:25 +0200
Message-ID: <ba126adf4953f61ed11ed8b0219608663cfb5fbc.1460971625.git.larper@axis.com>
References: <cover.1460971625.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1460971625.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1460971625.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1460971625.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Phil Edworthy <phil-r1wpeF5ryA4gsBAKwltoeQ@public.gmane.org>, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

The mmc core will only enable UHS modes if the host supports the
.start_signal_voltage_switch() operation. Add this method to the v08r07
driver even if there's actually nothing to do in it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Signed-off-by: Phil Edworthy <phil-r1wpeF5ryA4gsBAKwltoeQ@public.gmane.org>
Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 drivers/mmc/host/usdhi6rol0.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 807c06e..5dde31b 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/time.h>
@@ -1147,12 +1148,43 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	if (IS_ERR(mmc->supply.vqmmc))
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		ret = regulator_set_voltage(mmc->supply.vqmmc,
+					    2700000, 3600000);
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		ret = regulator_set_voltage(mmc->supply.vqmmc,
+					    1700000, 1950000);
+		break;
+	case MMC_SIGNAL_VOLTAGE_120:
+		ret = regulator_set_voltage(mmc->supply.vqmmc,
+					    1100000, 1300000);
+		break;
+	default:
+		return 0;
+	}
+
+	if (ret < 0)
+		dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
+
+	return ret;
+}
+
 static struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
 	.get_cd		= usdhi6_get_cd,
 	.get_ro		= usdhi6_get_ro,
 	.enable_sdio_irq = usdhi6_enable_sdio_irq,
+	.start_signal_voltage_switch = usdhi6_sig_volt_switch,
 };
 
 /*			State machine handlers				*/
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
