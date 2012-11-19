From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 362/493] mmc: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:11 -0500
Message-ID: <1353349642-3677-362-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:42026 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2KSSsA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 13:48:00 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chris Ball <cjb@laptop.org> 
Cc: linux-mmc@vger.kernel.org 
---
 drivers/mmc/host/sdhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index ff91651..3844771 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -653,7 +653,7 @@ static const struct sdhci_pci_fixes sdhci_via = {
 	.probe		= via_probe,
 };
 
-static const struct pci_device_id pci_ids[] __devinitconst = {
+static const struct pci_device_id pci_ids[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_RICOH,
 		.device		= PCI_DEVICE_ID_RICOH_R5C822,
-- 
1.8.0

