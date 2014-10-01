From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 1/5] mmc: sdhci: Balance vmmc regulator_disable()
Date: Wed, 1 Oct 2014 07:14:07 -0500
Message-ID: <1412165651-2652-2-git-send-email-andrew_gabbasov@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62095 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMO7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:14:59 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIo7-0001fk-9d from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:14:59 -0700
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

As a follow-up of commit
"mmc: sdhci: Balance vmmc regulator_enable(), and always enable vqmmc"
vmmc regulator disable is also not needed in sdhci_remove_host.
The regulator is completely controlled by mmc_power_up and mmc_power_off
functions and is already disabled by the time of removing the host.
Extra regulator_disable call in sdhci_remove_host is unbalanced and
causes a warning reported by regulator core, so should be removed.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/host/sdhci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b2a9a..0272021 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3286,9 +3286,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vmmc))
-		regulator_disable(mmc->supply.vmmc);
-
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
 
-- 
2.1.0

