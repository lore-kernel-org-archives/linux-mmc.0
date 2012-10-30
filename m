From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 2/2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Tue, 30 Oct 2012 14:28:36 +0900
Message-ID: <00b001cdb65f$6958fb80$3c0af280$%jun@samsung.com>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
 <201210181302.30843.heiko@sntech.de>
 <006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
 <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53400 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2J3F2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 01:28:38 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCO004VWXVDISM0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Oct 2012 14:28:37 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MCO000ZNXVOEI30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Oct 2012 14:28:37 +0900 (KST)
In-reply-to: <87liepq8qo.fsf@octavius.laptop.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>

If host clock is disabled, host cannot detect a card
in case of using CD internal for detection.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Rebased with mmc-next.

 drivers/mmc/host/sdhci-s3c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a79b153..d680c0b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -747,7 +747,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_disable_unprepare(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
+		clk_disable_unprepare(sc->clk_io);
 #endif
 	return 0;
 
@@ -794,7 +795,8 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 		gpio_free(sc->ext_cd_gpio);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_prepare_enable(sc->clk_io);
+	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
+		clk_prepare_enable(sc->clk_io);
 #endif
 	sdhci_remove_host(host, 1);
 
-- 
1.7.0.4


