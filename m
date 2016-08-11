From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH] mmc: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 23:03:52 +0200
Message-ID: <1470949433-24707-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This per-subsystem series is part of a tree wide cleanup. usb_alloc_urb() uses
kmalloc which already prints enough information on failure. So, let's simply
remove those "allocation failed" messages from drivers like we did already for
other -ENOMEM cases. gkh acked this approach when we talked about it at LCJ in
Tokyo a few weeks ago.


Wolfram Sang (1):
  mmc: host: vub300: don't print error when allocating urb fails

 drivers/mmc/host/vub300.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
