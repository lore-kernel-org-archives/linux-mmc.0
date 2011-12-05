From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH-next] mmc: core: Fixup delayed work clock gating patch
Date: Mon,  5 Dec 2011 10:28:44 -0800
Message-ID: <1323109724-30898-1-git-send-email-sboyd@codeaurora.org>
References: <4EC2B4A3.3030700@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45183 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1LES2q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 13:28:46 -0500
In-Reply-To: <4EC2B4A3.3030700@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>

c31b50e (mmc: core: Use delayed work in clock gating framework,
2011-11-14) missed a few things during review:

 o A useless pr_info()

 o milliseconds was written as two words

 o The sysfs file had units in its output

Fix all three problems.

Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Feel free to squash if desired.

 Documentation/mmc/mmc-dev-attrs.txt |    2 +-
 drivers/mmc/core/host.c             |    6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index b024556..22ae844 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -71,6 +71,6 @@ SD/MMC/SDIO Clock Gating Attribute
 Read and write access is provided to following attribute.
 This attribute appears only if CONFIG_MMC_CLKGATE is enabled.
 
-	clkgate_delay	Tune the clock gating delay with desired value in milli seconds.
+	clkgate_delay	Tune the clock gating delay with desired value in milliseconds.
 
 echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_delay
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 835e86a..c152ce0c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -58,8 +58,7 @@ static ssize_t clkgate_delay_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
-	return snprintf(buf, PAGE_SIZE, "%lu millisecs\n",
-			host->clkgate_delay);
+	return snprintf(buf, PAGE_SIZE, "%lu\n", host->clkgate_delay);
 }
 
 static ssize_t clkgate_delay_store(struct device *dev,
@@ -74,9 +73,6 @@ static ssize_t clkgate_delay_store(struct device *dev,
 	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clkgate_delay = value;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
-
-	pr_info("%s: clock gate delay set to %lu ms\n",
-			mmc_hostname(host), value);
 	return count;
 }
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

