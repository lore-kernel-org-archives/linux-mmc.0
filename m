From: akpm@linux-foundation.org
Subject: [patch 099/160] sdhci: add adma descriptor set call
Date: Fri, 05 Mar 2010 13:43:26 -0800
Message-ID: <201003052143.o25LhR34029763@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35059 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755337Ab0CEVnv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben-linux@fluff.org, linux-mmc@vger.kernel.org, pierre@ossman.eu

From: Ben Dooks <ben-linux@fluff.org>

The code to write the ADMA descriptor into memory is repeated several
times throughout sdhci_adma_table_pre, and thus should be moved into a
common function.  This will also be useful if the patch to make the write
more efficient is accepted.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |   50 ++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-add-adma-descriptor-set-call drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-add-adma-descriptor-set-call
+++ a/drivers/mmc/host/sdhci.c
@@ -376,6 +376,20 @@ static void sdhci_kunmap_atomic(void *bu
 	local_irq_restore(*flags);
 }
 
+static void sdhci_set_adma_desc(u8 *desc, u32 addr, int len, unsigned cmd)
+{
+	desc[7] = (addr >> 24) & 0xff;
+	desc[6] = (addr >> 16) & 0xff;
+	desc[5] = (addr >> 8) & 0xff;
+	desc[4] = (addr >> 0) & 0xff;
+
+	desc[3] = (len >> 8) & 0xff;
+	desc[2] = (len >> 0) & 0xff;
+
+	desc[0] = cmd & 0xff;
+	desc[1] = cmd >> 8;
+}
+
 static int sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data)
 {
@@ -443,19 +457,11 @@ static int sdhci_adma_table_pre(struct s
 				sdhci_kunmap_atomic(buffer, &flags);
 			}
 
-			desc[7] = (align_addr >> 24) & 0xff;
-			desc[6] = (align_addr >> 16) & 0xff;
-			desc[5] = (align_addr >> 8) & 0xff;
-			desc[4] = (align_addr >> 0) & 0xff;
+			/* tran, valid */
+			sdhci_set_adma_desc(desc, align_addr, offset, 0x21);
 
 			BUG_ON(offset > 65536);
 
-			desc[3] = (offset >> 8) & 0xff;
-			desc[2] = (offset >> 0) & 0xff;
-
-			desc[1] = 0x00;
-			desc[0] = 0x21; /* tran, valid */
-
 			align += 4;
 			align_addr += 4;
 
@@ -465,19 +471,10 @@ static int sdhci_adma_table_pre(struct s
 			len -= offset;
 		}
 
-		desc[7] = (addr >> 24) & 0xff;
-		desc[6] = (addr >> 16) & 0xff;
-		desc[5] = (addr >> 8) & 0xff;
-		desc[4] = (addr >> 0) & 0xff;
-
 		BUG_ON(len > 65536);
 
-		desc[3] = (len >> 8) & 0xff;
-		desc[2] = (len >> 0) & 0xff;
-
-		desc[1] = 0x00;
-		desc[0] = 0x21; /* tran, valid */
-
+		/* tran, valid */
+		sdhci_set_adma_desc(desc, addr, len, 0x21);
 		desc += 8;
 
 		/*
@@ -490,16 +487,9 @@ static int sdhci_adma_table_pre(struct s
 	/*
 	 * Add a terminating entry.
 	 */
-	desc[7] = 0;
-	desc[6] = 0;
-	desc[5] = 0;
-	desc[4] = 0;
-
-	desc[3] = 0;
-	desc[2] = 0;
 
-	desc[1] = 0x00;
-	desc[0] = 0x03; /* nop, end, valid */
+	/* nop, end, valid */
+	sdhci_set_adma_desc(desc, 0, 0, 0x3);
 
 	/*
 	 * Resync align buffer as we might have changed it.
_
