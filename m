From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] mmc: mvsdio: Convert to devm_ioremap_resource
Date: Thu, 12 Sep 2013 12:16:34 +0530
Message-ID: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:51129 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3ILHEn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 03:04:43 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so10197780pbc.17
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 00:04:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, nico@fluxnic.net, sachin.kamat@linaro.org

devm_request_and_ioremap() is deprecated. Use devm_ioremap_resource()
instead.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/mvsdio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 06c5b0b..a592407 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -775,9 +775,9 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!host->base) {
-		ret = -ENOMEM;
+	host->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
 		goto out;
 	}
 
-- 
1.7.9.5

