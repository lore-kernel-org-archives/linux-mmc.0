From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 5/5] mmc: sdhci: Add sdhci_read_caps()
Date: Tue, 28 Jun 2016 16:23:12 +0300
Message-ID: <1467120192-6479-6-git-send-email-adrian.hunter@intel.com>
References: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57962 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbcF1N22 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2016 09:28:28 -0400
In-Reply-To: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>

Add sdhci_read_caps() and __sdhci_read_caps() to make it easier for drivers
to fix the version and capabilities registers.

Pedantically, the SDHCI specification states that the capabilities
registers are valid when the host controller resets the Software Reset For
All bit. That requirement has always been satisfied by performing a reset
at the start of initialization, and consequently that is now part of the
new functions.

Although the SDHCI_QUIRK_MISSING_CAPS quirk has not yet been removed,
drivers that want to provide their own caps can now use these functions
instead of that quirk.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 48 +++++++++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |  8 ++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 185dbf27689e..44cdb6d035f2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2841,6 +2841,38 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	return ret;
 }
 
+void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
+{
+	u16 v;
+
+	if (host->read_caps)
+		return;
+
+	host->read_caps = true;
+
+	if (debug_quirks)
+		host->quirks = debug_quirks;
+
+	if (debug_quirks2)
+		host->quirks2 = debug_quirks2;
+
+	sdhci_do_reset(host, SDHCI_RESET_ALL);
+
+	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
+	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
+
+	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
+		return;
+
+	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
+
+	if (host->version < SDHCI_SPEC_300)
+		return;
+
+	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+}
+EXPORT_SYMBOL_GPL(__sdhci_read_caps);
+
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -2856,29 +2888,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	mmc = host->mmc;
 
-	if (debug_quirks)
-		host->quirks = debug_quirks;
-	if (debug_quirks2)
-		host->quirks2 = debug_quirks2;
+	sdhci_read_caps(host);
 
 	override_timeout_clk = host->timeout_clk;
 
-	sdhci_do_reset(host, SDHCI_RESET_ALL);
-
-	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
-	host->version = (host->version & SDHCI_SPEC_VER_MASK)
-				>> SDHCI_SPEC_VER_SHIFT;
 	if (host->version > SDHCI_SPEC_300) {
 		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
 		       mmc_hostname(mmc), host->version);
 	}
 
-	if (!(host->quirks & SDHCI_QUIRK_MISSING_CAPS)) {
-		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-		if (host->version >= SDHCI_SPEC_300)
-			host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
-	}
-
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8696c9365ef2..e332e4a40823 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -492,6 +492,7 @@ struct sdhci_host {
 
 	u32 caps;		/* CAPABILITY_0 */
 	u32 caps1;		/* CAPABILITY_1 */
+	bool read_caps;		/* Capability flags have been read */
 
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
@@ -648,6 +649,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 }
 
 extern void sdhci_card_detect(struct sdhci_host *host);
+extern void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
+			      u32 *caps1);
 extern int sdhci_setup_host(struct sdhci_host *host);
 extern int __sdhci_add_host(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
@@ -655,6 +658,11 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern void sdhci_send_command(struct sdhci_host *host,
 				struct mmc_command *cmd);
 
+static inline void sdhci_read_caps(struct sdhci_host *host)
+{
+	__sdhci_read_caps(host, NULL, NULL, NULL);
+}
+
 static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 {
 	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
-- 
1.9.1

