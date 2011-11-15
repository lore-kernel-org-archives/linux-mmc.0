From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2] mmc/sdhci-spear: Implement suspend/resume
Date: Tue, 15 Nov 2011 16:24:40 +0530
Message-ID: <f255cb1f0ea01794526004ef9e0dd516014a5744.1321354417.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:51431 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754947Ab1KOKyu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 05:54:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

Suspend/Resume is missing from sdhci-spear driver. This patch adds support for
suspend/resume for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---

Changes in V2:
- support for clk enable/disable is added in suspend/resume

 drivers/mmc/host/sdhci-spear.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 63cc8b6..dee70b6 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-spear.h>
@@ -271,10 +272,49 @@ static int __devexit sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int sdhci_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	pm_message_t state = {.event = 0};
+	int ret;
+
+	ret = sdhci_suspend_host(host, state);
+	if (!ret)
+		clk_disable(sdhci->clk);
+
+	return ret;
+}
+
+static int sdhci_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	int ret;
+
+	ret = clk_enable(sdhci->clk);
+	if (ret) {
+		dev_dbg(dev, "Resume: Error enabling clock\n");
+		return ret;
+	}
+
+	return sdhci_resume_host(host);
+}
+
+const struct dev_pm_ops sdhci_pm_ops = {
+	.suspend	= sdhci_suspend,
+	.resume		= sdhci_resume,
+};
+#endif
+
 static struct platform_driver sdhci_driver = {
 	.driver = {
 		.name	= "sdhci",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &sdhci_pm_ops,
+#endif
 	},
 	.probe		= sdhci_probe,
 	.remove		= __devexit_p(sdhci_remove),
-- 
1.7.2.2

