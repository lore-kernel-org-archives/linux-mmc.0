From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 4/4] mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL
Date: Tue,  9 Feb 2016 16:12:38 +0200
Message-ID: <1455027158-21564-5-git-send-email-adrian.hunter@intel.com>
References: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327AbcBIOQc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Feb 2016 09:16:32 -0500
In-Reply-To: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Intel BXT/APL use a card detect GPIO however the host controller
will not enable bus power unless it's card detect also reflects
the presence of a card.  Unfortunately those 2 things race which
can result in commands not starting, after which the controller
does nothing and there is a 10 second wait for the driver's
10-second timer to timeout.

That is fixed by having the driver look also at the present state
register to determine if the card is present.  Consequently, provide
a 'get_cd' mmc host operation for BXT/APL that does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci-acpi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 3d27f2de0054..195ff0853dc8 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -146,6 +146,33 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static int bxt_get_cd(struct mmc_host *mmc)
+{
+	int gpio_cd = mmc_gpio_get_cd(mmc);
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int ret = 0;
+
+	if (!gpio_cd)
+		return 0;
+
+	pm_runtime_get_sync(mmc->parent);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		goto out;
+
+	ret = !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	pm_runtime_mark_last_busy(mmc->parent);
+	pm_runtime_put_autosuspend(mmc->parent);
+
+	return ret;
+}
+
 static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
@@ -196,6 +223,9 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	/* Platform specific code during sd probe slot goes here */
 
+	if (hid && !strcmp(hid, "80865ACA"))
+		host->mmc_host_ops.get_cd = bxt_get_cd;
+
 	return 0;
 }
 
-- 
1.9.1

