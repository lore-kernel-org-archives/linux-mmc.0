Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81613C2D0C8
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C9620733
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfLQJym (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:54:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:35646 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfLQJym (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 04:54:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 01:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="416769650"
Received: from unknown (HELO ahunter-Desktop.fi.intel.com) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2019 01:54:42 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 2/2] mmc: sdhci: Add a quirk for broken command queuing
Date:   Tue, 17 Dec 2019 11:53:49 +0200
Message-Id: <20191217095349.14592-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217095349.14592-1-adrian.hunter@intel.com>
References: <20191217095349.14592-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Command queuing has been reported broken on some systems based on Intel
GLK. A separate patch disables command queuing in some cases.

This patch adds a quirk for broken command queuing, which enables users
with problems to disable command queuing using sdhci module parameters for
quirks.

Fixes: 8ee82bda230f ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..f4540f9892ce 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3769,6 +3769,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 		       mmc_hostname(mmc), host->version);
 	}
 
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CQE)
+		mmc->caps2 &= ~MMC_CAP2_CQE;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0eaef5f..fe83ece6965b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -409,6 +409,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
 /* Controller reports inverted write-protect state */
 #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
+/* Controller has unusable command queue engine */
+#define SDHCI_QUIRK_BROKEN_CQE				(1<<17)
 /* Controller does not like fast PIO transfers */
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
 /* Controller does not have a LED */
-- 
2.17.1

