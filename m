From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 1/7] mmc: omap: Fix NULL pointer dereference due uninitialized cover_tasklet
Date: Sat, 22 Feb 2014 18:01:37 +0200
Message-ID: <1393084903-7194-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

Omap MMC driver initialization can cause a NULL pointer dereference in
tasklet_hi_action on Nokia N810 if its miniSD cover is open during driver
initialization.

[    1.070000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    1.080000] pgd = c0004000
[    1.080000] [00000000] *pgd=00000000
[    1.080000] Internal error: Oops: 80000005 [#1] PREEMPT ARM
[    1.080000] Modules linked in:
[    1.080000] CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 3.13.0-rc2+ #95
[    1.080000] Workqueue: events menelaus_work
[    1.080000] task: c7863340 ti: c7878000 task.ti: c7878000
[    1.080000] PC is at 0x0
[    1.080000] LR is at tasklet_hi_action+0x68/0xa4
...
[    1.080000] [<c003543c>] (tasklet_hi_action+0x68/0xa4) from [<c0034dd0>] (__do_softirq+0xbc/0x208)
[    1.080000] [<c0034dd0>] (__do_softirq+0xbc/0x208) from [<c003521c>] (irq_exit+0x84/0xac)
[    1.080000] [<c003521c>] (irq_exit+0x84/0xac) from [<c00135cc>] (handle_IRQ+0x64/0x84)
[    1.080000] [<c00135cc>] (handle_IRQ+0x64/0x84) from [<c000859c>] (omap2_intc_handle_irq+0x54/0x68)
[    1.080000] [<c000859c>] (omap2_intc_handle_irq+0x54/0x68) from [<c0015be0>] (__irq_svc+0x40/0x74)
[    1.080000] Exception stack(0xc7879d70 to 0xc7879db8)
[    1.080000] 9d60:                                     000003f1 0000000a 00000009 0000001c
[    1.080000] 9d80: c7879e70 c780bc10 c780bc10 00000000 00000001 00008603 c780bc78 c7879e4e
[    1.080000] 9da0: 00000002 c7879db8 c00343b0 c0160c9c 20000113 ffffffff
[    1.080000] [<c0015be0>] (__irq_svc+0x40/0x74) from [<c0160c9c>] (__aeabi_uidiv+0x20/0x9c)
[    1.080000] [<c0160c9c>] (__aeabi_uidiv+0x20/0x9c) from [<c00343b0>] (msecs_to_jiffies+0x18/0x24)
[    1.080000] [<c00343b0>] (msecs_to_jiffies+0x18/0x24) from [<c01ec3ec>] (omap_i2c_xfer+0x30c/0x458)
[    1.080000] [<c01ec3ec>] (omap_i2c_xfer+0x30c/0x458) from [<c01e9724>] (__i2c_transfer+0x3c/0x74)
[    1.080000] [<c01e9724>] (__i2c_transfer+0x3c/0x74) from [<c01eac4c>] (i2c_transfer+0x78/0x94)
[    1.080000] [<c01eac4c>] (i2c_transfer+0x78/0x94) from [<c01eb0bc>] (i2c_smbus_xfer+0x3c0/0x4f8)
[    1.080000] [<c01eb0bc>] (i2c_smbus_xfer+0x3c0/0x4f8) from [<c01eb414>] (i2c_smbus_write_byte_data+0x34/0x3c)
[    1.080000] [<c01eb414>] (i2c_smbus_write_byte_data+0x34/0x3c) from [<c01bb308>] (menelaus_write_reg+0x1c/0x40)
[    1.080000] [<c01bb308>] (menelaus_write_reg+0x1c/0x40) from [<c01bb904>] (menelaus_work+0xa0/0xc4)
[    1.080000] [<c01bb904>] (menelaus_work+0xa0/0xc4) from [<c00439c4>] (process_one_work+0x1fc/0x334)
[    1.080000] [<c00439c4>] (process_one_work+0x1fc/0x334) from [<c0043d6c>] (worker_thread+0x244/0x380)
[    1.080000] [<c0043d6c>] (worker_thread+0x244/0x380) from [<c0049d04>] (kthread+0xc0/0xd4)
[    1.080000] [<c0049d04>] (kthread+0xc0/0xd4) from [<c0012758>] (ret_from_fork+0x14/0x3c)
[    1.080000] Code: bad PC value
[    1.090000] ---[ end trace 7bc2fc7cd14f1d95 ]---
[    1.100000] Kernel panic - not syncing: Fatal exception in interrupt

Reason for this is that omap_notify_cover_event which calls
tasklet_hi_schedule gets called before struct cover_tasklet is initialized.

Call to omap_notify_cover_event on Nokia N810 happens from menelaus.c PMIC
driver via board-n8x0.c during execution of mmc_add_host in case of open
miniSD cover.

Fix this by moving cover_timer and cover_tasklet initialization before
mmc_add_host call in mmc_omap_new_slot.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
v2: a snip of stack dump added to commit log
---
 drivers/mmc/host/omap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 98b6b6ef7e5c..42b665dfaa73 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1262,6 +1262,13 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
+	if (slot->pdata->get_cover_state != NULL) {
+		setup_timer(&slot->cover_timer, mmc_omap_cover_timer,
+			    (unsigned long)slot);
+		tasklet_init(&slot->cover_tasklet, mmc_omap_cover_handler,
+			     (unsigned long)slot);
+	}
+
 	r = mmc_add_host(mmc);
 	if (r < 0)
 		goto err_remove_host;
@@ -1278,11 +1285,6 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 					&dev_attr_cover_switch);
 		if (r < 0)
 			goto err_remove_slot_name;
-
-		setup_timer(&slot->cover_timer, mmc_omap_cover_timer,
-			    (unsigned long)slot);
-		tasklet_init(&slot->cover_tasklet, mmc_omap_cover_handler,
-			     (unsigned long)slot);
 		tasklet_schedule(&slot->cover_tasklet);
 	}
 
-- 
1.8.5.3

