From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: Allow deferred probe for sd card detect gpio
Date: Tue, 22 Nov 2016 11:03:38 +0200
Message-ID: <1479805418-19603-3-git-send-email-adrian.hunter@intel.com>
References: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932305AbcKVJJK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 04:09:10 -0500
In-Reply-To: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

With commit f35bbf61ab77 ("gpio / ACPI: Return -EPROBE_DEFER if the
gpiochip was not found"), a gpio descriptor request can now be deferred if
the providing gpio host controller driver hasn't been loaded yet. Allow use
in mmc slot probe in order to prevent card detect gpio setup from failing
in this case.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 501098e65b0e..2d20fb60ce83 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1760,11 +1760,16 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	host->mmc->slotno = slotno;
 	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
 
-	if (slot->cd_idx >= 0 &&
-	    mmc_gpiod_request_cd(host->mmc, slot->cd_con_id, slot->cd_idx,
-				 slot->cd_override_level, 0, NULL)) {
-		dev_warn(&pdev->dev, "failed to setup card detect gpio\n");
-		slot->cd_idx = -1;
+	if (slot->cd_idx >= 0) {
+		ret = mmc_gpiod_request_cd(host->mmc, slot->cd_con_id, slot->cd_idx,
+					   slot->cd_override_level, 0, NULL);
+		if (ret == -EPROBE_DEFER)
+			goto remove;
+
+		if (ret) {
+			dev_warn(&pdev->dev, "failed to setup card detect gpio\n");
+			slot->cd_idx = -1;
+		}
 	}
 
 	ret = sdhci_add_host(host);
-- 
1.9.1

