Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C1C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jul 2021 06:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E7C60F6B
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jul 2021 06:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhG3GdW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Jul 2021 02:33:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:26966 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhG3GdT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jul 2021 02:33:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="211159317"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="211159317"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="664714855"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2021 23:33:10 -0700
From:   rashmi.a@intel.com
To:     linux-drivers-review-request@eclists.intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, kenchappa.demakkanavar@intel.com,
        rashmi.a@intel.com
Subject: [PATCH 0/3] Add support for eMMC PHY on Intel Thunder Bay
Date:   Fri, 30 Jul 2021 12:03:06 +0530
Message-Id: <20210730063309.8194-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

This patch set enables the support for eMMC PHY on the Intel Thunder Bay
SoC.

Patch 1 Holds the relevant Device Tree bindings documentation
        and listings of new files in MAINTAINERS file
Patch 2 Adds support for eMMC Intel Thunder Bay
Patch 3 Adds Thunder Bay eMMC PHY support

The review comments from Adrian Hunter, Kris Pan, Furong Zhou and Mark
Gross have been incorporated.

Please help to review this patch set

Thanks


Rashmi A (3):
  dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
  mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan
    eMMC driver
  phy: intel: Add Thunder Bay eMMC PHY support

 .../phy/intel,phy-thunderbay-emmc.yaml        |  49 ++
 MAINTAINERS                                   |   7 +
 drivers/mmc/host/sdhci-of-arasan.c            |  29 +-
 drivers/phy/intel/Kconfig                     |  10 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 500 ++++++++++++++++++
 6 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
 create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c

-- 
2.17.1

