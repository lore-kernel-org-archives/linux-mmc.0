From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Thu, 18 Oct 2012 18:59:39 +0900
Message-ID: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16669 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2JRJ7l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 05:59:41 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MC3008202FFLE20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 18 Oct 2012 18:59:39 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MC300LGZ2FFL7F0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 18 Oct 2012 18:59:39 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Chris Ball' <cjb@laptop.org>

If host clock is disabled, host cannot detect a card
in case of using CD internal for detection.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..e57f200 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -747,7 +747,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
+		clk_disable(sc->clk_io);
 #endif
 	return 0;
 
@@ -794,7 +795,8 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 		gpio_free(sc->ext_cd_gpio);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_enable(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
+		clk_enable(sc->clk_io);
 #endif
 	sdhci_remove_host(host, 1);
 
-- 
1.7.0.4


