From: philipspatches@gmail.com
Subject: [PATCH] sdhci: vmmc regulator should be explicitly enabled/disabled
Date: Mon, 23 Jul 2012 17:25:18 -0700
Message-ID: <1343089518-9219-1-git-send-email-prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35873 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab2GXAZZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 20:25:25 -0400
Received: by qcro28 with SMTP id o28so3558325qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jul 2012 17:25:24 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

The vmmc regulator should not rely on it being enabled in
the platform code.  Expliciitly enable and disable the
regulator.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac50d35..8c58865 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2908,7 +2908,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (IS_ERR(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
-	}
+	} else
+		regulator_enable(host->vmmc);
 
 #ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
@@ -3165,8 +3166,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
-	if (host->vmmc)
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
 		regulator_put(host->vmmc);
+	}
 
 	if (host->vqmmc) {
 		regulator_disable(host->vqmmc);
-- 
1.7.0.4

