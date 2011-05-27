From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: vub300: fix null dereferences in error handling
Date: Thu, 26 May 2011 23:16:24 -0400
Message-ID: <m3boyou92v.fsf@pullcord.laptop.org>
References: <20110526171455.GJ14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39623 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab1E0DPO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 May 2011 23:15:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: tony.olech@elandigitalsystems.com, linux-mmc@vger.kernel.org

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
On Thu, May 26 2011, Dan Carpenter wrote:
> In vub300_probe() from drivers/mmc/host/vub300.c we dereference
> vub300 when it's a NULL variable.  Btw, let's remove the bogus
> initialization to NULL so that gcc will complain if the bug gets
> introduced again.

Thanks Dan -- I'll queue this fix up:

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index cbb0330..d4455ff 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2096,7 +2096,7 @@ static struct mmc_host_ops vub300_mmc_ops = {
 static int vub300_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {				/* NOT irq */
-	struct vub300_mmc_host *vub300 = NULL;
+	struct vub300_mmc_host *vub300;
 	struct usb_host_interface *iface_desc;
 	struct usb_device *udev = usb_get_dev(interface_to_usbdev(interface));
 	int i;
@@ -2118,23 +2118,20 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		dev_err(&vub300->udev->dev,
-			"not enough memory for the command_out_urb\n");
+		dev_err(&udev->dev, "not enough memory for command_out_urb\n");
 		goto error0;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		dev_err(&vub300->udev->dev,
-			"not enough memory for the command_res_urb\n");
+		dev_err(&udev->dev, "not enough memory for command_res_urb\n");
 		goto error1;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
-		dev_err(&vub300->udev->dev,
-			"not enough memory for the mmc_host\n");
+		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
 		goto error4;
 	}
 	/* MMC core transfer sizes tunable parameters */

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
