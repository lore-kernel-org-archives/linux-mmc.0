From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: core: Invoke ->card_event() callback only when needed
Date: Thu,  5 Nov 2015 16:08:07 +0100
Message-ID: <1446736088-11715-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36338 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161578AbbKEPIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 10:08:13 -0500
Received: by lfs39 with SMTP id 39so28967795lfs.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2015 07:08:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The ->card_event() callback may be called when re-scan is disabled and for
non-removable cards, which both cases are unnecessary.

Instead let's move the call later in mmc_rescan() where these constraints
have been validated.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..c1027a4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2567,11 +2567,6 @@ void mmc_rescan(struct work_struct *work)
 		container_of(work, struct mmc_host, detect.work);
 	int i;
 
-	if (host->trigger_card_event && host->ops->card_event) {
-		host->ops->card_event(host);
-		host->trigger_card_event = false;
-	}
-
 	if (host->rescan_disable)
 		return;
 
@@ -2580,6 +2575,11 @@ void mmc_rescan(struct work_struct *work)
 		return;
 	host->rescan_entered = 1;
 
+	if (host->trigger_card_event && host->ops->card_event) {
+		host->ops->card_event(host);
+		host->trigger_card_event = false;
+	}
+
 	mmc_bus_get(host);
 
 	/*
-- 
1.9.1

