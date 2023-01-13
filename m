Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF877C54EBD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbjAMLK7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjAMLKP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDFF7D1D4
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607647; x=1705143647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3XlDg7FdYzlLZCC+U+RKk2mb2sZwZnoSQsmG9K6Q4wI=;
  b=O6Y4Lja1gVrWHh/MdO3HqWjFEHpWO1y8PcR1A1xYtosKsXZIslZXo/3+
   EPy4G5dTTEHGdNLGbEBp0K2N9QGoDGlGDXxRd4Qm3oeujFvCbDOi5uXMJ
   3nzxVBlQ0pqDOcoLoXoVpSbmBLpteXgC9tqlTYFTR+XK0JGQOV7q673H4
   33Oo5bMIIeySIhI7QbQVPZfx0t5N+DQSYWxKhuF0n5M9aXXLVTVpwOsjT
   8aWmG5E0QTz5e+oDmUArPXjBUpqLvGCP2xQP0r10ebkWQ27UBXUShucI5
   RHUBaVVenI3+G2l91irzBOWO8IbiIA0HDSB/2SpIvL6H1n4Z+b9QkW/Ln
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668361"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690472289"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690472289"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:44 -0800
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
Subject: [PATCH 4/6] mmc: sdhci-pxav3: Replace SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:09 +0200
Message-Id: <20230113110011.129835-5-adrian.hunter@intel.com>
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
 drivers/mmc/host/sdhci-pxav3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a6d89a3f1946..e39dcc998772 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -124,10 +124,8 @@ static int armada_38x_quirks(struct platform_device *pdev,
 	struct resource *res;
 
 	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 
-	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	sdhci_read_caps(host);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "conf-sdio3");
-- 
2.34.1

