From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 08/10] omap_hsmmc: pass mmc_priv struct to gpio init / free
Date: Sat,  8 Nov 2014 15:33:15 +0100
Message-ID: <1415457197-14294-9-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40900 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaKHOj4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Nov 2014 09:39:56 -0500
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

this is needed when installing callbacks in the host struct and not
in the platform data, e.g. cover detect irq should be stored in
omap_hsmmc_host and not platform data

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 291b9e1..8a216c9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -449,7 +449,8 @@ static inline int omap_hsmmc_have_reg(void)
 
 #endif
 
-static int omap_hsmmc_gpio_init(struct omap_hsmmc_platform_data *pdata)
+static int omap_hsmmc_gpio_init(struct omap_hsmmc_host *host,
+				struct omap_hsmmc_platform_data *pdata)
 {
 	int ret;
 
@@ -494,7 +495,8 @@ err_free_sp:
 	return ret;
 }
 
-static void omap_hsmmc_gpio_free(struct omap_hsmmc_platform_data *pdata)
+static void omap_hsmmc_gpio_free(struct omap_hsmmc_host *host,
+				 struct omap_hsmmc_platform_data *pdata)
 {
 	if (gpio_is_valid(pdata->gpio_wp))
 		gpio_free(pdata->gpio_wp);
@@ -2064,14 +2066,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	ret = omap_hsmmc_gpio_init(pdata);
-	if (ret)
-		goto err;
-
 	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err;
 	}
 
 	host		= mmc_priv(mmc);
@@ -2088,6 +2086,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
 
+	ret = omap_hsmmc_gpio_init(host, pdata);
+	if (ret)
+		goto err_gpio;
+
 	platform_set_drvdata(pdev, host);
 
 	if (pdev->dev.of_node)
@@ -2283,9 +2285,9 @@ err_irq:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 err1:
+	omap_hsmmc_gpio_free(host, pdata);
+err_gpio:
 	mmc_free_host(mmc);
-err_alloc:
-	omap_hsmmc_gpio_free(pdata);
 err:
 	return ret;
 }
@@ -2309,7 +2311,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
-	omap_hsmmc_gpio_free(host->pdata);
+	omap_hsmmc_gpio_free(host, host->pdata);
 	mmc_free_host(host->mmc);
 
 	return 0;
-- 
2.1.1

