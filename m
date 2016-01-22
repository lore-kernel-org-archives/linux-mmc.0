From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL
Date: Fri, 22 Jan 2016 11:45:02 +0200
Message-ID: <1453455902-3987-4-git-send-email-adrian.hunter@intel.com>
References: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13835 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804AbcAVJsw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jan 2016 04:48:52 -0500
In-Reply-To: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Russell King <linux@arm.linux.org.uk>

Intel BXT/APL use a card detect GPIO however the host controller
will not enable bus power unless it's card detect also reflects
the presence of a card.  Unfortunately those 2 things race which
can result in commands not starting, after which the controller
does nothing and there is a 10 second wait for the driver's
10-second timer to timeout.

That is fixed by having the driver look also at the present state
register to determine if the card is present.  Consequently, provide
a 'get_cd' sdhci host operation for BXT/APL that does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci-acpi.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f6047fc94062..d330e99bdd87 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -146,6 +146,29 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static int bxt_get_cd(struct sdhci_host *host)
+{
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+
+	if (!gpio_cd)
+		return 0;
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static const struct sdhci_ops sdhci_acpi_ops_bxt = {
+	.set_clock = sdhci_set_clock,
+	.enable_dma = sdhci_acpi_enable_dma,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.get_cd = bxt_get_cd,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_bxt = {
+	.ops = &sdhci_acpi_ops_bxt,
+};
+
 static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
@@ -234,6 +257,16 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_bxt_sd = {
+	.chip    = &sdhci_acpi_chip_bxt,
+	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
+		   SDHCI_ACPI_RUNTIME_PM,
+	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
+		   SDHCI_QUIRK2_STOP_WITH_TC,
+	.caps    = MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -241,7 +274,7 @@ struct sdhci_acpi_uid_slot {
 };
 
 static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
-	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
+	{ "80865ACA", NULL, &sdhci_acpi_slot_bxt_sd },
 	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
 	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
-- 
1.9.1

