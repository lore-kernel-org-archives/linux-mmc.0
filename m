From: stefan@agner.ch
Subject: [RFC 2/2] mmc: use SD/MMC host ID for block device name ID
Date: Tue,  1 Apr 2014 22:35:52 +0200
Message-ID: <2f6ac51155f9d34791b274b5102d15a997ff8b99.1396384101.git.stefan@agner.ch>
References: <cover.1396384101.git.stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1396384101.git.stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, stefan@agner.ch
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
---
 drivers/mmc/card/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7b5424f..03626ed 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2045,7 +2045,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
1.9.1
