From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks manually
Date: Tue, 24 Jan 2012 13:01:38 +0100
Message-ID: <1327406500-7233-10-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On sh-mobile platforms the MMC clock frequency for the TMIO MMC unit is
obtained from the same clock, as the one, that runtime power-manages the
controller. The SDHI glue code has to access that clock directly,
bypassing the runtime PM framework, to get its frequency, but it
shouldn't enable or disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cb279b4..f91c3aa 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -117,8 +117,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	clk_enable(priv->clk);
-
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
@@ -233,7 +231,6 @@ eirq_sdio:
 eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 eclkget:
 	kfree(priv);
@@ -259,7 +256,6 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 		free_irq(irq, host);
 	}
 
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 	kfree(priv);
 
-- 
1.7.2.5

