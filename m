From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/5] mmc: dw-mmc: fixed the section mismatch in reference
Date: Thu, 23 Aug 2012 20:31:48 +0900
Message-ID: <503614A4.2070801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22746 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2HWLcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 07:32:07 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9700L0VHD7CG20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:04 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9700JGGHDFWSB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Fixed the below message.

WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch in reference from the function dw_mci_probe() to the function .init.text:dw_mci_init_slot()
The function dw_mci_probe() references
the function __init dw_mci_init_slot().
This is often because dw_mci_probe lacks a __init
annotation or the annotation of dw_mci_init_slot is wrong

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    4 ++--
 drivers/mmc/host/dw_mmc.c       |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 92ec3eb..a54d3a3 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -21,7 +21,7 @@
 #include <linux/mmc/dw_mmc.h>
 #include "dw_mmc.h"
 
-static int dw_mci_pltfm_probe(struct platform_device *pdev)
+static int __devinit dw_mci_pltfm_probe(struct platform_device *pdev)
 {
 	struct dw_mci *host;
 	struct resource	*regs;
@@ -62,7 +62,7 @@ err_free:
 	return ret;
 }
 
-static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
+static int __devexit dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index af40d22..36f98c0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1767,7 +1767,7 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 	}
 }
 
-static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
+static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-- 
1.7.4.1
