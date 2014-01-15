From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 1/9] mmc: ushc: Fix incorrect parameter in sizeof
Date: Wed, 15 Jan 2014 11:25:05 +0530
Message-ID: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51612 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaAOF7Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:24 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so676103pbc.12
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:24 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

sizeof should be of the parent structure type.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Resending this series once again as it hasn't received Chris'
attention during the previous re-sends. Hope Chris will pick it
up atleast this time considering it is pending since a few months
now and has been acked by the concerned people.
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

