From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Thu, 18 Oct 2012 13:02:30 +0200
Message-ID: <201210181302.30843.heiko@sntech.de>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36784 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932594Ab2JRLCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 07:02:34 -0400
In-Reply-To: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Chris Ball' <cjb@laptop.org>

If host clock is disabled, host cannot detect a card
in case of using the internal or gpio card-detect for detection.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
I've added the SDHCI_CD_GPIO to the conditional. With this change it works
on my machine. But I'm not sure if this would also be necessary for the 
external card detect.

 drivers/mmc/host/sdhci-s3c.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0cabf18..649dc32 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -750,7 +750,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL &&
+	    pdata->cd_type != S3C_SDHCI_CD_GPIO)
+		clk_disable(sc->clk_io);
 #endif
 	return 0;
 
@@ -797,7 +799,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 		gpio_free(sc->ext_cd_gpio);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_enable(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL &&
+	    pdata->cd_type != S3C_SDHCI_CD_GPIO)
+		clk_enable(sc->clk_io);
 #endif
 	sdhci_remove_host(host, 1);
 
-- 
1.7.2.3

