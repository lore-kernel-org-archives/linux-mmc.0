From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/7] mmc: serialization support
Date: Mon, 13 Sep 2010 18:39:32 +0100
Message-ID: <20100913173920.20345.36169.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25134 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab0IMSYH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:24:07 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Some hardware has restrictions that require only one command is outstanding
per controller or some other similar restriction.

Provide optional serialization support and enable it for the Intel MID
platform devices with this restriction. Split up from some existing patches
by JiebingLi.

Signed-off-by: JiebingLi <jiebing.li@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/core/core.c            |   30 ++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci-intel-mid.c |   33 ++++++++++++++++++++-------------
 drivers/mmc/host/sdhci-pci.c       |    2 ++
 drivers/mmc/host/sdhci.c           |   18 ++++++++++++++++++
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/core.h           |    1 +
 include/linux/mmc/host.h           |    3 +++
 7 files changed, 71 insertions(+), 17 deletions(-)


diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5db49b1..b2abb68 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -202,11 +202,14 @@ static void mmc_wait_done(struct mmc_request *mrq)
  *	@host: MMC host to start command
  *	@mrq: MMC request to start
  *
- *	Start a new MMC custom command request for a host, and wait
- *	for the command to complete. Does not attempt to parse the
- *	response.
+ *	Implementation hander for starting a new MMC custom command request
+ *	for a host, and wait for the command to complete. Does not attempt to
+ *	parse the response.
+ *
+ *	We provide this separately and export it so that it can be wrapped
+ *	by callers who need serialization or have other issue constraints
  */
-void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
+void mmc_do_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	DECLARE_COMPLETION_ONSTACK(complete);
 
@@ -218,6 +221,25 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 	wait_for_completion(&complete);
 }
 
+EXPORT_SYMBOL(mmc_do_wait_for_req);
+
+/**
+ *	mmc_wait_for_req - start a request and wait for completion
+ *	@host: MMC host to start command
+ *	@mrq: MMC request to start
+ *
+ *	Start a new MMC custom command request for a host, and wait
+ *	for the command to complete. Does not attempt to parse the
+ *	response.
+ */
+void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	if (host->ops->wait_for_req)
+		host->ops->wait_for_req(host, mrq);
+	else
+		return mmc_do_wait_for_req(host, mrq);
+}
+
 EXPORT_SYMBOL(mmc_wait_for_req);
 
 /**
diff --git a/drivers/mmc/host/sdhci-intel-mid.c b/drivers/mmc/host/sdhci-intel-mid.c
index 2828831..436ee46 100644
--- a/drivers/mmc/host/sdhci-intel-mid.c
+++ b/drivers/mmc/host/sdhci-intel-mid.c
@@ -18,20 +18,27 @@
  *	that keeps them out of the main flow. We can't just make it a new
  *	driver as the shdci core code isn't really a library.
  */
- 
+
+/*
+ *	Support serialization
+ */
+
+static DEFINE_MUTEX(port_mutex);
+
+static void sdhci_intel_wait_req(struct sdhci_host *host,
+                                                struct mmc_request *mrq)
+{
+        mutex_lock(&port_mutex);
+        mmc_do_wait_for_req(host->mmc, mrq);
+        mutex_unlock(&port_mutex);
+}
+
+/*
+ *	Handle the Moorestown reset
+ */ 
 static void sdhci_broken_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
-	u32 uninitialized_var(ier);
-
-	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
-		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			SDHCI_CARD_PRESENT))
-			return;
-	}
-
-	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
-		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
 
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
@@ -46,12 +53,11 @@ static void sdhci_broken_reset(struct sdhci_host *host, u8 mask)
 		if (timeout == 0) {
 			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
+			return;
 		}
 		timeout--;
 		mdelay(1);
 	}
-	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
-		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
 
 static void sdhci_mid_broken_resetall(struct sdhci_host *host, int down)
@@ -156,6 +162,7 @@ struct sdhci_ops sdhci_intel_mrst_hc = {
 	.set_ios = sdhci_lnw_a3_set_ios,
 	.reset_all = sdhci_mid_broken_resetall,
 	.write_command = sdhci_clockreset_wcmd,
+	.wait_for_req = sdhci_intel_wait_req,
 	.unexpected_cmd_irq = sdhci_lnw_a3_unexpected_cmd,
 };
 EXPORT_SYMBOL_GPL(sdhci_intel_mrst_hc);
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 1324369..bb14047 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -55,6 +55,8 @@ struct sdhci_pci_fixes {
 					pm_message_t);
 	int			(*resume)(struct sdhci_pci_chip*);
 
+	/* Allow the driver to override some operations for particularly
+	   quirky chips */
 	struct sdhci_ops	*host_ops;
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d8091a..9d8047c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1268,6 +1268,12 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_wait_for_req(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	host->ops->wait_for_req(host, mrq);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -1275,6 +1281,16 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 };
 
+/* Operations struct we use if the controller has an sdhci level
+   ops->wait_for_req */
+static const struct mmc_host_ops sdhci_ops_wait = {
+	.request	= sdhci_request,
+	.set_ios	= sdhci_set_ios,
+	.get_ro		= sdhci_get_ro,
+	.enable_sdio_irq = sdhci_enable_sdio_irq,
+	.wait_for_req	= sdhci_wait_for_req,
+};
+
 /*****************************************************************************\
  *                                                                           *
  * Tasklets                                                                  *
@@ -1839,6 +1855,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
+	if (host->ops->wait_for_req)
+		mmc->ops = &sdhci_ops_wait;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 182fcc3..7c934bd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -334,6 +334,7 @@ struct sdhci_ops {
 				struct mmc_ios *ios, u8 ctrl);
 	void	(*set_caps)(struct sdhci_host *host);
 	void	(*unexpected_cmd_irq)(struct sdhci_host *host, u32 intmask);
+	void	(*wait_for_req)(struct sdhci_host *host, struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 7429033..6eaf5dd 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -132,6 +132,7 @@ struct mmc_host;
 struct mmc_card;
 
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
+extern void mmc_do_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ded4017..1b0e162 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -111,6 +111,9 @@ struct mmc_host_ops {
 
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
+	/* optional callback for serialization */
+	void	(*wait_for_req)(struct mmc_host *host,
+						struct mmc_request *mrq);
 };
 
 struct mmc_card;

