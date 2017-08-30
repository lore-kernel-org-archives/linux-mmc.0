From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/2] mmc: dw_mmc: fix potential system abort if activating CONFIG_DEBUG_SHIRQ
Date: Wed, 30 Aug 2017 09:34:27 +0800
Message-ID: <1504056867-199188-3-git-send-email-shawn.lin@rock-chips.com>
References: <1504056867-199188-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504056867-199188-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
would still access the irq handler registed as a shard irq.
Per the comment within the function of __free_irq, it says
"It's a shared IRQ -- the driver ought to be prepared for
an IRQ event to happen even now it's being freed". However
when failing to probe the driver, dw_mmc disables the clock
and asserts the reset pin, even power off its genpd for accessing
the registers and the following check for shared irq state would call
the irq handler which accesses the register w/o all necessary resource
prepared. That will hang the system forever.

With adding some dump_stack we could see how that happened.

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

...

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00200c
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b

In order to fix this, we remove all the clock-disabling from
the error handle path and driver's remove function. And replying
on the devm_add_action_or_reset to fire the clock-disabling and reset
signal at the appropriate time.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- include a driver core change to fix the genpd issue.

 drivers/mmc/host/dw_mmc.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313b..610613a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3057,6 +3057,18 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 	}
 }
 
+static void dw_mci_post_cleanup(void *data)
+{
+	struct dw_mci *host = data;
+
+	clk_disable_unprepare(host->ciu_clk);
+	clk_disable_unprepare(host->biu_clk);
+
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+
+}
+
 int dw_mci_probe(struct dw_mci *host)
 {
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
@@ -3092,7 +3104,7 @@ int dw_mci_probe(struct dw_mci *host)
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
 			dev_err(host->dev, "failed to enable ciu clock\n");
-			goto err_clk_biu;
+			return ret;
 		}
 
 		if (host->pdata->bus_hz) {
@@ -3105,11 +3117,16 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	ret = devm_add_action_or_reset(host->dev, dw_mci_post_cleanup, host);
+	if (ret) {
+		dev_err(host->dev, "unable to add action or reset\n");
+		return ret;
+	}
+
 	if (!host->bus_hz) {
 		dev_err(host->dev,
 			"Platform data must supply bus speed\n");
-		ret = -ENODEV;
-		goto err_clk_ciu;
+		return -ENODEV;
 	}
 
 	if (!IS_ERR(host->pdata->rstc)) {
@@ -3123,7 +3140,7 @@ int dw_mci_probe(struct dw_mci *host)
 		if (ret) {
 			dev_err(host->dev,
 				"implementation specific init failed\n");
-			goto err_clk_ciu;
+			return ret;
 		}
 	}
 
@@ -3167,10 +3184,8 @@ int dw_mci_probe(struct dw_mci *host)
 	}
 
 	/* Reset all blocks */
-	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
-		ret = -ENODEV;
-		goto err_clk_ciu;
-	}
+	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS))
+		return -ENODEV;
 
 	host->dma_ops = host->pdata->dma_ops;
 	dw_mci_init_dma(host);
@@ -3257,15 +3272,6 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
-
-err_clk_ciu:
-	clk_disable_unprepare(host->ciu_clk);
-
-err_clk_biu:
-	clk_disable_unprepare(host->biu_clk);
-
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_probe);
@@ -3285,17 +3291,9 @@ void dw_mci_remove(struct dw_mci *host)
 
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
-
-	clk_disable_unprepare(host->ciu_clk);
-	clk_disable_unprepare(host->biu_clk);
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-
-
 #ifdef CONFIG_PM
 int dw_mci_runtime_suspend(struct device *dev)
 {
-- 
1.9.1
