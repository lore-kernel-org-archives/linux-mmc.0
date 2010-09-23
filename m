From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the sdhci-pltfm driver
Date: Thu, 23 Sep 2010 11:14:24 +0200
Message-ID: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:41208 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab0IWJOg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 05:14:36 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9C29131
	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 09:14:32 +0000 (GMT)
Received: from mail3.ctn.st.com (mail3.ctn.st.com [164.130.116.150])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E7111F00
	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 09:14:32 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e045e3c..89ea64b 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -165,6 +165,24 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
 
+#ifdef CONFIG_PM
+static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t pm)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	sdhci_suspend_host(host, pm);
+	return 0;
+}
+
+static int sdhci_pltfm_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	sdhci_resume_host(host);
+	return 0;
+}
+#endif
+
 static struct platform_driver sdhci_pltfm_driver = {
 	.driver = {
 		.name	= "sdhci",
@@ -173,6 +191,10 @@ static struct platform_driver sdhci_pltfm_driver = {
 	.probe		= sdhci_pltfm_probe,
 	.remove		= __devexit_p(sdhci_pltfm_remove),
 	.id_table	= sdhci_pltfm_ids,
+#ifdef CONFIG_PM
+	.suspend = sdhci_pltfm_suspend,
+	.resume = sdhci_pltfm_resume,
+#endif
 };
 
 /*****************************************************************************\
-- 
1.5.5.6

