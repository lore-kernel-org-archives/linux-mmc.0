Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6356C07E9B
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jul 2021 11:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE8F6113A
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jul 2021 11:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhGTLCS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:02:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:57795 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhGTLB7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jul 2021 07:01:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211218051"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211218051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 04:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="510723689"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2021 04:41:34 -0700
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
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=200/3=5D=20Add=20support=20for=20eMMC=20PHY=20on=20Intel=20Thunder=20Bay?=
Date:   Tue, 20 Jul 2021 17:11:30 +0530
Message-Id: <20210720114133.8936-1-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

