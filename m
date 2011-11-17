From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] mmc: core: Fix typo at mmc_card_sleep
Date: Thu, 17 Nov 2011 13:34:33 +0900
Message-ID: <20111117043433.GA32665@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52880 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab1KQEeh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 23:34:37 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LUS00KE8FDJFVK0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2011 13:34:36 +0900 (KST)
Received: from july ([165.213.219.175])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LUS00D09FDKZU00@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Thu, 17 Nov 2011 13:34:33 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

Fix wrong bus_ops->sleep check.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..193e449 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2196,7 +2196,7 @@ int mmc_card_sleep(struct mmc_host *host)
 
 	mmc_bus_get(host);
 
-	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
+	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
 		err = host->bus_ops->sleep(host);
 
 	mmc_bus_put(host);
