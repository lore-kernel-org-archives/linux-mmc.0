From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/27] mmc: vub300: Remove redundant suspend and resume callbacks
Date: Thu, 26 Sep 2013 16:54:35 +0200
Message-ID: <1380207292-16968-11-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:60478 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3IZOze (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:55:34 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so608072eak.18
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:55:33 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Olech <tony.olech@elandigitalsystems.com>, linux-usb@vger.kernel.org

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

While moving away from using the deprecated APIs, there are nothing
left to be done for the suspend and resume callbacks, so remove them.

Cc: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/vub300.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index e9028ad..db99edc 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2389,34 +2389,6 @@ static void vub300_disconnect(struct usb_interface *interface)
 	}
 }
 
-#ifdef CONFIG_PM
-static int vub300_suspend(struct usb_interface *intf, pm_message_t message)
-{
-	struct vub300_mmc_host *vub300 = usb_get_intfdata(intf);
-	if (!vub300 || !vub300->mmc) {
-		return 0;
-	} else {
-		struct mmc_host *mmc = vub300->mmc;
-		mmc_suspend_host(mmc);
-		return 0;
-	}
-}
-
-static int vub300_resume(struct usb_interface *intf)
-{
-	struct vub300_mmc_host *vub300 = usb_get_intfdata(intf);
-	if (!vub300 || !vub300->mmc) {
-		return 0;
-	} else {
-		struct mmc_host *mmc = vub300->mmc;
-		mmc_resume_host(mmc);
-		return 0;
-	}
-}
-#else
-#define vub300_suspend NULL
-#define vub300_resume NULL
-#endif
 static int vub300_pre_reset(struct usb_interface *intf)
 {				/* NOT irq */
 	struct vub300_mmc_host *vub300 = usb_get_intfdata(intf);
@@ -2437,8 +2409,6 @@ static struct usb_driver vub300_driver = {
 	.name = "vub300",
 	.probe = vub300_probe,
 	.disconnect = vub300_disconnect,
-	.suspend = vub300_suspend,
-	.resume = vub300_resume,
 	.pre_reset = vub300_pre_reset,
 	.post_reset = vub300_post_reset,
 	.id_table = vub300_table,
-- 
1.7.9.5

