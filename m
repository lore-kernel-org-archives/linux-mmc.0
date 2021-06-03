Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9179C47097
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9968613B1
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFCSYn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:24:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:6082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhFCSYn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Jun 2021 14:24:43 -0400
IronPort-SDR: aOcLcuL9OYIw11QK0I8CT7L6vbX0EzEPzJrgTtWTyFiTDXyZK/vBdmJK+eOj+d8u7TCqBzyWCO
 7/st+1mK75CQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191222693"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="191222693"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:22:58 -0700
IronPort-SDR: D+avzjsf6I/iFZiMJ35B0jk7tlOXafIUv+nJ6XVxw3UrSMKNG5PqDekxYZ9JyFZYSGRNTfOpzm
 0+k8jS4ZCyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="636326876"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2021 11:22:54 -0700
From:   rashmi.a@intel.com
To:     linux-drivers-review-request@eclists.intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, rashmi.a@intel.com
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=202/2=5D=20phy=3A=20intel=3A=20Fix=20for=20warnings=20due=20to=20EMMC=20clock=20175Mhz=20change=20in=20FIP?=
Date:   Thu,  3 Jun 2021 23:52:42 +0530
Message-Id: <20210603182242.25733-3-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603182242.25733-1-rashmi.a@intel.com>
References: <20210603182242.25733-1-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Since the EMMC clock was changed from 200Mhz to 175Mhz in FIP,
there were some warnings introduced, as the frequency values
being checked was still wrt 200Mhz in code. Hence, the frequency
checks are now updated based on the current 175Mhz EMMC clock changed
in FIP.

Spamming kernel log msg:
"phy phy-20290000.mmc_phy.2: Unsupported rate: 43750000"

Signed-off-by: Rashmi A <rashmi.a@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/phy/intel/phy-intel-keembay-emmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-keembay-emmc.c b/drivers/phy/intel/phy-intel-keembay-emmc.c
index eb7c635ed89a..0eb11ac7c2e2 100644
--- a/drivers/phy/intel/phy-intel-keembay-emmc.c
+++ b/drivers/phy/intel/phy-intel-keembay-emmc.c
@@ -95,7 +95,8 @@ static int keembay_emmc_phy_power(struct phy *phy, bool on_off)
 	else
 		freqsel = 0x0;
 
-	if (mhz < 50 || mhz > 200)
+	/* Check for EMMC clock rate*/
+	if (mhz > 175)
 		dev_warn(&phy->dev, "Unsupported rate: %d MHz\n", mhz);
 
 	/*
-- 
2.17.1

