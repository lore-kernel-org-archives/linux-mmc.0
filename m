Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C07C54EBD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbjAMLKx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbjAMLKG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AF77AEE
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607637; x=1705143637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7icSX8co7YNefhoq2bVjeWRjx7aROHk+WySj5qOh/Q=;
  b=InNsNfyPQMqSa7CH0ZGdno+gsigBcRqsfW70izMXzyzb6c+zF45pxts2
   nJwY8yYWzvMJiBbS3r89Hcxg9cHlzn0KjdVcVmWLmo1Hx3mPaAKH93c2M
   JoYlolcUZxs8LEgI65wlz1W92VI04ATSfSoBFztkSiL9R68RgppnM6wZb
   kBTZf99ba2+N4LWOSlN+P+MHdls5dvq7CljuiWFVd5INTGLOqzU/JIeKp
   b/ze+K6t24D6aWu142RUBROfjKluc0wiI57gcVJ2Y116eTV+UzVqnza/Z
   kk7+8RFMCkNtnndJNivQwhk5sf4azcQXg+oAAHZVH7OzbvKmOfteyqE4h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668299"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668299"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690471787"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690471787"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:33 -0800
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
Subject: [PATCH 1/6] mmc: sdhci-pci: Replace SDHCI_QUIRK_MISSING_CAPS for Ricoh controller
Date:   Fri, 13 Jan 2023 13:00:06 +0200
Message-Id: <20230113110011.129835-2-adrian.hunter@intel.com>
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
SDHCI_QUIRK_MISSING_CAPS with __sdhci_read_caps() for Ricoh SDHCI
controller.

__sdhci_read_caps() is also called from sdhci_setup_host() via
sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
anything because after that host->read_caps has been set to true.

Note, __sdhci_read_caps() does more than just set host->caps, such as do a
reset, so calling __sdhci_read_caps() earlier could have unforeseen
side-effects. However the code flow has been reviewed with that in mind.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index c359f867df0a..01975d145200 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -251,13 +251,16 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
 
 static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->caps =
+	u32 caps =
 		FIELD_PREP(SDHCI_TIMEOUT_CLK_MASK, 0x21) |
 		FIELD_PREP(SDHCI_CLOCK_BASE_MASK, 0x21) |
 		SDHCI_TIMEOUT_CLK_UNIT |
 		SDHCI_CAN_VDD_330 |
 		SDHCI_CAN_DO_HISPD |
 		SDHCI_CAN_DO_SDMA;
+	u32 caps1 = 0;
+
+	__sdhci_read_caps(slot->host, NULL, &caps, &caps1);
 	return 0;
 }
 
@@ -286,8 +289,7 @@ static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
 #endif
 	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
 			  SDHCI_QUIRK_CLOCK_BEFORE_RESET |
-			  SDHCI_QUIRK_NO_CARD_NO_RESET |
-			  SDHCI_QUIRK_MISSING_CAPS
+			  SDHCI_QUIRK_NO_CARD_NO_RESET,
 };
 
 static void ene_714_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.34.1

