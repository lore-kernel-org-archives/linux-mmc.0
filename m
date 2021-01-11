Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6DC43381
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794BD2251F
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbhAKPwI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:52:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:23992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbhAKPwH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Jan 2021 10:52:07 -0500
IronPort-SDR: ojxDKrDrFbT794HdlfjBowoA1Pp16qDIw46vwxKaE91U2vAf2aXXM0DpreeaPe7IrEaBz81Wf2
 Hy/IaJbHl2lQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157661819"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157661819"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 07:51:27 -0800
IronPort-SDR: gtMz88MwI9mWj6bx568HRnoJWGtnSicB8P+JdeCqqQ7M1fU2hZ5d+mwHmDHICC0SatEcDDO6oD
 dKZT+pRseefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="404152367"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2021 07:51:25 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, andriy.shevchenko@intel.com,
        muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 1/2] mmc: sdhci-of-arasan: Fixed kernel-doc format warning
Date:   Mon, 11 Jan 2021 23:50:00 +0800
Message-Id: <20210111155001.12307-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
References: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
introduces syscon map sdhci_arasan_update_support64b(). Unfortunately,
kernel-doc format script tool has not been run before and causing warning
on the documentation style.

Below is the output when running the kernel-doc script tool:
drivers/mmc/host/sdhci-of-arasan.c:1388: warning: contents before sections

Let's fix this by using standard conventions kernel-doc format.

Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4f3774bcda94..643313687b5e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1380,17 +1380,16 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)

 /**
  * sdhci_arasan_update_support64b - Set SUPPORT_64B (64-bit System Bus Support)
+ * @host:		The sdhci_host
+ * @value:		The value to write
  *
  * This should be set based on the System Address Bus.
  * 0: the Core supports only 32-bit System Address Bus.
  * 1: the Core supports 64-bit System Address Bus.
  *
- * NOTES:
- * - For Keem Bay, it is required to clear this bit. Its default value is 1'b1.
- *   Keem Bay does not support 64-bit access.
- *
- * @host:		The sdhci_host
- * @value:		The value to write
+ * NOTE:
+ * For Keem Bay, it is required to clear this bit. Its default value is 1'b1.
+ * Keem Bay does not support 64-bit access.
  */
 static void sdhci_arasan_update_support64b(struct sdhci_host *host, u32 value)
 {
--
2.17.1

