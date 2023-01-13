Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E25C678D6
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbjAMLKz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjAMLKI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D77D1C1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607644; x=1705143644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3SqguNzX+3VW6pOioMW7TUyxk3Lp+po6nRGspEnfxQ=;
  b=l/4/rLNcLU4/auVXYvsftEA0ohX9jXGu/wEA0tw3w/pT804v6vr0YT9m
   Zruxf0+VVGNDHjUzgcnhe5zaw5WVysW9GYN2GYc7GLMWOEKB46XsJYblI
   F3dTggUa+Y+fY8TpRTcRwAavQmA1Jzm9jsKj0daaMgG3Ni4PwW30qKlwh
   K0Ly4OZdOIYUB7xGarpgDdoZAtQ6DVfxBGbSCO9t4JUEzwgDS1UcK8yRJ
   AwoXpWxmEQXghLoevZdZ/SR4tKvZfzbW/Q66pMWwQaBn4UQ4j6iiOCINY
   baIELwmdlLat3G7b2gbEF+eOK/2UCoYzyPzpAcZcYKZRndCtjQQx+CAIg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668348"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690472114"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690472114"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:40 -0800
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
Subject: [PATCH 3/6] mmc: sdhci-sprd: Replace SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:08 +0200
Message-Id: <20230113110011.129835-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113110011.129835-1-adrian.hunter@intel.com>
References: <20230113110011.129835-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI_QUIRK_MISSING_CAPS is not needed because sdhci_read_caps() can be
called instead.

In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
SDHCI_QUIRK_MISSING_CAPS with sdhci_read_caps().

__sdhci_read_caps() is also called from sdhci_setup_host() via
sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
anything because after that host->read_caps has been set to true.

Note, __sdhci_read_caps() does more than just set host->caps, such as do a
reset, so calling __sdhci_read_caps() earlier could have unforeseen
side-effects. However the code flow has been reviewed with that in mind.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 525f979e2a97..7f4ee2e12735 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -553,8 +553,7 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MISSING_CAPS,
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
@@ -671,8 +670,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	 * will allow these modes to be specified only by device
 	 * tree properties through mmc_of_parse().
 	 */
-	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	sdhci_read_caps(host);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
-- 
2.34.1

