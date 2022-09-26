Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA5BC07E9D
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIZTUx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIZTUv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:20:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512887FFB8
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220045; x=1695756045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9wnMDJvABehFoZv/UAp0LUk+daPTGRyW7qlVX6hju8=;
  b=SaRWPTe/+Y8F7cvXKaujG00djWrhTEwSYYSXOllFK+gVrBA/Ne8Qk2Wp
   bFIA4itr+jALO6H/7Wcp4gpwfbgBpdBBs9vx/cKSvTQrZMm/ZruglbnZ8
   aiG6lEXyYTu9ua98olnYiKE5xxuvnVX1RKZUZlyjn9z5G7iPdUZNfHH4W
   cU1vQ21ugWEZYNkmJF5EKRCbxHxzO0kdpbfKqH/pGe8mxFQKYrv+v1wGv
   s1faKh0IpdV32AhmRcpeurnK28hsDiDuRa17Dr9lo69YBJeAYeGh7igbO
   fpV/0mrgrx/WG7XUZd/DArZ9X3xopPOFLlbhsBmoFWyerdI7tiYBlWWON
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298717909"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298717909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796455579"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796455579"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: [PATCH 2/4] mmc: sdhci: Remove misleading comment about resets
Date:   Mon, 26 Sep 2022 22:20:20 +0300
Message-Id: <20220926192022.85660-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926192022.85660-1-adrian.hunter@intel.com>
References: <20220926192022.85660-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In SDHCI specification section 3.10.1 Error Interrupt Recovery, the flow
chart shows Software Reset for CMD separately and before Software Reset for
DAT, so the comment "Spec says we should do both at the same time" is not
correct. Remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 34b351363f41..100c7d6be385 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3059,10 +3059,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		/*
-		 * Spec says we should do both at the same time, but Ricoh
-		 * controllers do not like that.
-		 */
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-- 
2.25.1

