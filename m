From: Alexander Kappner <agk@godking.net>
Subject: [PATCH] [mmc_block] Prevent bus reference leak in mmc_blk_init
Date: Wed, 28 Mar 2018 15:18:31 -0700
Message-ID: <1522275511-7693-1-git-send-email-agk@godking.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, agk@godking.net
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Upon module load, mmc_block allocates a bus with bus_register in
mmc_blk_init. This reference never gets freed during module unload.
Subsequent re-insertions of the module fail and BUG() is triggered:

[   84.583342] sysfs: cannot create duplicate filename '/bus/mmc_rpmb'
[   84.583373] CPU: 6 PID: 1825 Comm: modprobe Tainted: P           O     4.16.0-rc6-00384-gf36b753 #30
[   84.583381] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET62W (1.35 ) 11/10/2016
[   84.583385] Call Trace:
[   84.583401]  dump_stack+0x5a/0x75
[   84.583411]  sysfs_warn_dup+0x58/0x70
[   84.583419]  sysfs_create_dir_ns+0x70/0x80
[   84.583437]  kobject_add_internal+0xa5/0x2c0
[   84.583453]  kset_register+0x44/0x60
[   84.583470]  bus_register+0xc6/0x270
[   84.583479]  ? 0xffffffffa000d000
[   84.583492]  mmc_blk_init+0x12/0x1000 [mmc_block]
[   84.583501]  do_one_initcall+0x4e/0x194
[   84.583510]  ? ___cache_free+0x21/0x2b0
[   84.583524]  do_init_module+0x5a/0x20f
[   84.583533]  load_module+0x235c/0x2510
[   84.583550]  ? SYSC_finit_module+0x80/0xb0
[   84.583558]  SYSC_finit_module+0x80/0xb0
[   84.583570]  do_syscall_64+0x77/0x290
[   84.583580]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[   84.583587] RIP: 0033:0x7f452a3ad5b9
[   84.583593] RSP: 002b:00007fff4562ba18 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[   84.583602] RAX: ffffffffffffffda RBX: 000056092895c520 RCX: 00007f452a3ad5b9
[   84.583607] RDX: 0000000000000000 RSI: 000056092697b3d9 RDI: 0000000000000003
[   84.583612] RBP: 000056092697b3d9 R08: 0000000000000000 R09: 000056092895d310
[   84.583617] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000000
[   84.583623] R13: 000056092895c430 R14: 0000000000040000 R15: 0000000000040000
[   84.583647] ------------[ cut here ]------------
[   84.583656] kobject_add_internal failed for mmc_rpmb with -EEXIST, don't try to register things with the same name in the same directory.
[   84.583694] WARNING: CPU: 6 PID: 1825 at lib/kobject.c:238 kobject_add_internal+0x296/0x2c0
[   84.583705] Modules linked in: mmc_block(+) rtsx_pci_sdmmc rtsx_pci iwlmvm mac80211 nvidia_drm(PO) nvidia_modeset(PO) iwlwifi nvidia(PO) cfg80211 qmi_wwan thinkpad_acpi rfkill sdhci_pci cqhci sdhci mfd_core [last unloaded: mmc_block]
[   84.583770] CPU: 6 PID: 1825 Comm: modprobe Tainted: P           O     4.16.0-rc6-00384-gf36b753 #30
[   84.583774] Hardware name: LENOVO 20ENCTO1WW/20ENCTO1WW, BIOS N1EET62W (1.35 ) 11/10/2016
[   84.583782] RIP: 0010:kobject_add_internal+0x296/0x2c0
[   84.583786] RSP: 0018:ffffc9000769bc58 EFLAGS: 00010296
[   84.583791] RAX: 000000000000007d RBX: ffff880fcf588618 RCX: 0000000000000000
[   84.583796] RDX: 0000000000040400 RSI: 00000000000000f6 RDI: 00000000ffffffff
[   84.583801] RBP: 00000000ffffffef R08: 0000000000000000 R09: 0000000000000354
[   84.583806] R10: ffffffff8251fc74 R11: 0000000000000353 R12: ffff88100d3cf698
[   84.583811] R13: ffff880fcf588618 R14: ffffffffa0028590 R15: ffffffffa0028540
[   84.583818] FS:  00007f452a853700(0000) GS:ffff881053d80000(0000) knlGS:0000000000000000
[   84.583823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.583837] CR2: 00007f452a3faea0 CR3: 0000000fc89e4004 CR4: 00000000003606e0
[   84.583850] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.583863] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.583875] Call Trace:
[   84.583893]  kset_register+0x44/0x60
[   84.583902]  bus_register+0xc6/0x270
[   84.583910]  ? 0xffffffffa000d000
[   84.583926]  mmc_blk_init+0x12/0x1000 [mmc_block]
[   84.583940]  do_one_initcall+0x4e/0x194
[   84.583948]  ? ___cache_free+0x21/0x2b0
[   84.583966]  do_init_module+0x5a/0x20f
[   84.583979]  load_module+0x235c/0x2510
[   84.583995]  ? SYSC_finit_module+0x80/0xb0
[   84.584001]  SYSC_finit_module+0x80/0xb0
[   84.584010]  do_syscall_64+0x77/0x290
[   84.584016]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[   84.584021] RIP: 0033:0x7f452a3ad5b9
[   84.584025] RSP: 002b:00007fff4562ba18 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[   84.584030] RAX: ffffffffffffffda RBX: 000056092895c520 RCX: 00007f452a3ad5b9
[   84.584034] RDX: 0000000000000000 RSI: 000056092697b3d9 RDI: 0000000000000003
[   84.584038] RBP: 000056092697b3d9 R08: 0000000000000000 R09: 000056092895d310
[   84.584043] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000000
[   84.584047] R13: 000056092895c430 R14: 0000000000040000 R15: 0000000000040000
[   84.584053] Code: 7b 20 49 89 c4 48 85 ff 0f 84 10 fe ff ff e9 cd fd ff ff 48 8b 13 48 c7 c6 00 80 f4 81 48 c7 c7 e0 ad 0f 82 31 c0 e8 ca 9a 7b ff <0f> 0b e9 5f fe ff ff 0f 0b 0f 0b 0f 0b 0f 0b e9 71 ff ff ff 0f
[   84.584147] ---[ end trace d27b36e0e2c0e7e5 ]---
[   84.584162] mmcblk: could not register RPMB bus type

Steps to reproduce:

Build with CONFIG_MMC_BLOCK=m

modprobe mmc_block
rmmod mmc_block
modprobe mmc_block

The proposed patch deallocates the reference in mmc_blk_exit.

Signed-off-by: Alexander Kappner <agk@godking.net>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2cfb963..9c6f639 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3087,6 +3087,7 @@ static void __exit mmc_blk_exit(void)
 	mmc_unregister_driver(&mmc_driver);
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
+	bus_unregister(&mmc_rpmb_bus_type);
 }
 
 module_init(mmc_blk_init);
-- 
2.1.4
