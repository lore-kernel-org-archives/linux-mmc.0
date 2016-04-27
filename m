From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH v5 2/4] mmc: usdhi6rol0: do not announce UHS capabilities
Date: Wed, 27 Apr 2016 17:21:27 +0200
Message-ID: <00d08d86f86a34209a4bac49622a88d3ddf5af6c.1461770066.git.larper@axis.com>
References: <cover.1461770066.git.larper@axis.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
In-Reply-To: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
References: <cover.1461770066.git.larper-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The driver in its current form does not support UHS at all due to
a missing start_signal_voltage_switch callback.

Also when this callback is added we should let the device tree control
UHS capabilities using the standard mmc bindings.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 drivers/mmc/host/usdhi6rol0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 807c06e..e9c8dfa 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1785,7 +1785,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 
 	mmc->ops = &usdhi6_ops;
 	mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ;
+		     MMC_CAP_SDIO_IRQ;
 	/* Set .max_segs to some random number. Feel free to adjust. */
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
