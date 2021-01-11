Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF2DC433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AE022A83
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 15:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbhAKPwK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:52:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:23997 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731466AbhAKPwJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Jan 2021 10:52:09 -0500
IronPort-SDR: okogNNFDjef2Tg6suwu/QxcK564K52C2sXl5BmfKoqcnMqbSOD+yuM9bamq8Fm4hK3Lbw9y4Ew
 9vxJiz69zy+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157661823"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157661823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 07:51:29 -0800
IronPort-SDR: DILJyjPplbo5AgKrMCFvYkVOWnMtMGib8BhiefjKjcFb58AtybpMdq7egI+to/MDv4ZCNyBWy8
 /Ct8PB53698w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="404152377"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2021 07:51:27 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, andriy.shevchenko@intel.com,
        muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 2/2] mmc: sdhci-of-arasan: Change code style of mapping the syscon field
Date:   Mon, 11 Jan 2021 23:50:01 +0800
Message-Id: <20210111155001.12307-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
References: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change code style of mapping the syscon in sdhci_arasan_update_support64b()
for readability and consistency.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 643313687b5e..8a406b62c6ad 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1395,10 +1395,10 @@ static void sdhci_arasan_update_support64b(struct sdhci_host *host, u32 value)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
-	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
-		sdhci_arasan->soc_ctl_map;
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 
 	/* Having a map is optional */
+	soc_ctl_map = sdhci_arasan->soc_ctl_map;
 	if (!soc_ctl_map)
 		return;
 
-- 
2.17.1

