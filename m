From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Tue, 29 Mar 2016 19:43:34 +0900
Message-ID: <56FA5C56.9080009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35211 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcC2Kni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 06:43:38 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O4S01IQVR4M01D0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 29 Mar 2016 19:43:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>

This patch is just RFC. I want to know opinions.

Now, index of mmcblk is allocated in accordance with probing time.
If want to use the mmcblk1 for some device, it can use alias.

aliases {
	mmc0 = &mmc0;	/* mmcblk0 for eMMC */
	mmc1 = &mmc2;	/* mmcblk1 for SD */
	mmc2 = &mmc1;	/* mmcblk2 for SDIO*/
};

If there are no corresponding values, it might be allocated with
existing scheme.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 drivers/mmc/card/block.c                      | 17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9b..e37ea29 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -71,6 +71,10 @@ Optional SDIO properties:
 - wakeup-source: Enables wake up of host system on SDIO IRQ assertion
 		 (Legacy property supported: "enable-sdio-wakeup")
 
+Aliases (Optional):
+- If you want to use the fixed index for block device like mmcblkX, should be
+represented in the aliases node using following format "mmc(X)".
+(X is an unique number for the alias.)
 
 MMC power sequences:
 --------------------
@@ -145,3 +149,10 @@ mmc3: mmc@01c12000 {
 		interrupt-names = "host-wake";
 	};
 };
+
+Example with aliases nodes:
+
+aliases {
+	mmc0 = &mmc0;	/* Fixed to mmcblk0 for &mmc0 */
+	mmc1 = &mmc2;	/* Fixed to mmcblk1 for &mmc2 */
+};
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 3bdbe50..6a40de5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -35,6 +35,7 @@
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -2190,6 +2191,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
+	int idx = 0;
 
 	devidx = find_first_zero_bit(dev_use, max_devices);
 	if (devidx >= max_devices)
@@ -2209,7 +2211,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		if (card->dev.parent->parent->of_node)
+			idx = of_alias_get_id(card->dev.parent->parent->of_node,
+					"mmc");
+
+		if (idx < 0)
+			md->name_idx = find_first_zero_bit(name_use,
+					max_devices);
+		else {
+			if (test_bit(idx, name_use))
+				md->name_idx = find_first_zero_bit(name_use,
+						max_devices);
+			else
+				md->name_idx = (unsigned int)idx;
+		}
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
-- 
1.9.1
