From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 03/29] mmc: sh_mmcif: remove unused .down_pwr() callback
Date: Thu,  3 May 2012 17:05:32 +0200
Message-ID: <1336057558-11031-4-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, hold this patch back, until

[PATCH 02/29] sh: ecovec: remove unused .down_pwr() MMCIF callback

is committed.

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

