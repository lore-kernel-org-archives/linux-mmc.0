From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pxav3: dt: Support "cd-gpios" property
Date: Sat, 08 Sep 2012 23:09:20 -0400
Message-ID: <87k3w3zycf.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53851 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab2IIDJb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Sep 2012 23:09:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Tested on OLPC XO-4/MMP3, where the card detection pin for one of the
controllers is a sideband GPIO.  The third cell in the power-gpios
property controls whether the GPIO is active high/active low.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 0bdb326..5427d52 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -211,6 +211,10 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	if (gpio_flags != OF_GPIO_ACTIVE_LOW)
 		pdata->host_caps2 |= MMC_CAP2_PWR_ACTIVE_HIGH;
 
+	pdata->ext_cd_gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &gpio_flags);
+	if (gpio_flags != OF_GPIO_ACTIVE_LOW)
+		pdata->host_caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 	return pdata;
 }
 #else
@@ -292,6 +296,15 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 				goto err_power_req;
 			}
 		}
+
+		if (gpio_is_valid(pdata->ext_cd_gpio)) {
+			ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio);
+			if (ret) {
+				dev_err(mmc_dev(host->mmc),
+					"failed to allocate card detect gpio\n");
+				goto err_cd_req;
+			}
+		}
 	}
 
 	host->ops = &pxav3_sdhci_ops;
@@ -309,6 +322,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 err_add_host:
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+	mmc_gpio_free_cd(host->mmc);
+err_cd_req:
 	mmc_gpio_free_pwr(host->mmc);
 err_power_req:
 err_clk_get:
@@ -331,6 +346,8 @@ static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
 
 	if (gpio_is_valid(pdata->power_gpio))
 		mmc_gpio_free_pwr(host->mmc);
+	if (gpio_is_valid(pdata->ext_cd_gpio))
+		mmc_gpio_free_cd(host->mmc);
 
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
