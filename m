From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: mmci: Use pm_runtime_put_noidle() during ->probe()
Date: Fri, 19 Dec 2014 10:50:22 +0100
Message-ID: <1418982622-8118-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38455 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaLSJu2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 04:50:28 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so568639lbj.13
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 01:50:26 -0800 (PST)
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
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8232e9a..3a05fca 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1739,7 +1739,7 @@ static int mmci_probe(struct amba_device *dev,
 
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
-	pm_runtime_put(&dev->dev);
+	pm_runtime_put_noidle(&dev->dev);
 
 	mmc_add_host(mmc);
 
-- 
1.9.1

