Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE8C432BE
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 18:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6F960F23
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 18:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhH2SZo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Aug 2021 14:25:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:63344 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhH2SZn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 29 Aug 2021 14:25:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="197736737"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="197736737"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 11:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="445519073"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2021 11:24:44 -0700
From:   rashmi.a@intel.com
To:     michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com
Subject: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Date:   Sun, 29 Aug 2021 23:54:39 +0530
Message-Id: <20210829182443.30802-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

This patch set enables the support for eMMC PHY on the Intel Thunder 
Bay SoC. eMMC PHY is based on arasan phy.
 
Patch 1 Adds arasan sdhci support for eMMC in Intel Thunder Bay.
Patch 2 Adds arasan sdhci dt bindings.
Patch 3 Holds the device tree binding documentation for eMMC PHY
	and listings of new files in MAINTAINERS file.
Patch 4 Holds the eMMC PHY driver.


Rashmi A (4):
  mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan
    eMMC driver
  dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC
  dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
  phy: intel: Add Thunder Bay eMMC PHY support

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |  25 +
 .../phy/intel,phy-thunderbay-emmc.yaml        |  46 ++
 MAINTAINERS                                   |   7 +
 drivers/mmc/host/sdhci-of-arasan.c            |  29 +-
 drivers/phy/intel/Kconfig                     |  10 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 512 ++++++++++++++++++
 7 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
 create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c

-- 
2.17.1

