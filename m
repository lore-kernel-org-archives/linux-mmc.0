From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: core: Remove unused host cap MMC_CAP2_BROKEN_VOLTAGE
Date: Tue, 17 Dec 2013 15:04:17 +0100
Message-ID: <1387289058-19755-2-git-send-email-ulf.hansson@linaro.org>
References: <1387289058-19755-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:65283 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab3LQOEa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:04:30 -0500
Received: by mail-lb0-f176.google.com with SMTP id l4so1435079lbv.7
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 06:04:28 -0800 (PST)
In-Reply-To: <1387289058-19755-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/host.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 47fcc5d..a76993c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -272,7 +272,6 @@ struct mmc_host {
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
-#define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
-- 
1.7.9.5

