From: akpm@linux-foundation.org
Subject: [patch 051/177] sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk
Date: Tue, 10 Aug 2010 18:01:57 -0700
Message-ID: <201008110101.o7B11vR6027099@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55755 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757687Ab0HKBSR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:18:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch enables SDHCI_QUIRK_NO_HISPD_BIT on Samsung SDHCI driver.  This
solves detection problems with some external SD cards.  This change has
been tested on S5PC100 and S5PC110.  It has no inpact on driver speed.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-enable-sdhci_quirk_no_hispd_bit-quirk drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-enable-sdhci_quirk_no_hispd_bit-quirk
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -338,6 +338,7 @@ static int __devinit sdhci_s3c_probe(str
 
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
_
