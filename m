From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2]mmc: sdhci-s3c: add to enable wakeup for sd-card
Date: Tue, 18 Oct 2011 17:09:29 +0900
Message-ID: <4E9D3439.1000809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44065 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab1JRIKJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2011 04:10:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, 'kgene kim' <kgene.kim@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>

Signed-off-by: Wonil Choi <wonil22.choi@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 3d00e72..c544a8c 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -373,6 +373,7 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 			if (pdata->ext_cd_gpio_invert)
 				status = !status;
 			sdhci_s3c_notify_change(sc->pdev, status);
+			device_init_wakeup(dev, pdata->wakeup);
 		} else {
 			dev_warn(dev, "cannot request irq for card detect\n");
 			sc->ext_cd_irq = 0;
@@ -625,13 +626,25 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
+	int ret = 0;
+
+	ret = sdhci_suspend_host(host, pm);
+	if (!ret && device_may_wakeup(&dev->dev))
+		if (sc->ext_cd_irq)
+			enable_irq_wake(sc->ext_cd_irq);
 
-	return sdhci_suspend_host(host, pm);
+	return ret;
 }
 
 static int sdhci_s3c_resume(struct platform_device *dev)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
+
+	if (device_may_wakeup(&dev->dev))
+		if (sc->ext_cd_irq)
+			disable_irq_wake(sc->ext_cd_irq);
 
 	return sdhci_resume_host(host);
 }
