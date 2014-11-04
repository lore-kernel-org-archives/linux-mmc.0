From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 04/15] mmc: sdhci: Rename two ADMA-related functions for consistency
Date: Tue,  4 Nov 2014 12:42:38 +0200
Message-ID: <1415097769-19032-5-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbaKDKo1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:27 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Rename sdhci_set_adma_desc to sdhci_adma_write_desc and
sdhci_show_adma_error to sdhci_adma_show_error so that
all ADMA functions start with sdhci_adma_.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4436f77..e40414a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -454,7 +454,7 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_set_adma_desc(u8 *desc, u32 addr, int len, unsigned cmd)
+static void sdhci_adma_write_desc(u8 *desc, u32 addr, int len, unsigned cmd)
 {
 	__le32 *dataddr = (__le32 __force *)(desc + 4);
 	__le16 *cmdlen = (__le16 __force *)desc;
@@ -532,7 +532,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_set_adma_desc(desc, align_addr, offset, 0x21);
+			sdhci_adma_write_desc(desc, align_addr, offset, 0x21);
 
 			BUG_ON(offset > 65536);
 
@@ -548,7 +548,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		BUG_ON(len > 65536);
 
 		/* tran, valid */
-		sdhci_set_adma_desc(desc, addr, len, 0x21);
+		sdhci_adma_write_desc(desc, addr, len, 0x21);
 		desc += 8;
 
 		/*
@@ -572,7 +572,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		*/
 
 		/* nop, end, valid */
-		sdhci_set_adma_desc(desc, 0, 0, 0x3);
+		sdhci_adma_write_desc(desc, 0, 0, 0x3);
 	}
 
 	/*
@@ -2291,7 +2291,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 }
 
 #ifdef CONFIG_MMC_DEBUG
-static void sdhci_show_adma_error(struct sdhci_host *host)
+static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
 	u8 *desc = host->adma_desc;
@@ -2316,7 +2316,7 @@ static void sdhci_show_adma_error(struct sdhci_host *host)
 	}
 }
 #else
-static void sdhci_show_adma_error(struct sdhci_host *host) { }
+static void sdhci_adma_show_error(struct sdhci_host *host) { }
 #endif
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
@@ -2379,7 +2379,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		host->data->error = -EILSEQ;
 	else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
-		sdhci_show_adma_error(host);
+		sdhci_adma_show_error(host);
 		host->data->error = -EIO;
 		if (host->ops->adma_workaround)
 			host->ops->adma_workaround(host, intmask);
-- 
1.9.1

