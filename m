From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 1/7] mmc: ushc: Fix incorrect parameter in sizeof
Date: Wed, 30 Oct 2013 17:13:44 +0530
Message-ID: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:51668 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3J3Lum (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:50:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so1262232pbb.17
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:50:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, David Vrabel <david.vrabel@csr.com>

sizeof should be of the parent structure type.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: David Vrabel <david.vrabel@csr.com>
---
Chris,
Resending the pending patches with appropriate acks.
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

