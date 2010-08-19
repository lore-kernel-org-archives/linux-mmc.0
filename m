From: akpm@linux-foundation.org
Subject: [patch 11/20] s5pc110: SDHCI-s3c support on s5pc110
Date: Thu, 19 Aug 2010 14:13:35 -0700
Message-ID: <201008192113.o7JLDZMO008695@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46954 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752331Ab0HSVNj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2010 17:13:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

s5pc110 (aka s5pv210) uses the same SDHCI IP.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/Kconfig~s5pc110-sdhci-s3c-support-on-s5pc110 drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~s5pc110-sdhci-s3c-support-on-s5pc110
+++ a/drivers/mmc/host/Kconfig
@@ -132,7 +132,7 @@ config MMC_SDHCI_CNS3XXX
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
+	depends on MMC_SDHCI && PLAT_SAMSUNG
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
_
