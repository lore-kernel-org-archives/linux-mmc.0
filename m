From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4] mmc: dw_mmc: fix potential system abort
Date: Tue, 26 Sep 2017 16:46:06 +0800
Message-ID: <1506415566-115405-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:56497 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936810AbdIZIrL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 04:47:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mmc allows the variant drivers to register the interrupt
as a shared irq, which means dw_mmc should guarantee to properly
handle the irq at any time, even if the irq isn't belong to itself.
So there is a timing gap that the dw_mmc is being removed but the
shared irq comes concurrently. The clock/reset controller/power
domain for accessing the controller had been off before the irq
comes in, so that the irq handler, dw_mci_interrupt, would still
try to read the MINTSTS to see if the irq belongs to this controller.
However, at least for rockchip platforms, it doesn't allow to access
the controller w/o clock and power domain be in the active state.

To quick reproduce that, we could enable CONFIG_DEBUG_SHIRQ.
the irq tear down routine would still access the irq handler registed
as a shard irq. Per the comment within the function of __free_irq, it
says "It's a shared IRQ -- the driver ought to be prepared for an IRQ
event to happen even now it's being freed". So whenever we fail to probe
the driver or unbind the driver, the system abort.

Synopsys Designware Multimedia Card Interface Driver
dwmmc_rockchip fe320000.dwmmc: IDMAC supports 32-bit address mode.
dwmmc_rockchip fe320000.dwmmc: Using internal DMA controller.
dwmmc_rockchip fe320000.dwmmc: Version ID is 270a
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.13.0-rc3-next-20170807-00004-g93d3644-dirty #5
Hardware name: Firefly-RK3399 Board (DT)
Call trace:
[<ffff20000808b5a0>] dump_backtrace+0x0/0x300
[<ffff20000808ba1c>] show_stack+0x14/0x20
[<ffff200008dc480c>] dump_stack+0xa4/0xc8
[<ffff200008b9691c>] dw_mci_interrupt+0x3c/0x6a8
[<ffff200008157450>] __free_irq+0x308/0x410
[<ffff20000815760c>] free_irq+0x54/0xb0
[<ffff20000815d630>] devm_irq_release+0x30/0x40
[<ffff2000087f0174>] release_nodes+0x1e4/0x390
[<ffff2000087f04c0>] devres_release_all+0x50/0x78
[<ffff2000087e9bc0>] driver_probe_device+0x128/0x3b8
[<ffff2000087e9f34>] __driver_attach+0xe4/0xe8
[<ffff2000087e7048>] bus_for_each_dev+0xe0/0x138
[<ffff2000087e93b8>] driver_attach+0x30/0x40
[<ffff2000087e8c00>] bus_add_driver+0x1d0/0x328
[<ffff2000087ead0c>] driver_register+0xb4/0x198
[<ffff2000087ec98c>] __platform_driver_register+0x7c/0x88
[<ffff2000095bc564>] dw_mci_rockchip_pltfm_driver_init+0x18/0x20
[<ffff200008083a8c>] do_one_initcall+0x14c/0x1b8
[<ffff200009560ff8>] kernel_init_freeable+0x238/0x2d8
[<ffff200008dde500>] kernel_init+0x10/0x110
[<ffff2000080836c0>] ret_from_fork+0x10/0x50
Synchronous External Abort: synchronous external abort (0x96000010) at
0xffff20000aaa4040
Internal error: : 96000010 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
task: ffff80006ba28080 task.stack: ffff80006ba24000
PC is at dw_mci_interrupt+0x4c/0x6a8
LR is at dw_mci_interrupt+0x44/0x6a8
pc : [<ffff200008b9692c>] lr : [<ffff200008b96924>] pstate: 600001c5

In order to fix this more visible, we introduce new bool variable
'driver_removed' to bail out early from the irq handler if the driver
had been removed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- remove the driver core change from v3 and add new flag to solve this
issue instead of adding devm_add_action_or_reset.

 drivers/mmc/host/dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313b..bb4c608 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2595,6 +2595,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	u32 pending;
 	struct dw_mci_slot *slot = host->slot;
 
+	if (host->driver_removed)
+		return IRQ_NONE;
+
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
 	if (pending) {
@@ -3221,6 +3224,8 @@ int dw_mci_probe(struct dw_mci *host)
 	else
 		host->fifo_reg = host->regs + DATA_240A_OFFSET;
 
+	host->driver_removed = false;
+
 	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
 	ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
 			       host->irq_flags, "dw-mci", host);
@@ -3266,6 +3271,7 @@ int dw_mci_probe(struct dw_mci *host)
 err_clk_biu:
 	clk_disable_unprepare(host->biu_clk);
 
+	host->driver_removed = true;
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_probe);
@@ -3291,6 +3297,8 @@ void dw_mci_remove(struct dw_mci *host)
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
+
+	host->driver_removed = true;
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-- 
1.9.1


