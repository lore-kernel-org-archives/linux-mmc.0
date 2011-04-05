From: John Calixto <john.calixto@modsystems.com>
Subject: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Tue, 5 Apr 2011 14:59:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104051458350.25803@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:44117 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940Ab1DEV7b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 17:59:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

Some ACMDs might actually damage the card.  This check ensures the
caller has CAP_SYS_ADMIN before allowing such an activity.

Signed-off-by: John Calixto <john.calixto@modsystems.com>
---
 drivers/mmc/card/block.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c2e107c..2ed8c57 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -31,6 +31,7 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
+#include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
 
@@ -205,6 +206,34 @@ static int mmc_blk_ioctl_acmd(struct block_device *bdev,
 		goto acmd_done;
 	}
 
+	/*
+	 * The following ACMDs are known to be nondestructive.  They are used
+	 * by SD security applications (ref: SD Specifications, Part 1,
+	 * Physical Layer Simplified Specification, Version 3.01, Table 4-27).
+	 * Any other commands require CAP_SYS_ADMIN because they may destroy
+	 * the card.
+	 */
+	switch (sdic.opcode) {
+	case SD_APP_SD_STATUS:
+	case 18:
+	case 25:
+	case 26:
+	case 38:
+	case 43:
+	case 44:
+	case 45:
+	case 46:
+	case 47:
+	case 48:
+	case 49:
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN)) {
+			err = -EPERM;
+			goto acmd_done;
+		}
+	}
+
 	cmd.opcode = sdic.opcode;
 	cmd.arg = sdic.arg;
 	cmd.flags = sdic.flags;
-- 
1.7.4.1
