From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] mmc: use SD/MMC host ID for block device name ID
Date: Thu, 28 Apr 2016 16:06:45 -0700
Message-ID: <1461884805-29466-4-git-send-email-dianders@chromium.org>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, Douglas Anderson <dianders@chromium.org>, justin.wang@spreadtrum.com, huangtao@rock-chips.com, lporzio@micron.com, ksumrall@android.com, jonathanh@nvidia.com, chuanxiao.dong@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

By using the SD/MMC host device ID as a starting point for block
device numbering, one can reliably predict the first block device
name (at least for the first controller). This is especially useful
for SoCs with multiple SD/MMC host controller, where the controller
with index 0 is connected to a eMMC device.

Usually the first controller gets the first block device name ID,
however this is not guaranteed. Also if the first controller is
aliased as second controller and visa-versa (using device tree
aliases), the block device name ID assignation is not ordered by
the SD/MMC host device ID (since mmc_rescan is called in order of
the memory mapped pheripherial addresses).

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/mmc/card/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9fef7f04c4e6..bcf4fdbb5221 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2215,7 +2215,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		md->name_idx = find_next_zero_bit(name_use, max_devices,
+				card->host->index);
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
-- 
2.8.0.rc3.226.g39d4020
