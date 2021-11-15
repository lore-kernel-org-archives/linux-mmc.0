Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A474AC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816EC61B29
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhKOI04 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:26:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:31159 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhKOI0t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Nov 2021 03:26:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="232122220"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="232122220"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 00:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="585158276"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2021 00:23:46 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
Date:   Mon, 15 Nov 2021 10:23:45 +0200
Message-Id: <20211115082345.802238-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The block layer forces a minimum segment size of PAGE_SIZE, so a segment
can be too big for the ADMA table, if PAGE_SIZE >= 64KiB. Fix by writing
multiple descriptors, noting that the ADMA table is sized for 4KiB chunks
anyway, so it will be big enough.

Reported-and-tested-by: Bough Chen <haibo.chen@nxp.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 21 ++++++++++++++++++---
 drivers/mmc/host/sdhci.h |  4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 269c86569402..07c6da1f2f0f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -771,7 +771,19 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			len -= offset;
 		}
 
-		BUG_ON(len > 65536);
+		/*
+		 * The block layer forces a minimum segment size of PAGE_SIZE,
+		 * so 'len' can be too big here if PAGE_SIZE >= 64KiB. Write
+		 * multiple descriptors, noting that the ADMA table is sized
+		 * for 4KiB chunks anyway, so it will be big enough.
+		 */
+		while (len > host->max_adma) {
+			int n = 32 * 1024; /* 32KiB*/
+
+			__sdhci_adma_write_desc(host, &desc, addr, n, ADMA2_TRAN_VALID);
+			addr += n;
+			len -= n;
+		}
 
 		/* tran, valid */
 		if (len)
@@ -3968,6 +3980,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	 * descriptor for each segment, plus 1 for a nop end descriptor.
 	 */
 	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
+	host->max_adma = 65536;
 
 	host->max_timeout_count = 0xE;
 
@@ -4633,10 +4646,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * be larger than 64 KiB though.
 	 */
 	if (host->flags & SDHCI_USE_ADMA) {
-		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
+		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
+			host->max_adma = 65532; /* 32-bit alignment */
 			mmc->max_seg_size = 65535;
-		else
+		} else {
 			mmc->max_seg_size = 65536;
+		}
 	} else {
 		mmc->max_seg_size = mmc->max_req_size;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bb883553d3b4..d7929d725730 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -340,7 +340,8 @@ struct sdhci_adma2_64_desc {
 
 /*
  * Maximum segments assuming a 512KiB maximum requisition size and a minimum
- * 4KiB page size.
+ * 4KiB page size. Note this also allows enough for multiple descriptors in
+ * case of PAGE_SIZE >= 64KiB.
  */
 #define SDHCI_MAX_SEGS		128
 
@@ -543,6 +544,7 @@ struct sdhci_host {
 	unsigned int blocks;	/* remaining PIO blocks */
 
 	int sg_count;		/* Mapped sg entries */
+	int max_adma;		/* Max. length in ADMA descriptor */
 
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
-- 
2.25.1

