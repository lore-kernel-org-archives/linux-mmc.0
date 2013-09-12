From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: ushc: Fix incorrect parameter in sizeof
Date: Thu, 12 Sep 2013 13:44:13 +0530
Message-ID: <1378973653-12750-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44612 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3ILIc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:32:27 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so10378763pdj.30
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:32:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, David Vrabel <david.vrabel@csr.com>

sizeof should be of the parent structure type.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: David Vrabel <david.vrabel@csr.com>
---
Compile tested.
---
 drivers/mmc/host/ushc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index c0105a2..d2c386f 100644
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

