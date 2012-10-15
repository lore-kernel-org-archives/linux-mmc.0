From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 4/4] mmc: omap_hsmmc: Fix NULL pointer dereference for dt boot
Date: Mon, 15 Oct 2012 21:35:08 +0530
Message-ID: <1350317108-10657-4-git-send-email-svenkatr@ti.com>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

dev->platform_data is NULL in case of device tree boot,
instead use the saved version in struct omap_hsmmc_host.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a3929b7..0b5e7ab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -179,7 +179,8 @@ struct omap_hsmmc_host {
 
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct omap_mmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
 	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
@@ -187,7 +188,8 @@ static int omap_hsmmc_card_detect(struct device *dev, int slot)
 
 static int omap_hsmmc_get_wp(struct device *dev, int slot)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct omap_mmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes write protect signal is active-high */
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
@@ -195,7 +197,8 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 
 static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct omap_mmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
 	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
@@ -205,7 +208,8 @@ static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 
 static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct omap_mmc_platform_data *mmc = host->pdata;
 
 	disable_irq(mmc->slots[0].card_detect_irq);
 	return 0;
@@ -213,7 +217,8 @@ static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 
 static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct omap_mmc_platform_data *mmc = host->pdata;
 
 	enable_irq(mmc->slots[0].card_detect_irq);
 	return 0;
@@ -2019,9 +2024,9 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 		clk_put(host->dbclk);
 	}
 
+	omap_hsmmc_gpio_free(host->pdata);
 	iounmap(host->base);
 	mmc_free_host(host->mmc);
-	omap_hsmmc_gpio_free(pdev->dev.platform_data);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
-- 
1.7.11.1.25.g0e18bef

