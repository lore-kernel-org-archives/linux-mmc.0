From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: block: Block new req entering queue after its cleanup
Date: Thu, 13 Jul 2017 11:17:58 +0200
Message-ID: <20170713091758.2975-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33258 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdGMJSM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 05:18:12 -0400
Received: by mail-lf0-f46.google.com with SMTP id z78so33189295lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2017 02:18:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Grzegorz Sluja <grzegorzx.sluja@intel.com>, Linus Walleij <linus.walleij@linaro.org>

From: Grzegorz Sluja <grzegorzx.sluja@intel.com>

commit 304419d8a7e9204c5d19b704467b814df8c8f5b1
'mmc: core: Allocate per-request data using the block layer core'
refactored mechanism of queue handling caused mmc_init_request() can
be called just after mmc_cleanup_queue() caused null pointer dereference:

dmesg:
[  683.123791] BUG: unable to handle kernel NULL pointer dereference at (null)
[  683.123801] IP: mmc_init_request+0x2c/0xf0 [mmc_block]
...
[  683.123905] Call Trace:
[  683.123913]  alloc_request_size+0x4f/0x70
[  683.123919]  mempool_alloc+0x5f/0x150
[  683.123925]  ? __enqueue_entity+0x6c/0x70
[  683.123928]  get_request+0x3ad/0x720
[  683.123933]  ? prepare_to_wait_event+0x110/0x110
[  683.123937]  blk_queue_bio+0xc1/0x3a0
[  683.123940]  generic_make_request+0xf8/0x2a0
[  683.123942]  submit_bio+0x75/0x150
[  683.123947]  submit_bio_wait+0x51/0x70
[  683.123951]  blkdev_issue_flush+0x5c/0x90
[  683.123956]  ext4_sync_fs+0x171/0x1b0
[  683.123961]  sync_filesystem+0x73/0x90
[  683.123965]  fsync_bdev+0x24/0x50
[  683.123971]  invalidate_partition+0x24/0x50
[  683.123973]  del_gendisk+0xb2/0x2a0
[  683.123977]  mmc_blk_remove_req.part.38+0x71/0xa0 [mmc_block]
[  683.123980]  mmc_blk_remove+0xba/0x190 [mmc_block]
[  683.123990]  mmc_bus_remove+0x1a/0x20 [mmc_core]
[  683.123995]  device_release_driver_internal+0x141/0x200
[  683.123999]  device_release_driver+0x12/0x20
[  683.124001]  bus_remove_device+0xfd/0x170
[  683.124004]  device_del+0x1e8/0x330
[  683.124012]  mmc_remove_card+0x60/0xc0 [mmc_core]
[  683.124019]  mmc_remove+0x19/0x30 [mmc_core]
[  683.124025]  mmc_stop_host+0xfb/0x1a0 [mmc_core]
[  683.124032]  mmc_remove_host+0x1a/0x40 [mmc_core]
[  683.124037]  sdhci_remove_host+0x2e/0x1c0 [mmc_sdhci]
[  683.124042]  sdhci_pci_remove_slot+0x3f/0x80 [sdhci_pci]
[  683.124045]  sdhci_pci_remove+0x39/0x70 [sdhci_pci]
[  683.124049]  pci_device_remove+0x39/0xc0
[  683.124052]  device_release_driver_internal+0x141/0x200
[  683.124056]  driver_detach+0x3f/0x80
[  683.124059]  bus_remove_driver+0x55/0xd0
[  683.124062]  driver_unregister+0x2c/0x50
[  683.124065]  pci_unregister_driver+0x29/0x90
[  683.124069]  sdhci_driver_exit+0x10/0x4f3 [sdhci_pci]
[  683.124073]  SyS_delete_module+0x171/0x250
[  683.124078]  entry_SYSCALL_64_fastpath+0x1e/0xa9

Set queue DYING flag just before its cleaning blocked new req entering
the queue afterwards.

Signed-off-by: Grzegorz Sluja <grzegorzx.sluja@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Ulf, forwarding an important fix from Grzegorz at Intel, please
apply!

Linus
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0cfac2d39107..5ddde7dc9075 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2167,6 +2167,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
+		blk_set_queue_dying(md->queue.queue);
 		mmc_cleanup_queue(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
-- 
2.9.4

