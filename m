Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4039C47096
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99539613DC
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCSYe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:24:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:49409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCSYe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Jun 2021 14:24:34 -0400
IronPort-SDR: wFJLshbVpfjsCemWeAdVfTVvAWotyCKsyaSpaeMXDKKFw3jnZNCEYIfd44HXkhmm3yTLmbQbuu
 UOyXe62ipGdA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="289746027"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="289746027"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:22:47 -0700
IronPort-SDR: kMYEYCsYzedndKna6i+wv7rn59/iLcyM+9qilAh/ZATEsuMfMYnrCpYDtcck3lqVInCaeduH00
 L+w3scUr95SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="636326849"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2021 11:22:42 -0700
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
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=200/2=5D=20=5BKMB=5D=20mmc=20clock-frequency=20property=20update=20and?=
Date:   Thu,  3 Jun 2021 23:52:40 +0530
Message-Id: <20210603182242.25733-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Patch1: If clock-frequency property is set and it is not the same as the
        current clock rate of clk_xin(base clock frequency), set clk_xin
        to use the provided clock rate.

Patch2: Since the EMMC clock in KMB was changed from 200Mhz to 175Mhz in
	FIP,there were some warnings introduced, as the frequency values
        being checked was still wrt 200Mhz in code. Hence, the frequency
        checks are now updated based on the current 175Mhz EMMC clock
        changed in FIP.

Review comments from Adrian Hunter have been incorporated.
Above 2  patches are tested with Keem Bay evaluation module board.

Please help to review this patch set.


Rashmi A (2):
  mmc: sdhci-of-arasan: Use clock-frequency property to update clk_xin
  phy: intel: Fix for warnings due to EMMC clock 175Mhz change in FIP

 drivers/mmc/host/sdhci-of-arasan.c         | 14 ++++++++++++--
 drivers/phy/intel/phy-intel-keembay-emmc.c |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.17.1

