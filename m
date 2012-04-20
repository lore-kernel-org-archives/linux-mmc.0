From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/5] mmc: sh_mmcif: remove unused .down_pwr() callback
Date: Fri, 20 Apr 2012 18:59:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204201839400.3974@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/sh_mmcif.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 05f0e3d..cb84340 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -39,7 +39,6 @@ struct sh_mmcif_dma {
 
 struct sh_mmcif_plat_data {
 	void (*set_pwr)(struct platform_device *pdev, int state);
-	void (*down_pwr)(struct platform_device *pdev);
 	int (*get_cd)(struct platform_device *pdef);
 	struct sh_mmcif_dma	*dma;		/* Deprecated. Instead */
 	unsigned int		slave_id_tx;	/* use embedded slave_id_[tr]x */
-- 
1.7.2.5

