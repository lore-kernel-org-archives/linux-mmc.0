From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 24/27] mmc: tmio: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:49 +0200
Message-ID: <1380207292-16968-25-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:57695 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab3IZO4O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:56:14 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so607909eaj.40
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:56:13 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b380225..f3b2d8c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1145,12 +1145,9 @@ int tmio_mmc_host_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	int ret = mmc_suspend_host(mmc);
 
-	if (!ret)
-		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
-
-	return ret;
+	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_suspend);
 
@@ -1163,7 +1160,7 @@ int tmio_mmc_host_resume(struct device *dev)
 
 	/* The MMC core will perform the complete set up */
 	host->resuming = true;
-	return mmc_resume_host(mmc);
+	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_resume);
 
-- 
1.7.9.5

