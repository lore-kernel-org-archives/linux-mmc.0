From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] mmc: mmci: Use pm_runtime_put_noidle() during ->probe()
Date: Fri, 19 Dec 2014 11:54:19 +0100
Message-ID: <1418986459-13443-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34784 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaLSKyZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:54:25 -0500
Received: by mail-la0-f42.google.com with SMTP id gd6so623616lab.15
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 02:54:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Russell King <linux@arm.linux.org.uk>

Previously the pm_runtime_put() caused the device to be runtime PM
suspended, but then immediately being resumed when we add the host.

Prevent this unnecessary runtime PM suspend/resume cycle during
->probe() by using the pm_runtime_put_noidle() variant instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Move pm_runtime_put_noidle() after mmc_add_host().

---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8232e9a..d2bbd25 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1739,10 +1739,10 @@ static int mmci_probe(struct amba_device *dev,
 
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
-	pm_runtime_put(&dev->dev);
 
 	mmc_add_host(mmc);
 
+	pm_runtime_put_noidle(&dev->dev);
 	return 0;
 
  clk_disable:
-- 
1.9.1

