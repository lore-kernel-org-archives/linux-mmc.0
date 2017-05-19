From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/41] mmc: host: omap_hsmmc: Fix error path sequence
Date: Fri, 19 May 2017 13:45:12 +0530
Message-ID: <20170519081541.26753-13-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Fix the error path sequence so that clk_disable, runtime_disable etc
are done in the reverse order of how they were enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8114b8b73491..b28f0e9631ce 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2602,16 +2602,16 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 err_slot_name:
 	mmc_remove_host(mmc);
 err_irq:
-	device_init_wakeup(&pdev->dev, false);
 	if (!IS_ERR_OR_NULL(host->tx_chan))
 		dma_release_channel(host->tx_chan);
 	if (!IS_ERR_OR_NULL(host->rx_chan))
 		dma_release_channel(host->rx_chan);
+	if (host->dbclk)
+		clk_disable_unprepare(host->dbclk);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-	if (host->dbclk)
-		clk_disable_unprepare(host->dbclk);
+	device_init_wakeup(&pdev->dev, false);
 err1:
 err_gpio:
 	mmc_free_host(mmc);
-- 
2.11.0

