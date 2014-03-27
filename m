From: ZhangZhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] workqueue: WQ_NON_REENTRANT is meaningless and going away
Date: Thu, 27 Mar 2014 09:41:47 +0800
Message-ID: <533381DB.2090900@huawei.com>
References: <532BF8BC.5060007@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:43270 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaC0BmM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Mar 2014 21:42:12 -0400
In-Reply-To: <532BF8BC.5060007@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jchapman@katalix.com, linux-mmc@vger.kernel.org, tgih.jun@samsung.com

Tejun Heo has  made WQ_NON_REENTRANT useless in the commit:dbf2576e37 ("workqueue: make all
workqueues non-reentrant"). So remove its usages.

This patch doesn't introduce any behavior changes.

Signed-off-by: zhangzhen <zhenzhang.zhang@huawei.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 include/linux/workqueue.h |    6 ------
 net/l2tp/l2tp_core.c      |    2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 55cd110..c204b7d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2607,7 +2607,7 @@ int dw_mci_probe(struct dw_mci *host)

 	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
 	host->card_workqueue = alloc_workqueue("dw-mci-card",
-			WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
+			WQ_MEM_RECLAIM, 1);
 	if (!host->card_workqueue) {
 		ret = -ENOMEM;
 		goto err_dmaunmap;
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 594521b..57b2687 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -295,12 +295,6 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * Documentation/workqueue.txt.
  */
 enum {
-	/*
-	 * All wqs are now non-reentrant making the following flag
-	 * meaningless.  Will be removed.
-	 */
-	WQ_NON_REENTRANT	= 1 << 0, /* DEPRECATED */
-
 	WQ_UNBOUND		= 1 << 1, /* not bound to any cpu */
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 735d0f6..fcbd63e 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -2016,7 +2016,7 @@ static int __init l2tp_init(void)
 	if (rc)
 		goto out;

-	l2tp_wq = alloc_workqueue("l2tp", WQ_NON_REENTRANT | WQ_UNBOUND, 0);
+	l2tp_wq = alloc_workqueue("l2tp", WQ_UNBOUND, 0);
 	if (!l2tp_wq) {
 		pr_err("alloc_workqueue failed\n");
 		rc = -ENOMEM;
-- 
1.6.0.2


.




_______________________________________________
kernel.openeuler mailing list
kernel.openeuler@huawei.com
http://rnd-openeuler.huawei.com/mailman/listinfo/kernel.openeuler

.




