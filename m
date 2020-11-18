Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16633C56202
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 04:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47B424654
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 04:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKREBo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 23:01:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:19158 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgKREBo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 23:01:44 -0500
IronPort-SDR: Uqm+6U+AXvlPr4ayZEa2D3NO9lXSc3GsgIexGuQYllymm33YchgRirKGNVHZbbWeVCOWSE8afX
 ZccmQMG6tpUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150331103"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150331103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 20:01:43 -0800
IronPort-SDR: ztFKjl0wJ42g1fDN9qPbeudBKkz3H6I9sjILWdWJ3tIvDoIZah7cTMUWxrZMJfCiXMaXdM0TRC
 8reOJD0KYxyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="310441546"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2020 20:01:41 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, david.e.box@linux.intel.com
Subject: [PATCH v2 1/1] mmc: sdhci-of-arasan: Fix clock registration fail for Keem Bay SOC
Date:   Wed, 18 Nov 2020 20:01:20 +0800
Message-Id: <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com>
References: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
introduces platform specific SDHCI clock operation. Each platform should
specify clock operations handlers.

Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
and Commit 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")
are merged about the same time. When doing rebasing during the upstream process,
Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
was not included. This will result in sd clock registration failure for
Keem Bay SOC Devices as clock operations handlers are not defined.

This patch declares the clock operation for Keem Bay SOC Devices.
Add clk_ops for SD, EMMC and SDIO operations.

Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 829ccef87426..012d52e1abee 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1199,16 +1199,19 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_emmc_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_sd_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_sd_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_sdio_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
-- 
2.17.1

