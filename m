From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/15] mmc: sdhci: Add sdhci_adma_mark_end()
Date: Tue, 21 Oct 2014 12:26:16 +0300
Message-ID: <1413883585-16299-7-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316AbaJUJ2D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:03 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

In preparation for 64-bit ADMA, separate out code
that touches the ADMA descriptor by adding
sdhci_adma_mark_end().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b45814e..833e792 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -468,6 +468,13 @@ static void sdhci_adma_write_desc(u8 *desc, u32 addr, int len, unsigned cmd)
 	dataddr[0] = cpu_to_le32(addr);
 }
 
+static void sdhci_adma_mark_end(void *desc)
+{
+	u8 *dma_desc = desc;
+
+	dma_desc[0] |= 0x2; /* end */
+}
+
 static int sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data)
 {
@@ -564,7 +571,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		*/
 		if (desc != host->adma_table) {
 			desc -= 8;
-			desc[0] |= 0x2; /* end */
+			sdhci_adma_mark_end(desc);
 		}
 	} else {
 		/*
-- 
1.9.1

