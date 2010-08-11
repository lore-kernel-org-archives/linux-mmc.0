From: akpm@linux-foundation.org
Subject: [patch 037/177] sdhci: 8-bit data transfer width support
Date: Tue, 10 Aug 2010 18:01:43 -0700
Message-ID: <201008110101.o7B11i0s027055@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58822 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757687Ab0HKBTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:19:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kyungmin.park@samsung.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some host controllers such as s5pc110 support the WIDE8 feature.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |    5 +++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 6 insertions(+)

diff -puN drivers/mmc/host/sdhci.c~sdhci-8-bit-data-transfer-width-support drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-8-bit-data-transfer-width-support
+++ a/drivers/mmc/host/sdhci.c
@@ -1159,6 +1159,11 @@ static void sdhci_set_ios(struct mmc_hos
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
+		ctrl |= SDHCI_CTRL_8BITBUS;
+	else
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		ctrl |= SDHCI_CTRL_4BITBUS;
 	else
diff -puN drivers/mmc/host/sdhci.h~sdhci-8-bit-data-transfer-width-support drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-8-bit-data-transfer-width-support
+++ a/drivers/mmc/host/sdhci.h
@@ -72,6 +72,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define  SDHCI_CTRL_8BITBUS	0x20
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
_
