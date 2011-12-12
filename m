From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc: Extended the mmc_ioc_cmd IOCTL to return the cmd error number
Date: Mon, 12 Dec 2011 15:53:36 +0530
Message-ID: <1323685416-4306-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1LLKYN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 05:24:13 -0500
Received: by iaeh11 with SMTP id h11so3000151iae.19
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2011 02:24:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Kyungmin Park <kyungmin.park@samsung.com>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The patch adds the enhancement to mmc_ioc_cmd structure to also fill the error  message so that user is aware of the error that has occured while sending a command.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/card/block.c  |    4 ++++
 include/linux/mmc/ioctl.h |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0c959c9..12523bb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -448,6 +448,10 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
+		if (copy_to_user(&(ic_ptr->error)
+				  , &cmd.error, sizeof(cmd.error)))
+			err = -EFAULT;
+
 		err = cmd.error;
 		goto cmd_rel_host;
 	}
diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
index 8fa5bc5..3514ddc 100644
--- a/include/linux/mmc/ioctl.h
+++ b/include/linux/mmc/ioctl.h
@@ -39,6 +39,9 @@ struct mmc_ioc_cmd {
 
 	/* DAT buffer */
 	__u64 data_ptr;
+	/* The error status for the Command sent */
+	unsigned int error;
+
 };
 #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
 
-- 
1.7.6.4

