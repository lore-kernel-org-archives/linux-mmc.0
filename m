From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks manually on ARM
Date: Wed,  4 Jan 2012 15:17:14 +0100
Message-ID: <1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On ARM the same clock is used by the PM subsystem and by the driver
directly. This leads to the clock staying permanently on, independent of
the runtime PM state. This patch makes clock enable and disable calls in
the driver SuperH-specific.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index a8d353e..0df69ab 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -117,7 +117,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
+#if defined(CONFIG_SUPERH)
 	clk_enable(priv->clk);
+#endif
 
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
@@ -235,7 +237,9 @@ eirq_sdio:
 eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
+#if defined(CONFIG_SUPERH)
 	clk_disable(priv->clk);
+#endif
 	clk_put(priv->clk);
 eclkget:
 	kfree(priv);
@@ -261,7 +265,9 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 		free_irq(irq, host);
 	}
 
+#if defined(CONFIG_SUPERH)
 	clk_disable(priv->clk);
+#endif
 	clk_put(priv->clk);
 	kfree(priv);
 
-- 
1.7.2.5

