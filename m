From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Mon, 13 Sep 2010 18:39:41 +0100
Message-ID: <20100913173940.20345.66285.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61250 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSYN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:24:13 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Coding style fixes

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-intel-mid.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)


diff --git a/drivers/mmc/host/sdhci-intel-mid.c b/drivers/mmc/host/sdhci-intel-mid.c
index 436ee46..5057133 100644
--- a/drivers/mmc/host/sdhci-intel-mid.c
+++ b/drivers/mmc/host/sdhci-intel-mid.c
@@ -14,7 +14,7 @@
 
 /*
  *	Support code for SDHCI on Intel MID platforms. We have lots
- * 	of quirks specific to these platforms so wrap them up in one place
+ *	of quirks specific to these platforms so wrap them up in one place
  *	that keeps them out of the main flow. We can't just make it a new
  *	driver as the shdci core code isn't really a library.
  */
@@ -26,16 +26,16 @@
 static DEFINE_MUTEX(port_mutex);
 
 static void sdhci_intel_wait_req(struct sdhci_host *host,
-                                                struct mmc_request *mrq)
+						struct mmc_request *mrq)
 {
-        mutex_lock(&port_mutex);
-        mmc_do_wait_for_req(host->mmc, mrq);
-        mutex_unlock(&port_mutex);
+	mutex_lock(&port_mutex);
+	mmc_do_wait_for_req(host->mmc, mrq);
+	mutex_unlock(&port_mutex);
 }
 
 /*
  *	Handle the Moorestown reset
- */ 
+ */
 static void sdhci_broken_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
@@ -75,8 +75,8 @@ static void sdhci_mid_init_no_reset(struct sdhci_host *host, int soft)
 		intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE),
 		SDHCI_INT_STATUS);
 
-        /* Ensure any IRQ left over from pre boot time (eg from Kboot) does
-           not turn up and cause chaos */
+	/* Ensure any IRQ left over from pre boot time (eg from Kboot) does
+	   not turn up and cause chaos */
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 
@@ -130,7 +130,7 @@ static void sdhci_clockreset_wcmd(struct sdhci_host *host,
 				struct mmc_command *cmd, int flags)
 {
 	sdhci_clock_reset(host);
- 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 
 static void sdhci_lnw_a3_set_ios(struct sdhci_host *host,

