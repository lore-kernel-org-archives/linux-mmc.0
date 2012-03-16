From: Bastian Hecht <hechtb@googlemail.com>
Subject: [PATCH] mmc: sh_mobile_sdhi: add a callback for board specific init code
Date: Fri, 16 Mar 2012 16:57:18 +0100
Message-ID: <1331913438-3161-1-git-send-email-hechtb@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Bastian Hecht <hechtb@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some boards need a preliminary setup stage to prepare the sdhi
controller.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |   13 +++++++++++++
 include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0df69ab..1da31a4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -109,6 +109,12 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data = &priv->mmc_data;
 	p->pdata = mmc_data;
 
+	if (p->init) {
+		ret = p->init(pdev);
+		if (ret)
+			goto einit;
+	}
+
 	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(priv->clk)) {
@@ -242,6 +248,9 @@ eprobe:
 #endif
 	clk_put(priv->clk);
 eclkget:
+	if (p->cleanup)
+		p->cleanup(pdev);
+einit:
 	kfree(priv);
 	return ret;
 }
@@ -269,6 +278,10 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	clk_disable(priv->clk);
 #endif
 	clk_put(priv->clk);
+
+	if (p->cleanup)
+		p->cleanup(pdev);
+
 	kfree(priv);
 
 	return 0;
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 86347f6..9cad001 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -22,6 +22,10 @@ struct sh_mobile_sdhi_info {
 	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
+
+	/* callbacks for board specific setup code */
+	int (*init)(struct platform_device *pdev);
+	void (*cleanup)(struct platform_device *pdev);
 };
 
 #endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
-- 
1.7.5.4

