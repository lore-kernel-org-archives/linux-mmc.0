From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: tmio: Fixup runtime PM management during probe
Date: Fri, 13 Sep 2019 11:41:09 +0200
Message-ID: <20190913094109.21192-1-ulf.hansson@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Simon Horman <horms+renesas@verge.net.au>, Niklas Soderlund <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The tmio_mmc_host_probe() calls pm_runtime_set_active() to update the
runtime PM status of the device, as to make it reflect the current status
of the HW. This works fine for most cases, but unfortunate not for all.
Especially, there is a generic problem when the device has a genpd attached
and that genpd have the ->start|stop() callbacks assigned.

More precisely, if the driver calls pm_runtime_set_active() during
->probe(), genpd does not get to invoke the ->start() callback for it,
which means the HW isn't really fully powered on. Furthermore, in the next
phase, when the device becomes runtime suspended, genpd will invoke the
->stop() callback for it, potentially leading to usage count imbalance
problems, depending on what's implemented behind the callbacks of course.

To fix this problem, convert to call pm_runtime_get_sync() from
tmio_mmc_host_probe() rather than pm_runtime_set_active(). Additionally, to
avoid bumping usage counters and unnecessary re-initializing the HW the
first time the tmio driver's ->runtime_resume() callback is called,
introduce a state flag to keeping track of this.

Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c5ba13fae399..2f0b092d6dcc 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -163,6 +163,7 @@ struct tmio_mmc_host {
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
+	bool			runtime_synced;
 	bool			sdio_irq_enabled;
 
 	/* Mandatory callback */
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 8b299c1f0069..32f9679ec42e 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1248,20 +1248,22 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto remove_host;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
 remove_host:
+	pm_runtime_put_noidle(&pdev->dev);
 	tmio_mmc_host_remove(_host);
 	return ret;
 }
@@ -1330,6 +1332,11 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
+	if (!host->runtime_synced) {
+		host->runtime_synced = true;
+		return 0;
+	}
+
 	tmio_mmc_clk_enable(host);
 	tmio_mmc_hw_reset(host->mmc);
 
-- 
2.17.1
