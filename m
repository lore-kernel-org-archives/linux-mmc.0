From: Aaron Lu <Aaron.Lu@amd.com>
Subject: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in sdhci_tasklet_finish
Date: Mon, 11 Jul 2011 13:27:11 +0800
Message-ID: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:55996
	"EHLO VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756510Ab1GKFnF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 01:43:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arindam Nath <arindam.nath@amd.com>, linux-mmc@vger.kernel.org, Aaron Lu <Aaron.Lu@amd.com>

Currently, the retuning timer for retuning mode 1 will be deleted in
function sdhci_tasklet_finish after a mmc request done, which will make
retuning timing never trigger again. This patch fixed this problem.

Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
---
 drivers/mmc/host/sdhci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..6250bac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 	del_timer(&host->timer);
 
-	if (host->version >= SDHCI_SPEC_300)
-		del_timer(&host->tuning_timer);
-
 	mrq = host->mrq;
 
 	/*
-- 
1.7.1


