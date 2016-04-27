From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v5 3/4] mmc: usdhi6rol0: add support for UHS modes
Date: Wed, 27 Apr 2016 17:21:28 +0200
Message-ID: <60c77f07309e51ab01859f28c76d4fdc57d537c8.1461770066.git.larper@axis.com>
References: <cover.1461770066.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a start_signal_voltage_switch() operation to support enabling of
UHS modes.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index e9c8dfa..743e200 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1147,12 +1147,22 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
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
