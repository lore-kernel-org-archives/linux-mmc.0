From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [RFC 1/2] mmc: block: allow setting name_idx via devicetree
Date: Wed, 24 Jul 2013 11:09:32 +0200
Message-ID: <1374656973-16250-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56703 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab3GXJJ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2013 05:09:59 -0400
In-Reply-To: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>

As with gpio, uart and others, allow specifying the name_idx via the
aliases-node in the devicetree.

On embedded devices, there is often a combination of removable (e.g.
SD card) and non-removable mmc devices (e.g. eMMC).
Therefore the name_idx might change depending on
	- host of removable device
	- removable card present or not

This makes it difficult to hard code the root device, if it is on the
non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
if SD card is not present at boot, eMMC will be mmcblk0.

If the aliases-node is not found, the driver will act as before.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

---
 drivers/mmc/card/block.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cd0b7f4..5853c59 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -35,6 +35,7 @@
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -2005,7 +2006,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		ret = of_alias_get_id(card->host->parent->of_node, "mmc");
+		if (ret < 0)
+			md->name_idx = find_first_zero_bit(name_use, max_devices);
+		else
+			md->name_idx = ret;
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
-- 
1.8.3.2

