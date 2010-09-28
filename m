From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the sdhci-pltfm driver (V3)
Date: Tue, 28 Sep 2010 10:41:27 +0200
Message-ID: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:32852 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757267Ab0I1Ilp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 04:41:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: w.sang@pengutronix.de, Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch adds the suspend and resume functions
in the sdhci-pltfm device driver.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e045e3c..4f126de 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -165,6 +165,25 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
 
+#ifdef CONFIG_PM
+static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pltfm_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pltfm_suspend	NULL
+#define sdhci_pltfm_resume	NULL
+#endif	/* CONFIG_PM */
+
 static struct platform_driver sdhci_pltfm_driver = {
 	.driver = {
 		.name	= "sdhci",
@@ -173,6 +192,8 @@ static struct platform_driver sdhci_pltfm_driver = {
 	.probe		= sdhci_pltfm_probe,
 	.remove		= __devexit_p(sdhci_pltfm_remove),
 	.id_table	= sdhci_pltfm_ids,
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
 };
 
 /*****************************************************************************\
-- 
1.5.5.6

