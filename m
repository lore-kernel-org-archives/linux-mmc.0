Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645AFC32771
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIZTU5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIZTUw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:20:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4D53D1A
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220051; x=1695756051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6s/gmjqXfmeMI2ITVsFOBiLeZQ0MfM3x1sRe7ufatus=;
  b=Lgkf88MTsFjZNlAcZM4BwgyGzMpMW9MrzmI9auvvMMgdXvvQ4SrwvnnG
   lA5uEhAPQfiwMRfQcw8DHCsSZcH+8uGy0hQNdsJmg2i7veC0jqDaGEmtR
   cWw8DIcPWCO9XIAktIsh6xsvFN5DTbPBOldM06Ka9h9R6pbJgB8Txhps4
   WiPAz/aw4sImCZ2jqL0nf4OqPjg3766RrWea6pRE7wrIV6iqYAb63Dl+R
   1T7jGEfTW+SHtP5gx/hzAydje3QrIAhAT2ai7mlz9APRXuTGh9CD75+cV
   5F1Rc1iKZNCCgb9ykD3Fcj1whw0x6TF5+iDkuIqNgJ/97dOissNJJhao/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298717924"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298717924"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796455607"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796455607"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: [PATCH 4/4] mmc: sdhci: Centralize CMD and DATA reset handling
Date:   Mon, 26 Sep 2022 22:20:22 +0300
Message-Id: <20220926192022.85660-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926192022.85660-1-adrian.hunter@intel.com>
References: <20220926192022.85660-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Centralize CMD and DATA reset handling so that is more obvious how reset
is handled in different situations.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 52 ++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df79b407813f..9d03edcccaa5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -258,6 +258,36 @@ static void sdhci_reset_for_all(struct sdhci_host *host)
 	}
 }
 
+enum sdhci_reset_reason {
+	SDHCI_RESET_FOR_INIT,
+	SDHCI_RESET_FOR_REQUEST_ERROR,
+	SDHCI_RESET_FOR_REQUEST_ERROR_DATA_ONLY,
+	SDHCI_RESET_FOR_TUNING_ABORT,
+	SDHCI_RESET_FOR_CARD_REMOVED,
+	SDHCI_RESET_FOR_CQE_RECOVERY,
+};
+
+static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
+{
+	switch (reason) {
+	case SDHCI_RESET_FOR_INIT:
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		break;
+	case SDHCI_RESET_FOR_REQUEST_ERROR:
+	case SDHCI_RESET_FOR_TUNING_ABORT:
+	case SDHCI_RESET_FOR_CARD_REMOVED:
+	case SDHCI_RESET_FOR_CQE_RECOVERY:
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		break;
+	case SDHCI_RESET_FOR_REQUEST_ERROR_DATA_ONLY:
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		break;
+	}
+}
+
+#define sdhci_reset_for(h, r) sdhci_reset_for_reason((h), SDHCI_RESET_FOR_##r)
+
 static void sdhci_set_default_irqs(struct sdhci_host *host)
 {
 	host->ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
@@ -326,7 +356,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	unsigned long flags;
 
 	if (soft)
-		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		sdhci_reset_for(host, INIT);
 	else
 		sdhci_reset_for_all(host);
 
@@ -1541,8 +1571,9 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 	 */
 	if (data->error) {
 		if (!host->cmd || host->cmd == data_cmd)
-			sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+			sdhci_reset_for(host, REQUEST_ERROR);
+		else
+			sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
 	}
 
 	if ((host->flags & (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA)) ==
@@ -2710,8 +2741,7 @@ void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
 	sdhci_reset_tuning(host);
 
-	sdhci_do_reset(host, SDHCI_RESET_CMD);
-	sdhci_do_reset(host, SDHCI_RESET_DATA);
+	sdhci_reset_for(host, TUNING_ABORT);
 
 	sdhci_end_tuning(host);
 
@@ -2979,8 +3009,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		pr_err("%s: Resetting controller.\n",
 			mmc_hostname(mmc));
 
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		sdhci_reset_for(host, CARD_REMOVED);
 
 		sdhci_error_out_mrqs(host, -ENOMEDIUM);
 	}
@@ -3051,8 +3080,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		sdhci_reset_for(host, REQUEST_ERROR);
 
 		host->pending_reset = false;
 	}
@@ -3876,10 +3904,8 @@ void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
 
 	host->cqe_on = false;
 
-	if (recovery) {
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-	}
+	if (recovery)
+		sdhci_reset_for(host, CQE_RECOVERY);
 
 	pr_debug("%s: sdhci: CQE off, IRQ mask %#x, IRQ status %#x\n",
 		 mmc_hostname(mmc), host->ier,
-- 
2.25.1

