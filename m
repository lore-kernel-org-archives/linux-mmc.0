From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] sdhci-pci: CaFe has broken card detection
Date: Tue,  3 Jul 2012 23:13:39 +0100 (BST)
Message-ID: <20120703221340.221729D401E@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49344 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756313Ab2GCWNo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 18:13:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

At http://dev.laptop.org/ticket/11980 we have determined that the
Marvell CaFe SDHCI controller reports bad card presence during
resume. It reports that no card is present even when it is.

Around 400ms after resuming, a "card inserted" interrupt is generated,
at which point it starts reporting presence.

Work around this hardware oddity by setting the
SDHCI_QUIRK_BROKEN_CARD_DETECTION flag. Thanks to Chris Ball for helping
with diagnosis.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/host/sdhci-pci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 69ef0be..504da71 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -157,6 +157,7 @@ static const struct sdhci_pci_fixes sdhci_ene_714 = {
 static const struct sdhci_pci_fixes sdhci_cafe = {
 	.quirks		= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 			  SDHCI_QUIRK_NO_BUSY_IRQ |
+			  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
-- 
1.7.10.4

