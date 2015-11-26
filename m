From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/7] mmc: sdhci-pci: Do not default to 33 Ohm driver strength for Intel SPT
Date: Thu, 26 Nov 2015 14:00:45 +0200
Message-ID: <1448539250-18769-3-git-send-email-adrian.hunter@intel.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbbKZMEF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:05 -0500
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

In some cases, the stronger 33 Ohm driver strength must not be used
so it is not a suitable default.  Change it to the standard default
50 Ohm value.

The patch applies to v4.2+ except the file name changed.  It is
drivers/mmc/host/sdhci-pci.c prior to v.4.4.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.2+
---
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index cf7ad458b4f4..08f4a9fe8550 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -277,7 +277,7 @@ static int spt_select_drive_strength(struct sdhci_host *host,
 	if (sdhci_pci_spt_drive_strength > 0)
 		drive_strength = sdhci_pci_spt_drive_strength & 0xf;
 	else
-		drive_strength = 1; /* 33-ohm */
+		drive_strength = 0; /* Default 50-ohm */
 
 	if ((mmc_driver_type_mask(drive_strength) & card_drv) == 0)
 		drive_strength = 0; /* Default 50-ohm */
-- 
1.9.1

