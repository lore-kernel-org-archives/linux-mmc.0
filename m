From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: fix the error for a few argument
Date: Tue, 04 Dec 2012 13:12:11 +0900
Message-ID: <50BD781B.4050609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38604 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab2LDEMb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Dec 2012 23:12:31 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEH00M7CNO3WBQ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Dec 2012 13:12:27 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MEH00AP3NORVG50@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Dec 2012 13:12:27 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>

The argument of dw_mci_setup_bus is modified.
(Abhilash's patch: mmc: dw-mc: Add sdio power binding)
This patch used the dw_mci_setup_bus(slot, false) instead of
dw_mci_setup_bus(slot)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 069ca70..323c502 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -807,7 +807,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		drv_data->set_ios(slot->host, ios);
 
 	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot);
+	dw_mci_setup_bus(slot, false);
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-- 
1.7.5.4
