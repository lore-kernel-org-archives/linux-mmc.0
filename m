From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] mmc: tmio_mmc, sdhi: update input clock frequency after
 resume
Date: Thu, 2 Feb 2012 23:16:35 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202022256580.13860@axis700.grange>
References: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

After a runtime or system-wide suspend the clock frequency can change,
therefore it must be re-read.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: move updating the clock frequency from .runtime_resume() to .start(), 
since the former is not called, when power domains are used and when the 
domain is not powered off and on - thanks to Magnus for pointing out. This 
version requires my patch from several minutes ago "PM: provide a dummy 
dev_gpd_data() when generic domains are not used."

http://article.gmane.org/gmane.linux.ports.sh.devel/13487

 drivers/mmc/host/sh_mobile_sdhi.c |   20 ++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h       |    1 +
 drivers/mmc/host/tmio_mmc_pio.c   |   26 +++++++++++++++++++++-----
 include/linux/mfd/tmio.h          |    1 +
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 2c3a9d3..2842ab9 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
@@ -47,6 +48,15 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 		p->set_pwr(pdev, state);
 }
 
+static unsigned int sh_mobile_sdhi_get_clk_rate(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+
+	return clk_get_rate(priv->clk);
+}
+
 static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
@@ -95,6 +105,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct generic_pm_domain_data *gpdd;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
 	int irq, ret, i = 0;
@@ -120,6 +131,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->get_clk_rate = sh_mobile_sdhi_get_clk_rate;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
@@ -208,6 +220,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 			goto eirq_multiplexed;
 	}
 
+	gpdd = dev_gpd_data(&pdev->dev);
+	if (gpdd)
+		gpdd->ops.start = tmio_mmc_host_start;
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
@@ -243,8 +259,12 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct generic_pm_domain_data *gpdd = dev_gpd_data(&pdev->dev);
 	int i = 0, irq;
 
+	if (gpdd)
+		gpdd->ops.start = NULL;
+
 	p->pdata = NULL;
 
 	tmio_mmc_host_remove(host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d857f5c..3943647 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -156,6 +156,7 @@ int tmio_mmc_host_resume(struct device *dev);
 
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
+int tmio_mmc_host_start(struct device *dev);
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 08f3e67..69b826a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -900,7 +900,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
-	mmc->f_max = pdata->hclk;
+	if (pdata->get_clk_rate)
+		mmc->f_max = pdata->get_clk_rate(pdev);
+	else
+		mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -1034,16 +1037,14 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
 int tmio_mmc_host_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	tmio_mmc_reset(host);
-	tmio_mmc_enable_dma(host, true);
+	tmio_mmc_host_start(dev);
+	tmio_mmc_host_runtime_resume(dev);
 
 	/* The MMC core will perform the complete set up */
 	return mmc_resume_host(mmc);
 }
 EXPORT_SYMBOL(tmio_mmc_host_resume);
-
 #endif	/* CONFIG_PM */
 
 int tmio_mmc_host_runtime_suspend(struct device *dev)
@@ -1064,4 +1065,19 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
 
+int tmio_mmc_host_start(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	if (pdata->get_clk_rate) {
+		mmc->f_max = pdata->get_clk_rate(host->pdev);
+		mmc->f_min = mmc->f_max / 512;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tmio_mmc_host_start);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f5171db..020a737 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -108,6 +108,7 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
+	unsigned int (*get_clk_rate)(struct platform_device *host);
 	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
-- 
1.7.2.5

