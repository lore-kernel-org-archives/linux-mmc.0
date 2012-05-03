From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 19/29] mmc: add two capability flags for CD and WP signal polarity
Date: Thu,  3 May 2012 17:05:48 +0200
Message-ID: <1336057558-11031-20-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

To handle CD and WP SD/MMC slot pins we need generic flags to specify their
polarity.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/host.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b4d611..f1ca61b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -249,6 +249,8 @@ struct mmc_host {
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
+#define MMC_CAP2_INVERTED_CD	(1 << 10)	/* Card-detect signal active low */
+#define MMC_CAP2_INVERTED_RO	(1 << 11)	/* Write-protect signal active low */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.2.5

