From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: fix checkpatch error and warning
Date: Wed, 14 Dec 2011 13:23:04 +0900
Message-ID: <003701ccba18$130492b0$390db810$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12620 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab1LNEXF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 23:23:05 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW600GB9EU7YZ90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:23:03 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.153])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LW600340EUF9V00@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:23:03 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Ben Dooks' <ben-linux@fluff.org>, 'Jingoo Han' <jg1.han@samsung.com>

This patch fixes the checkpatch error and warning listed below:

ERROR: return is not a function, parentheses are not required
WARNING: line over 80 characters

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cb60c41..9d75aaa 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -150,7 +150,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	dev_dbg(&ourhost->pdev->dev, "clk %d: rate %ld, want %d, got %ld\n",
 		src, rate, wanted, rate / div);
 
-	return (wanted - (rate / div));
+	return wanted - (rate / div);
 }
 
 /**
@@ -367,7 +367,8 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 		if (sc->ext_cd_irq &&
 		    request_threaded_irq(sc->ext_cd_irq, NULL,
 					 sdhci_s3c_gpio_card_detect_thread,
-					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					 IRQF_TRIGGER_RISING |
+					 IRQF_TRIGGER_FALLING,
 					 dev_name(dev), sc) == 0) {
 			int status = gpio_get_value(sc->ext_cd_gpio);
 			if (pdata->ext_cd_gpio_invert)
-- 
1.7.1


