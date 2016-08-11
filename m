From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH] mmc: host: vub300: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 23:03:53 +0200
Message-ID: <1470949433-24707-2-git-send-email-wsa-dev@sang-engineering.com>
References: <1470949433-24707-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470949433-24707-1-git-send-email-wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Tony Olech <tony.olech-ze5PQcJzaeOs0fm86SgGizGjJy/sRE9J@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

kmalloc will print enough information in case of failure.

Signed-off-by: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 drivers/mmc/host/vub300.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 1e819f98b94f52..bb3e0d1dd35501 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2116,13 +2116,11 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		dev_err(&udev->dev, "not enough memory for command_out_urb\n");
 		goto error0;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		dev_err(&udev->dev, "not enough memory for command_res_urb\n");
 		goto error1;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
