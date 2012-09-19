From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 6/6] mmc: sdhci: fix null return check of regulator_get
Date: Wed, 19 Sep 2012 10:12:42 +0800
Message-ID: <1348020762-12932-7-git-send-email-keyuan.liu@gmail.com>
References: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40568 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754410Ab2ISCSa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 22:18:30 -0400
In-Reply-To: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

regulator_get() returns NULL when CONFIG_REGULATOR not defined,
which should be checked.

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b5631e..914147d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2845,7 +2845,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
-	if (IS_ERR(host->vqmmc)) {
+	if (IS_ERR_OR_NULL(host->vqmmc)) {
 		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
 		host->vqmmc = NULL;
 	}
@@ -2912,7 +2912,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	ocr_avail = 0;
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
-	if (IS_ERR(host->vmmc)) {
+	if (IS_ERR_OR_NULL(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else
-- 
1.7.0.4

