From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 01/10] mmc: ushc: Fix incorrect parameter in sizeof
Date: Tue, 25 Feb 2014 15:18:19 +0530
Message-ID: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53675 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaBYJyJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:09 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so7863334pbc.32
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

sizeof should be of the parent structure type.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Hi Ulf / Chris,

This series which is a re-send has been pending since a very long time.
Hope to have this merged atleast during this cycle.
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

