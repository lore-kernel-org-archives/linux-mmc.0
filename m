From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/17] mmc: sdhci: clean up coding style in
 sdhci_adma_table_pre()
Date: Sat, 19 Dec 2015 20:30:44 +0000
Message-ID: <E1aAO9M-0007yI-Hk@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36148 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbbLSUbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:31:00 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8a4eb1c41f3e..a1853671a591 100644
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
 		offset = (host->align_sz - (addr & host->align_mask)) &
@@ -539,19 +534,13 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
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

