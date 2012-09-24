From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v2 5/8] mmc: sdhci: fix null return check of regulator_get
Date: Mon, 24 Sep 2012 16:15:55 +0800
Message-ID: <1348474558-23088-6-git-send-email-keyuan.liu@gmail.com>
References: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:36951 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402Ab2IXIZB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 04:25:01 -0400
In-Reply-To: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

regulator_get() returns NULL when CONFIG_REGULATOR not defined,
which should not print out the warning.

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b5631e..7c85e49 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2845,9 +2845,12 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
-	if (IS_ERR(host->vqmmc)) {
-		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
-		host->vqmmc = NULL;
+	if (IS_ERR_OR_NULL(host->vqmmc)) {
+		if (PTR_ERR(host->vqmmc) < 0) {
+			pr_info("%s: no vqmmc regulator found\n",
+				mmc_hostname(mmc));
+			host->vqmmc = NULL;
+		}
 	}
 	else if (regulator_is_supported_voltage(host->vqmmc, 1650000, 1950000))
 		regulator_enable(host->vqmmc);
@@ -2912,9 +2915,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	ocr_avail = 0;
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
-	if (IS_ERR(host->vmmc)) {
-		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
-		host->vmmc = NULL;
+	if (IS_ERR_OR_NULL(host->vmmc)) {
+		if (PTR_ERR(host->vmmc) < 0) {
+			pr_info("%s: no vmmc regulator found\n",
+				mmc_hostname(mmc));
+			host->vmmc = NULL;
+		}
 	} else
 		regulator_enable(host->vmmc);
 
-- 
1.7.0.4

