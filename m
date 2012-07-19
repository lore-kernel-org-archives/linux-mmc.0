From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: fixed secstion mismatch in reference
Date: Fri, 20 Jul 2012 00:19:05 +0900
Message-ID: <50082569.8030002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55946 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab2GSPTK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 11:19:10 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7E001MPYJLRYH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jul 2012 00:19:09 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7E00NHOYJW0530@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jul 2012 00:19:09 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Fixed the below message.

WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch in reference from the function dw_mci_probe() to the function .init.text:dw_mci_init_slot()
The function dw_mci_probe() references
the function __init dw_mci_init_slot().
This is often because dw_mci_probe lacks a __init
annotation or the annotation of dw_mci_init_slot is wrong

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 72dc3cd..7955eba 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1760,7 +1760,7 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 	}
 }
 
-static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
+static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-- 
1.7.4.1
