Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C107C61DB3
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbjAMLKy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjAMLKH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:10:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BC7CDFE
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 03:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673607641; x=1705143641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Fhnj7G/UOKooAX4JYNOGdm+eaoJypN+V+gbWvMEyUE=;
  b=PlrBMwBT2ApWgu0nZANc0HihCddqjhHuFoL2dduPYi4ewj/p8U3C6rIg
   55UL6bBFMrCSy8RtbmY+LdQbbCEwEtleXSVYiDv4oI/WgGk/GhXkPVne1
   ZynRWWFdZs1QxWjvdGmLNTRb9BNAlF9oNoJ/LFVum1dcH4WI8Z14ZFdfV
   eRnIefxN5Ur4qsLfX1z+sr2KEu9ZdYLb6EKrBxukU5MVLEH8oZ5s8p6Fz
   BLeaK34G9+3KdpkuzSSCZW/kEAqAaS9oZuCxhw3r/J5tPOyRU7mTA/PmB
   CP6CWMsaWyB5V97OG+PtnJCiXGvjuIe8gdA2D0bfG7YPm/PFu3A7P5LW4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322668319"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322668319"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690471933"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690471933"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:00:36 -0800
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
Subject: [PATCH 2/6] mmc: sdhci-brcmstb: Replace SDHCI_QUIRK_MISSING_CAPS
Date:   Fri, 13 Jan 2023 13:00:07 +0200
Message-Id: <20230113110011.129835-3-adrian.hunter@intel.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f2cf3d70db79..0a19b7af1d41 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -324,13 +324,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	 * will allow these modes to be specified by device tree
 	 * properties through mmc_of_parse().
 	 */
-	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	sdhci_read_caps(host);
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_NO_64BIT)
 		host->caps &= ~SDHCI_CAN_64BIT;
-	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
-	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
-- 
2.34.1

