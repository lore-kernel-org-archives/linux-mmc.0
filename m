From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] mmc: dw_mmc: use __devinit_p macro for .remove()
Date: Wed,  3 Oct 2012 16:26:36 +0300
Message-ID: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42591 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107Ab2JCN0n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Oct 2012 09:26:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pci.c   |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index edb37e9..53a09cb 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -134,7 +134,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.name		= "dw_mmc_pci",
 	.id_table	= dw_mci_pci_id,
 	.probe		= dw_mci_pci_probe,
-	.remove		= dw_mci_pci_remove,
+	.remove		= __devexit_p(dw_mci_pci_remove),
 	.driver		=	{
 		.pm =   &dw_mci_pci_pmops
 	},
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index c960ca7..777c585 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -119,7 +119,7 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
 static struct platform_driver dw_mci_pltfm_driver = {
-	.remove		= __exit_p(dw_mci_pltfm_remove),
+	.remove		= __devexit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dw_mmc",
 		.of_match_table	= of_match_ptr(dw_mci_pltfm_match),
-- 
1.7.10.4

