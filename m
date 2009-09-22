From: akpm@linux-foundation.org
Subject: [patch 079/232] sdhci-of: avoid writing reserved bits into host control register
Date: Tue, 22 Sep 2009 16:45:11 -0700
Message-ID: <200909222345.n8MNjCgT013847@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53642 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320AbZIWAQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:16:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Anton Vorontsov <avorontsov@ru.mvista.com>

SDHCI core tries to write HISPD bit into the host control register, but
the eSDHC controllers don't have that bit, and that causes all sorts of
misbehaviour when using 4-bit mode capable SD cards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Ben Dooks <ben@fluff.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-of.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN drivers/mmc/host/sdhci-of.c~sdhci-of-avoid-writing-reserved-bits-into-host-control-register drivers/mmc/host/sdhci-of.c
--- a/drivers/mmc/host/sdhci-of.c~sdhci-of-avoid-writing-reserved-bits-into-host-control-register
+++ a/drivers/mmc/host/sdhci-of.c
@@ -48,6 +48,8 @@ struct sdhci_of_host {
 #define ESDHC_CLOCK_HCKEN	0x00000002
 #define ESDHC_CLOCK_IPGEN	0x00000001
 
+#define ESDHC_HOST_CONTROL_RES	0x05
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	return in_be32(host->ioaddr + reg);
@@ -109,6 +111,10 @@ static void esdhc_writeb(struct sdhci_ho
 	int base = reg & ~0x3;
 	int shift = (reg & 0x3) * 8;
 
+	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
+	if (reg == SDHCI_HOST_CONTROL)
+		val &= ~ESDHC_HOST_CONTROL_RES;
+
 	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
 }
 
_
