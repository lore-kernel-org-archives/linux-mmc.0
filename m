From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: wbsd: Silence compiler warning
Date: Mon, 28 Oct 2013 19:46:10 +0100
Message-ID: <1382985970-14583-2-git-send-email-ulf.hansson@linaro.org>
References: <1382985970-14583-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:38074 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298Ab3J1SqS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 14:46:18 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so4064328oag.35
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2013 11:46:17 -0700 (PDT)
In-Reply-To: <1382985970-14583-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Pierre Ossman <pierre@ossman.eu>

The commit "mmc: wbsd: Move away from using deprecated APIs" introduced
a compiler warning, let's silence it.

Cc: Pierre Ossman <pierre@ossman.eu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/wbsd.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 024c824..1defd5e 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1859,7 +1859,6 @@ static int wbsd_platform_resume(struct platform_device *dev)
 static int wbsd_pnp_suspend(struct pnp_dev *pnp_dev, pm_message_t state)
 {
 	struct mmc_host *mmc = dev_get_drvdata(&pnp_dev->dev);
-	struct wbsd_host *host;
 
 	if (mmc == NULL)
 		return 0;
-- 
1.7.9.5

