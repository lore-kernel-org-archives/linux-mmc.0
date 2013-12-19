From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 1/7] mmc: ushc: Fix incorrect parameter in sizeof
Date: Thu, 19 Dec 2013 14:13:28 +0530
Message-ID: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:37098 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3LSIqv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:46:51 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so841418pde.13
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 00:46:51 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, David Vrabel <david.vrabel@csr.com>

sizeof should be of the parent structure type.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/host/ushc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index c0105a2e269a..d2c386f09d69 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -504,7 +504,7 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
 		ret = -ENOMEM;
 		goto err;
 	}
-	ushc->csw = kzalloc(sizeof(struct ushc_cbw), GFP_KERNEL);
+	ushc->csw = kzalloc(sizeof(struct ushc_csw), GFP_KERNEL);
 	if (ushc->csw == NULL) {
 		ret = -ENOMEM;
 		goto err;
-- 
1.7.9.5

