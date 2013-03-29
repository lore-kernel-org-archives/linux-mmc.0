From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] mmc: sdhci-spear: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Fri, 29 Mar 2013 16:08:00 +0900
Message-ID: <003401ce2c4c$26048490$720d8db0$%han@samsung.com>
References: <003301ce2c4b$d2864fb0$7792ef10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62689 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab3C2HIC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Mar 2013 03:08:02 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKE00LO7UHD93Q0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Mar 2013 16:08:01 +0900 (KST)
In-reply-to: <003301ce2c4b$d2864fb0$7792ef10$%han@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Viresh Kumar' <viresh.linux@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/mmc/host/sdhci-spear.c:295:12: warning: 'sdhci_suspend' defined but not used [-Wunused-function]
drivers/mmc/host/sdhci-spear.c:308:12: warning: 'sdhci_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-spear.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 8d28334..7ae5b3a 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -291,7 +291,7 @@ static int sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-- 
1.7.2.5


