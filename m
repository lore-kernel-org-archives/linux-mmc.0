Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C0C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 22:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A0564F92
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 22:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBEWJE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhBEOqq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2021 09:46:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5EBC061756
        for <linux-mmc@vger.kernel.org>; Fri,  5 Feb 2021 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JbZFHFZO7UA/d+963uxGY/sF8tjQWO956hD6Tz0yCps=; b=l9MfTxm21c0GdyXMABZlnXvxLu
        t0IOQA8a0Wm+OsTOyK6P2gKahdZgYXoP/axdC6TgaRNKtTyU6ovjqR2Q5X6iqkdpmRIjXlaodotig
        tW28TMD+eVs4IphDuQ9ys5vtsHw4bBnz3IjSip0mkEiHPebrbFOdk+VTHWHLb1EZ4cA2PfLsRgk1e
        u2RxYWuQwq18fHcnOLxHiQrIkpjAITY3c75ulLv+QZPY7jouh5yaeRPPG1U5HDgqz0jeeU66jJVal
        JbHZ7CHZmouabyMqMGBeHKwItP+SiRtnA3iIK9lLZGXqROVmoeehiMflhChBeUMw9ZfzfQSjU1Kh2
        eAzZqjMA==;
Received: from [2001:4bb8:184:7d04:5d90:2a72:fb46:8f15] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l83tc-002V8j-U8; Fri, 05 Feb 2021 16:23:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
Subject: [PATCH] sdhci: stop poking into swiotlb internals
Date:   Fri,  5 Feb 2021 17:23:46 +0100
Message-Id: <20210205162346.2847165-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the proper API to query the max mapping size instead of guessing
it based on swiotlb internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/sdhci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 646823ddd31715..2d73407ee52ec7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
-#include <linux/swiotlb.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -4582,12 +4581,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->max_segs = SDHCI_MAX_SEGS;
 	} else if (host->flags & SDHCI_USE_SDMA) {
 		mmc->max_segs = 1;
-		if (swiotlb_max_segment()) {
-			unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
-						IO_TLB_SEGSIZE;
-			mmc->max_req_size = min(mmc->max_req_size,
-						max_req_size);
-		}
+		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
+					  dma_max_mapping_size(mmc_dev(mmc)));
 	} else { /* PIO */
 		mmc->max_segs = SDHCI_MAX_SEGS;
 	}
-- 
2.29.2

