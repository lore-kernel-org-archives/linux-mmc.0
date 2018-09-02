From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Date: Sun,  2 Sep 2018 09:30:58 +0200
Message-ID: <20180902073058.17053-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-mmc@vger.kernel.org

after unbinding mmc I get things like this:
[  185.294067] mmc1: card 0001 removed
[  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13

The wakeirq stays in /proc-interrupts

rebinding shows this:
[  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
[  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
[  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling

That bug seems to be introduced by switching from devm_request_irq()
to generic wakeirq handling.

So let us cleanup at removal.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")
---
 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 071693ebfe18..68760d4a5d3d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2177,6 +2177,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	dma_release_channel(host->tx_chan);
 	dma_release_channel(host->rx_chan);
 
+	dev_pm_clear_wake_irq(host->dev);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-- 
2.11.0
