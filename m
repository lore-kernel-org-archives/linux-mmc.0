From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH] mmc: core: Do not rescan non-removable devices
Date: Thu, 23 Aug 2012 13:40:55 +0200
Message-ID: <1345722055-12459-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:38899 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932641Ab2HWLmc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 07:42:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  |    5 +++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ac5246..2f4e273 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2052,6 +2052,11 @@ void mmc_rescan(struct work_struct *work)
 	if (host->rescan_disable)
 		return;
 
+	/* If there is a non-removable card registered, only scan once */
+	if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
+		return;
+	host->rescan_entered = 1;
+
 	mmc_bus_get(host);
 
 	/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f578a71..d5d9bd4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -300,6 +300,7 @@ struct mmc_host {
 #endif
 
 	int			rescan_disable;	/* disable card detection */
+	int			rescan_entered;	/* used with nonremovable devices */
 
 	struct mmc_card		*card;		/* device attached to this host */
 
-- 
1.7.10

