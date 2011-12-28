From: Shashidhar hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc: Check to disable IOCTL when card is mounted
Date: Wed, 28 Dec 2011 16:16:20 +0530
Message-ID: <1325069180-16319-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62947 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1L1Kqh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2011 05:46:37 -0500
Received: by iaeh11 with SMTP id h11so21860232iae.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2011 02:46:37 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The Patch adds a check to disable the IOCTL from running when the card is mounted
or device is opened elsewhere.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/card/block.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0cad48a..e680929 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -387,6 +387,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		err = -EINVAL;
 		goto cmd_done;
 	}
+	/* Disallow the IOCTL run if card is already mounted or device is
+	 * opened elsewhere */
+	if (md->usage > 3) {
+		err = -EINVAL;
+		goto cmd_done;
+	}
 
 	card = md->queue.card;
 	if (IS_ERR(card)) {
-- 
1.7.6.4

