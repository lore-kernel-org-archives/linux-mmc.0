Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404FBC54EBE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjAMLLA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAMLKQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2027D1D5
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607651; x=1705143651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Si8c+66kN4FiqyfNlQp5C3RRW/EGmd1cUu6ShfurEDU=;
  b=IUn2h2QcfQ4rrXqS+QNaI3iMv+yUAdqsDk9ATiqwsGScI1+Pb/yc8aY+
   7Evm+ra+QXHuwpwWngXd8Rx3/nLgducO4y7Otc1G6rfn1C5Wxz9FFcCV8
   SWirvds6DJE1BYq9Ps43l4VjqWpPoeNG+GmtXCvFQt/btFVlNYeHb+3/J
   sF32N0oTDZCo1SzgMItymxn1iNE7m4L+knOULS5HGUF0z/YxVHU/BfDVW
   1x6P2mU1XZBV+q11WVWHX0KqGAJ8PDLWExQ6thLMx6CEjB0NZw37gTeZr
   d8YeoMSTpqRFt2JWamqiHw5Y3w+H13K9CJfVX/5CCNFZUd5ES6Rauyj1h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668380"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668380"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690472492"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690472492"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Subject: [PATCH 5/6] mmc: sdhci-iproc: Replace SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:10 +0200
Message-Id: <20230113110011.129835-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113110011.129835-1-adrian.hunter@intel.com>
References: <20230113110011.129835-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI_QUIRK_MISSING_CAPS is not needed because __sdhci_read_caps() can be
called instead.

In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
SDHCI_QUIRK_MISSING_CAPS with __sdhci_read_caps().

__sdhci_read_caps() is also called from sdhci_setup_host() via
sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
anything because after that host->read_caps has been set to true.

Note, __sdhci_read_caps() does more than just set host->caps, such as do a
reset, so calling __sdhci_read_caps() earlier could have unforeseen
side-effects. However the code flow has been reviewed with that in mind.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-iproc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 6db35b1b8557..86eb0045515e 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -18,6 +18,7 @@ struct sdhci_iproc_data {
 	u32 caps;
 	u32 caps1;
 	u32 mmc_caps;
+	bool missing_caps;
 };
 
 struct sdhci_iproc_host {
@@ -251,7 +252,6 @@ static const struct sdhci_iproc_data iproc_data = {
 static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MISSING_CAPS |
 		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_iproc_32only_ops,
@@ -266,6 +266,7 @@ static const struct sdhci_iproc_data bcm2835_data = {
 	.caps1 = SDHCI_DRIVER_TYPE_A |
 		 SDHCI_DRIVER_TYPE_C,
 	.mmc_caps = 0x00000000,
+	.missing_caps = true,
 };
 
 static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
@@ -295,8 +296,7 @@ static const struct sdhci_iproc_data bcm2711_data = {
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm7211a0_pltfm_data = {
-	.quirks = SDHCI_QUIRK_MISSING_CAPS |
-		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		SDHCI_QUIRK_BROKEN_DMA |
 		SDHCI_QUIRK_BROKEN_ADMA,
 	.ops = &sdhci_iproc_ops,
@@ -315,6 +315,7 @@ static const struct sdhci_iproc_data bcm7211a0_data = {
 		SDHCI_CAN_DO_HISPD,
 	.caps1 = SDHCI_DRIVER_TYPE_C |
 		 SDHCI_DRIVER_TYPE_D,
+	.missing_caps = true,
 };
 
 static const struct of_device_id sdhci_iproc_of_match[] = {
@@ -397,9 +398,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
-		host->caps = iproc_host->data->caps;
-		host->caps1 = iproc_host->data->caps1;
+	if (iproc_host->data->missing_caps) {
+		__sdhci_read_caps(host, NULL,
+				  &iproc_host->data->caps,
+				  &iproc_host->data->caps1);
 	}
 
 	ret = sdhci_add_host(host);
-- 
2.34.1

