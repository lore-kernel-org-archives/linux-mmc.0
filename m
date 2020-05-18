Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB86C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C460207D8
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERMJZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 08:09:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:61648 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgERMJY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 May 2020 08:09:24 -0400
IronPort-SDR: nwolrVwpXjISpO9MkRDdcr7JaWnxj0rmcsnhP3BwKUFAoHm9CeF1E2l2QdnfwYZMUkogW3DXfN
 E6Gf6Oy7W0ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 05:09:24 -0700
IronPort-SDR: ottMVBwfk9uGS7l0ZRibu2uEpB7E0mz3fr993pot7KKE3/+pZkwHjIjKpQdp8Kk03ebOUx4HfR
 CHmXGkMKygpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="299751833"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2020 05:09:22 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci: Fix SDHCI_QUIRK_BROKEN_CQE
Date:   Mon, 18 May 2020 15:09:39 +0300
Message-Id: <20200518120939.1399-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Previous to commit 511ce378e16f07 ("mmc: Add MMC host software queue
support"), removing MMC_CAP2_CQE was enough to disable command queuing, but
now the cqe_ops must also be NULL otherwise ->cqe_enable() will be
called. Fix SDHCI_QUIRK_BROKEN_CQE to do that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 511ce378e16f07 ("mmc: Add MMC host software queue support")
---
 drivers/mmc/host/sdhci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9864e877e105..682ca8f0be8c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4131,9 +4131,6 @@ int sdhci_setup_host(struct sdhci_host *host)
 		       mmc_hostname(mmc), host->version);
 	}
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CQE)
-		mmc->caps2 &= ~MMC_CAP2_CQE;
-
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
@@ -4662,6 +4659,12 @@ int __sdhci_add_host(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;
 
+	if ((mmc->caps2 & MMC_CAP2_CQE) &&
+	    (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
+		mmc->caps2 &= ~MMC_CAP2_CQE;
+		mmc->cqe_ops = NULL;
+	}
+
 	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
 	if (!host->complete_wq)
 		return -ENOMEM;
-- 
2.17.1

