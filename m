From: Shashidhar hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 2/2] mmc: Check to disable IOCTL when card is mounted
Date: Wed, 28 Dec 2011 17:07:57 +0530
Message-ID: <1325072277-16659-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37259 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1L1LiW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2011 06:38:22 -0500
Received: by iaeh11 with SMTP id h11so21921658iae.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2011 03:38:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The Patch adds a check to disable the IOCTL from running when the card is mounted
or device is opened elsewhere.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/card/block.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e680929..e513d20 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -387,8 +387,10 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		err = -EINVAL;
 		goto cmd_done;
 	}
-	/* Disallow the IOCTL run if card is already mounted or device is 
-	 * opened elsewhere */
+	/*
+	 * Disallow the IOCTL run if card is already mounted or device is
+	 * opened elsewhere
+	 */
 	if (md->usage > 3) {
 		err = -EINVAL;
 		goto cmd_done;
-- 
1.7.6.4

