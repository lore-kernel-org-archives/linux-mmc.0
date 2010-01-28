From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] sdhci: add adma descriptor set call
Date: Thu, 28 Jan 2010 05:29:56 +0000
Message-ID: <1264656597-19965-2-git-send-email-ben-linux@fluff.org>
References: <1264656597-19965-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1264656597-19965-1-git-send-email-ben-linux@fluff.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, pierre@ossman.eu, linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

The code to write the ADMA descriptor into memory is repeated several
times throughout sdhci_adma_table_pre, and thus should be moved into a
common function. This will also be useful if the patch to make the write
more efficient is accepted.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/mmc/host/sdhci.c |   51 +++++++++++++++++++---------------------------
 1 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8be2613..391eb08 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -376,6 +376,20 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
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
@@ -443,19 +457,11 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
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
 
@@ -465,19 +471,10 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -499,15 +496,9 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		/*
 		* Add a terminating entry.
 		*/
-		desc[7] = 0;
-		desc[6] = 0;
-		desc[5] = 0;
-		desc[4] = 0;
-
-		desc[3] = 0;
-		desc[2] = 0;
-		desc[1] = 0x00;
-		desc[0] = 0x03; /* nop, end, valid */
+
+		/* nop, end, valid */
+		sdhci_set_adma_desc(desc, 0, 0, 0x3);
 	}
 
 	/*
-- 
1.6.0.4
