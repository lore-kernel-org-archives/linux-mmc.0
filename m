From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: block: cast a informative log for no devidx available
Date: Wed, 23 Aug 2017 15:38:31 +0800
Message-ID: <1503473911-124754-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:53316 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdHWHjq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Aug 2017 03:39:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

The intention for this patch is to help folks debug the failure
like this:

dwmmc_rockchip fe320000.dwmmc: IDMAC supports 32-bit address mode.
dwmmc_rockchip fe320000.dwmmc: Using internal DMA controller.
dwmmc_rockchip fe320000.dwmmc: Version ID is 270a
dwmmc_rockchip fe320000.dwmmc: DW MMC controller at irq 28,32 bit
host data width,256 deep fifo
dwmmc_rockchip fe320000.dwmmc: Got CD GPIO
mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual
400000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz,
actual 50000000HZ div = 0)
mmc0: new high speed SDHC card at address 0007
mmcblk: probe of mmc0:0007 failed with error -28

The reason may be some buggy userspace daemon miss the disk remove
uevent sometimes so it would finally make the SD card not work.
So from the dmesg it only shows a errno of -28 but still don't understand
what happened.

For quick reproduce this, we could set max_devices to 8 and run

for i in $(seq 1 9); do
  echo "========================" $i
  echo fe320000.dwmmc > /sys/bus/platform/drivers/dwmmc_rockchip/unbind
  sleep .5
  echo fe320000.dwmmc > /sys/bus/platform/drivers/dwmmc_rockchip/bind
  sleep .5
  mount -t vfat /dev/mmcblk0 /mnt
  sleep .5
done

Another possible reason would be the device has more partitions than
what we support, so that they have to increase their max_devices.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rephase the comment and log suggested by Ulf and remove the check for
  removable cards

 drivers/mmc/core/block.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0eebc2f..b95c3b0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2034,8 +2034,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	int devidx, ret;
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
-	if (devidx < 0)
+	if (devidx < 0) {
+		/*
+		 * We get -ENOSPC because there are no more any available
+		 * devidx. The reason may be that, either userspace haven't yet
+		 * unmounted the partitions, which postpones mmc_blk_release()
+		 * from being called, or the device has more partitions than
+		 * what we support.
+		 */
+		if (devidx == -ENOSPC)
+			dev_err(mmc_dev(card->host),
+				"no more device IDs available\n");
+
 		return ERR_PTR(devidx);
+	}
 
 	md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
 	if (!md) {
-- 
1.9.1


