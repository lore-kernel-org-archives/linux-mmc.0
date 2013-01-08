From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: mmci: Use devm_regulator_get API
Date: Tue,  8 Jan 2013 15:12:49 +0530
Message-ID: <1357638169-23321-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36534 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab3AHJvB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 04:51:01 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so145830pbc.5
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 01:51:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

devm_regulator_get is device managed and saves some cleanup
and exit code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested against linux-next tree (20130108).
---
 drivers/mmc/host/mmci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1507723..3ef9b1f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1386,7 +1386,7 @@ static int mmci_probe(struct amba_device *dev,
 
 #ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
-	host->vcc = regulator_get(&dev->dev, "vmmc");
+	host->vcc = devm_regulator_get(&dev->dev, "vmmc");
 	if (IS_ERR(host->vcc))
 		host->vcc = NULL;
 	else {
@@ -1587,7 +1587,6 @@ static int mmci_remove(struct amba_device *dev)
 
 		if (host->vcc)
 			mmc_regulator_set_ocr(mmc, host->vcc, 0);
-		regulator_put(host->vcc);
 
 		mmc_free_host(mmc);
 
-- 
1.7.4.1

