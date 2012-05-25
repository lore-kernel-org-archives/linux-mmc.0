From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/5 v3] mmc: sh_mmcif: remove unused .down_pwr() callback
Date: Fri, 25 May 2012 17:45:23 +0200
Message-ID: <1337960752-4944-9-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch shall only be applied after the previous one. If the previous 
one has to go via the sh tree, we can postpone this one until a later 
merge, no big problem with that.

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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
