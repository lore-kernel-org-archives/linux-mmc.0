From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci-pci: support runtime PM for BYT SD cards
Date: Mon,  6 May 2013 12:17:34 +0300
Message-ID: <1367831854-31952-4-git-send-email-adrian.hunter@intel.com>
References: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37200 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3EFJMl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 May 2013 05:12:41 -0400
In-Reply-To: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add support for runtime PM for BYT SD cards.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 701d06d..611331a 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -332,6 +332,8 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
+	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
+	.allow_runtime_pm = true,
 };
 
 /* O2Micro extra registers */
-- 
1.7.11.7

