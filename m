From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] mmc: ushc: fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:40:22 +0100
Message-ID: <20170313124022.28401-1-johan@kernel.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36247 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdCMMku (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Mar 2017 08:40:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: 53f3a9e26ed5 ("mmc: USB SD Host Controller (USHC) driver")
Cc: stable <stable@vger.kernel.org>	# 2.6.37
Cc: David Vrabel <david.vrabel@csr.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/ushc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index d2c386f09d69..1d843357422e 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -426,6 +426,9 @@ static int ushc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct ushc_data *ushc;
 	int ret;
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	mmc = mmc_alloc_host(sizeof(struct ushc_data), &intf->dev);
 	if (mmc == NULL)
 		return -ENOMEM;
-- 
2.12.0

