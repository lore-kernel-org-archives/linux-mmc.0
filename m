From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 04/11] mmc: (cosmetic) remove "extern" from function declarations
Date: Wed, 16 Jan 2013 17:54:39 +0100
Message-ID: <1358355286-26029-5-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61096 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870Ab3APQyt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 11:54:49 -0500
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

The "extern" keyword isn't required in function declarations, remove it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/host.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 13c0c8d..356ae0a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -341,10 +341,10 @@ struct mmc_host {
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
-extern int mmc_add_host(struct mmc_host *);
-extern void mmc_remove_host(struct mmc_host *);
-extern void mmc_free_host(struct mmc_host *);
+struct mmc_host *mmc_alloc_host(int extra, struct device *);
+int mmc_add_host(struct mmc_host *);
+void mmc_remove_host(struct mmc_host *);
+void mmc_free_host(struct mmc_host *);
 void mmc_of_parse(struct mmc_host *host);
 
 static inline void *mmc_priv(struct mmc_host *host)
@@ -358,16 +358,16 @@ static inline void *mmc_priv(struct mmc_host *host)
 #define mmc_classdev(x)	(&(x)->class_dev)
 #define mmc_hostname(x)	(dev_name(&(x)->class_dev))
 
-extern int mmc_suspend_host(struct mmc_host *);
-extern int mmc_resume_host(struct mmc_host *);
+int mmc_suspend_host(struct mmc_host *);
+int mmc_resume_host(struct mmc_host *);
 
-extern int mmc_power_save_host(struct mmc_host *host);
-extern int mmc_power_restore_host(struct mmc_host *host);
+int mmc_power_save_host(struct mmc_host *host);
+int mmc_power_restore_host(struct mmc_host *host);
 
-extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
-extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
+void mmc_detect_change(struct mmc_host *, unsigned long delay);
+void mmc_request_done(struct mmc_host *, struct mmc_request *);
 
-extern int mmc_cache_ctrl(struct mmc_host *, u8);
+int mmc_cache_ctrl(struct mmc_host *, u8);
 
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
-- 
1.7.2.5

