From: philipspatches@gmail.com
Subject: [PATCH 1/3] mmc: sdhci - if MAX_CURRENT returns 0 try to use regulator to get current
Date: Sun, 27 May 2012 18:36:44 -0700
Message-ID: <1338169004-2122-1-git-send-email-prakity@marvell.com>
References: <prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52507 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab2E1Bgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 May 2012 21:36:50 -0400
Received: by dady13 with SMTP id y13so3495118dad.19
        for <linux-mmc@vger.kernel.org>; Sun, 27 May 2012 18:36:49 -0700 (PDT)
In-Reply-To: <prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>

From: Philip Rakity <prakity@marvell.com>

The sd host controller spec indicates the the MAX_CURRENT value may be
returned as 0.  In this case other methods need to be used to return
the current.  If 0 is returned and there is a regulator, ask the regulator
for how much current is available.

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c |   28 ++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e626732..22347d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2837,6 +2837,13 @@ int sdhci_add_host(struct sdhci_host *host)
 			     SDHCI_RETUNING_MODE_SHIFT;
 
 	ocr_avail = 0;
+
+	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	if (IS_ERR(host->vmmc)) {
+		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
+		host->vmmc = NULL;
+	}
+
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
 	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
@@ -2845,6 +2852,21 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * value.
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
+	if (!max_current_caps && host->vmmc) {
+		u32 curr = regulator_get_current_limit(host->vmmc);
+		if (curr > 0) {
+
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr/1000;  /* convert to mA */
+			curr = curr/SDHCI_MAX_CURRENT_MULTIPLIER;
+
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps =
+				(curr << SDHCI_MAX_CURRENT_330_SHIFT) |
+				(curr << SDHCI_MAX_CURRENT_300_SHIFT) |
+				(curr << SDHCI_MAX_CURRENT_180_SHIFT);
+		}
+	}
 
 	if (caps[0] & SDHCI_CAN_VDD_330) {
 		int max_current_330;
@@ -2995,12 +3017,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (ret)
 		goto untasklet;
 
-	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
-	if (IS_ERR(host->vmmc)) {
-		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
-		host->vmmc = NULL;
-	}
-
 	sdhci_init(host, 0);
 
 #ifdef CONFIG_MMC_DEBUG
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f761f23..97653ea 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -205,6 +205,7 @@
 #define SDHCI_CAPABILITIES_1	0x44
 
 #define SDHCI_MAX_CURRENT		0x48
+#define  SDHCI_MAX_CURRENT_LIMIT	0xFF
 #define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
 #define  SDHCI_MAX_CURRENT_330_SHIFT	0
 #define  SDHCI_MAX_CURRENT_300_MASK	0x00FF00
-- 
1.7.0.4

