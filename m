From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 10/25] mmc: sdhci: clean up coding style in
 sdhci_adma_table_pre()
Date: Tue, 26 Jan 2016 13:40:00 +0000
Message-ID: <E1aO3qi-0005iU-Sk@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36858 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965288AbcAZNkN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:40:13 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f23fdb485393..d1f802507ab1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -465,16 +465,12 @@ static void sdhci_adma_mark_end(void *desc)
 static int sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data)
 {
-	void *desc;
-	void *align;
-	dma_addr_t addr;
-	dma_addr_t align_addr;
-	int len, offset;
-
 	struct scatterlist *sg;
-	int i;
-	char *buffer;
 	unsigned long flags;
+	dma_addr_t addr, align_addr;
+	void *desc, *align;
+	char *buffer;
+	int len, offset, i;
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -495,10 +491,9 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		len = sg_dma_len(sg);
 
 		/*
-		 * The SDHCI specification states that ADMA
-		 * addresses must be 32-bit aligned. If they
-		 * aren't, then we use a bounce buffer for
-		 * the (up to three) bytes that screw up the
+		 * The SDHCI specification states that ADMA addresses must
+		 * be 32-bit aligned. If they aren't, then we use a bounce
+		 * buffer for the (up to three) bytes that screw up the
 		 * alignment.
 		 */
 		offset = (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
@@ -542,19 +537,13 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
-		/*
-		* Mark the last descriptor as the terminating descriptor
-		*/
+		/* Mark the last descriptor as the terminating descriptor */
 		if (desc != host->adma_table) {
 			desc -= host->desc_sz;
 			sdhci_adma_mark_end(desc);
 		}
 	} else {
-		/*
-		* Add a terminating entry.
-		*/
-
-		/* nop, end, valid */
+		/* Add a terminating entry - nop, end, valid */
 		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 	return 0;
-- 
2.1.0

