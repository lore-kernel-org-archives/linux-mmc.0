From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Tue, 17 Apr 2012 17:09:36 +0530
Message-ID: <5c259dbff86f7d9a43de8db3f3e601d490a4bcc9.1334662743.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:39911 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755552Ab2DQLyZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 07:54:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, spear-devel@list.st.com, viresh.linux@gmail.com, subhashj@codeaurora.org, Viresh Kumar <viresh.kumar@st.com>

clk_{un}prepare is mandatory for platforms using common clock framework. Since
this driver is used by SPEAr platform, which supports common clock framework,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V1->V2:
- Use clk_prepare_enable and clk_disable_unprepare

 drivers/mmc/host/sdhci-spear.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 62c9730..4f51d1a 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -154,7 +154,7 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = clk_enable(sdhci->clk);
+	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
 		goto put_clk;
@@ -274,7 +274,7 @@ set_drvdata:
 free_host:
 	sdhci_free_host(host);
 disable_clk:
-	clk_disable(sdhci->clk);
+	clk_disable_unprepare(sdhci->clk);
 put_clk:
 	clk_put(sdhci->clk);
 err:
@@ -296,7 +296,7 @@ static int __devexit sdhci_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 	sdhci_free_host(host);
-	clk_disable(sdhci->clk);
+	clk_disable_unprepare(sdhci->clk);
 	clk_put(sdhci->clk);
 
 	return 0;
@@ -311,7 +311,7 @@ static int sdhci_suspend(struct device *dev)
 
 	ret = sdhci_suspend_host(host);
 	if (!ret)
-		clk_disable(sdhci->clk);
+		clk_disable_unprepare(sdhci->clk);
 
 	return ret;
 }
@@ -322,7 +322,7 @@ static int sdhci_resume(struct device *dev)
 	struct spear_sdhci *sdhci = dev_get_platdata(dev);
 	int ret;
 
-	ret = clk_enable(sdhci->clk);
+	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(dev, "Resume: Error enabling clock\n");
 		return ret;
-- 
1.7.9

