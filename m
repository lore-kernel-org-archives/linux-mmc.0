From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 7/7] mmc: sdhci: Fix sdhci_runtime_pm_bus_on/off()
Date: Thu, 26 Nov 2015 14:00:50 +0200
Message-ID: <1448539250-18769-8-git-send-email-adrian.hunter@intel.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbKZMES (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:18 -0500
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

sdhci has a legacy facility to prevent runtime suspend if the
bus power is on.  This is needed in cases where the power to
the card is dependent on the bus power.  It is controlled by
a pair of functions: sdhci_runtime_pm_bus_on() and
sdhci_runtime_pm_bus_off().  These functions use a boolean
variable 'bus_on' to ensure changes are always paired.
There is an additional check for 'runtime_suspended' which is
the problem.  In fact, its use is ill-conceived as the only
requirement for the logic is that 'on' and 'off' are paired,
which is actually broken by the check, for example if the bus
power is turned on during runtime resume.  So remove  the check.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v3.11+
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7fe326f76fb7..d82b90928585 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2756,7 +2756,7 @@ static int sdhci_runtime_pm_put(struct sdhci_host *host)
 
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
-	if (host->runtime_suspended || host->bus_on)
+	if (host->bus_on)
 		return;
 	host->bus_on = true;
 	pm_runtime_get_noresume(host->mmc->parent);
@@ -2764,7 +2764,7 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 
 static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
-	if (host->runtime_suspended || !host->bus_on)
+	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(host->mmc->parent);
-- 
1.9.1

