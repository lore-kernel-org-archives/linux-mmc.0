From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] mmc/spear: add pm callbacks to support hibernation
Date: Fri, 24 Feb 2012 11:55:35 +0530
Message-ID: <452d8982fec5f41a3761a9e7b9bbe35e2f92c2a3.1330063674.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:53134 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab2BXGpC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 01:45:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index b7f8b33..6dfa82e 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -300,20 +300,15 @@ static int sdhci_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
-
-const struct dev_pm_ops sdhci_pm_ops = {
-	.suspend	= sdhci_suspend,
-	.resume		= sdhci_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
+
 static struct platform_driver sdhci_driver = {
 	.driver = {
 		.name	= "sdhci",
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &sdhci_pm_ops,
-#endif
 	},
 	.probe		= sdhci_probe,
 	.remove		= __devexit_p(sdhci_remove),
-- 
1.7.8.110.g4cb5d

