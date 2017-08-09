From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: vub300: constify usb_device_id
Date: Wed,  9 Aug 2017 23:20:58 +0530
Message-ID: <a92e1ae63bb48adf6b7983ba3a150f9579444cc0.1502300918.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33371 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdHIRvJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2017 13:51:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony.olech@elandigitalsystems.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/vub300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index fbeea1a..6c99102 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -266,7 +266,7 @@ MODULE_PARM_DESC(firmware_rom_wait_states,
 #define ELAN_VENDOR_ID		0x2201
 #define VUB300_VENDOR_ID	0x0424
 #define VUB300_PRODUCT_ID	0x012C
-static struct usb_device_id vub300_table[] = {
+static const struct usb_device_id vub300_table[] = {
 	{USB_DEVICE(ELAN_VENDOR_ID, VUB300_PRODUCT_ID)},
 	{USB_DEVICE(VUB300_VENDOR_ID, VUB300_PRODUCT_ID)},
 	{} /* Terminating entry */
-- 
2.7.4

