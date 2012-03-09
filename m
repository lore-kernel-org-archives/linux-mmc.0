From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] mmc: sh_mobile_sdhi: support modular mmc-core with
 non-standard hotplug
Date: Fri, 9 Mar 2012 10:16:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203091012150.7852@axis700.grange>
References: <Pine.LNX.4.64.1202271454270.32434@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1202271454270.32434@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Currently if a platform wants to implement a non-standard card-detection
method, it would need to call tmio_mmc_cd_wakeup(), which is an inline
function, calling mmc_detect_change(). For this the platform would have
to link mmc_core statically into the kernel, losing the ability to build
it as a module. This patch adds a callback to the sh_mobile_sdhi driver,
which eliminates this dependency.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:

1. remove a call to tmio_mmc_cd_wakeup(), call mmc_detect_change() 
   directly instead
2. document the new struct sh_mobile_sdhi_ops

 drivers/mmc/host/sh_mobile_sdhi.c  |   11 ++++++++++-
 include/linux/mmc/sh_mobile_sdhi.h |   11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index dd288d6..8352054 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -100,6 +100,15 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	return 0;
 }
 
+static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
+{
+	mmc_detect_change(dev_get_drvdata(&pdev->dev), msecs_to_jiffies(100));
+}
+
+static const struct sh_mobile_sdhi_ops sdhi_ops = {
+	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
+};
+
 static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
@@ -121,7 +130,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	p->pdata = mmc_data;
 
 	if (p->init) {
-		ret = p->init(pdev);
+		ret = p->init(pdev, &sdhi_ops);
 		if (ret)
 			goto einit;
 	}
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 686b85b..e94e620 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -10,6 +10,14 @@ struct tmio_mmc_data;
 #define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
 #define SH_MOBILE_SDHI_IRQ_SDIO		"sdio"
 
+/**
+ * struct sh_mobile_sdhi_ops - SDHI driver callbacks
+ * @cd_wakeup:		trigger a card-detection run
+ */
+struct sh_mobile_sdhi_ops {
+	void (*cd_wakeup)(const struct platform_device *pdev);
+};
+
 struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
@@ -22,7 +30,8 @@ struct sh_mobile_sdhi_info {
 	int (*get_cd)(struct platform_device *pdev);
 
 	/* callbacks for board specific setup code */
-	int (*init)(struct platform_device *pdev);
+	int (*init)(struct platform_device *pdev,
+		    const struct sh_mobile_sdhi_ops *ops);
 	void (*cleanup)(struct platform_device *pdev);
 };
 
-- 
1.7.2.5

