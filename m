Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBDCC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 11:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD39610C8
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 11:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhJ0L5s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:57:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:23253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234783AbhJ0L5s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Oct 2021 07:57:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230089749"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230089749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 04:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="597333275"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2021 04:55:17 -0700
From:   rashmi.a@intel.com
To:     michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com
Subject: [RESEND PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder
Date:   Wed, 27 Oct 2021 17:25:12 +0530
Message-Id: <20211027115516.4475-1-rashmi.a@intel.com>
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

Reseding V2 patchset to get the dt-binding patches reviewed.

Changes from v1:
Add arasan sdhci dt bindings

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
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 511 ++++++++++++++++++
 7 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
 create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c

-- 
2.17.1

