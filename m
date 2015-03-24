From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 2/4] mmc: sdhci: Support maximum DMA latency request via PM QOS
Date: Tue, 24 Mar 2015 15:40:38 +0200
Message-ID: <1427204440-3533-3-git-send-email-adrian.hunter@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32710 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbbCXNmt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 09:42:49 -0400
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add support for setting a maximum DMA latency via the
PM QOS framework.

Drivers can set host->dma_latency to the desired value
otherwise the initial value (PM_QOS_DEFAULT_VALUE)
will result in no PM QOS request being added.

It may be that there isn't time between consecutive
I/O requests to reach deeper C-states. To address
that the driver can set host->lat_cancel_delay which
is the delay before cancelling the DMA latency request
when it is known that there is another request on
the way.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d8be0bf..3a0859b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -724,6 +724,45 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
+static bool sdhci_pm_qos_use_dma_latency(struct sdhci_host *host)
+{
+	return host->dma_latency != PM_QOS_DEFAULT_VALUE;
+}
+
+static void sdhci_pm_qos_set_dma_latency(struct sdhci_host *host,
+					 struct mmc_request *mrq)
+{
+	if (sdhci_pm_qos_use_dma_latency(host) && mrq->data &&
+	    (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
+		pm_qos_update_request(&host->pm_qos_req, host->dma_latency);
+		host->pm_qos_set = true;
+	}
+}
+
+static void sdhci_pm_qos_unset(struct sdhci_host *host)
+{
+	unsigned int delay;
+
+	if (host->pm_qos_set) {
+		host->pm_qos_set = false;
+		delay = host->consecutive_req ? host->lat_cancel_delay : 0;
+		pm_qos_cancel_request_lazy(&host->pm_qos_req, delay);
+	}
+}
+
+static void sdhci_pm_qos_add(struct sdhci_host *host)
+{
+	if (sdhci_pm_qos_use_dma_latency(host))
+		pm_qos_add_request(&host->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
+				   PM_QOS_DEFAULT_VALUE);
+}
+
+static void sdhci_pm_qos_remove(struct sdhci_host *host)
+{
+	if (pm_qos_request_active(&host->pm_qos_req))
+		pm_qos_remove_request(&host->pm_qos_req);
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
@@ -1348,6 +1387,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	err = mmc_retune(mmc);
 
+	sdhci_pm_qos_set_dma_latency(host, mrq);
+
 	/* Firstly check card presence */
 	present = sdhci_do_get_cd(host);
 
@@ -1371,6 +1412,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	host->mrq = mrq;
+	host->consecutive_req = 0;
 
 	if (!err && (!present || host->flags & SDHCI_DEVICE_DEAD))
 		err = -ENOMEDIUM;
@@ -2167,6 +2209,8 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
+	host->consecutive_req = 1;
+
 	if (mrq->data->host_cookie) {
 		mrq->data->host_cookie = 0;
 		return;
@@ -2243,6 +2287,8 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 	host = (struct sdhci_host*)param;
 
+	sdhci_pm_qos_unset(host);
+
 	spin_lock_irqsave(&host->lock, flags);
 
         /*
@@ -2877,6 +2923,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->dma_latency = PM_QOS_DEFAULT_VALUE;
 
 	return host;
 }
@@ -3363,6 +3410,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	sdhci_pm_qos_add(host);
+
 	/*
 	 * Init tasklets.
 	 */
@@ -3426,6 +3475,7 @@ reset:
 #endif
 untasklet:
 	tasklet_kill(&host->finish_tasklet);
+	sdhci_pm_qos_remove(host);
 
 	return ret;
 }
@@ -3482,6 +3532,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
+
+	sdhci_pm_qos_remove(host);
 }
 
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5521d29..15c5e7b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 
 #include <linux/mmc/host.h>
+#include <linux/pm_qos.h>
 
 /*
  * Controller registers
@@ -419,6 +420,12 @@ struct sdhci_host {
 	struct mmc_host *mmc;	/* MMC structure */
 	u64 dma_mask;		/* custom DMA mask */
 
+	struct pm_qos_request pm_qos_req;
+	int dma_latency;
+	int lat_cancel_delay;
+	int consecutive_req;
+	bool pm_qos_set;
+
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 	struct led_classdev led;	/* LED control */
 	char led_name[32];
-- 
1.9.1

