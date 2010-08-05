From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Thu, 5 Aug 2010 14:08:31 +0800
Message-ID: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57317 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab0HEGIc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 02:08:32 -0400
Received: by gyg10 with SMTP id 10so2360832gyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 23:08:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

sdhci spec 3.0 has some difference, and here is patch to add support.

>From 25eeab5e3b58128600968e5600aeaf9390c067d8 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 05:47:59 +0800
Subject: [PATCH] sdhci: aligh with sdhc spec 3.00

	1. support 8 bit data transfer width
	2. support 10-bit Divided Clock Mode

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |   15 +++++++++++----
 drivers/mmc/host/sdhci.h |    5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..89b323e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1002,7 +1002,8 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	}
 	div >>= 1;

-	clk = div << SDHCI_DIVIDER_SHIFT;
+	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SHIFT) <<
SDHCI_DIVIDER_SHIFT_HI;
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

@@ -1159,10 +1160,16 @@ static void sdhci_set_ios(struct mmc_host
*mmc, struct mmc_ios *ios)

 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);

-	if (ios->bus_width == MMC_BUS_WIDTH_4)
+	if (ios->bus_width == MMC_BUS_WIDTH_8) {
+		ctrl |= SDHCI_CTRL_8BITBUS;
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+	} else if (ios->bus_width == MMC_BUS_WIDTH_4) {
 		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+	} else {
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}

 	if (ios->timing == MMC_TIMING_SD_HS)
 		ctrl |= SDHCI_CTRL_HISPD;
@@ -1681,7 +1688,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..2cb14eb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -72,6 +72,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define  SDHCI_CTRL_8BITBUS	0x20

 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
@@ -85,6 +86,9 @@

 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_SHIFT_HI	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -177,6 +181,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2

 struct sdhci_ops;

-- 
1.6.0.4
