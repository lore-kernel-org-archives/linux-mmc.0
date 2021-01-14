Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1CDC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED3B23A7E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhANP3I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:7040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:08 -0500
IronPort-SDR: a4FuUivT27wljN/tx5AaKxFe9DgCQDqo2ZdXkEA1Z9DqxhpRzaGoCJybqmVUECH27fHZiXkOHP
 BahzXCWFVOKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604640"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:27 -0800
IronPort-SDR: TYZ7Q2aL7R7JrACOCFOgwW2AhaDagifQc2o36b02ZaTDDDKMdMsJQ2932U6hNxQcAM9xjssNPq
 fSkYNq1rFYHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193538"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:24 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 0/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem Bay SOC
Date:   Thu, 14 Jan 2021 23:26:51 +0800
Message-Id: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This patch series adds Ultra High Speed(UHS-1) Bus Speed Mode Support for Keem Bay SoC SD Card.
Summary of each patches as per below:

Patch 1: Use of_device_get_match_data() helper to get the match-data.
Patch 2: Convert to use np pointer instead of using pdev->dev.of_node.
Patch 3: Add struct device *dev in probe func(), so that dev pointer can be widely use in probe to make code more readable.
Patch 4: Change from dev_err to dev_err_probe() to avoid spamming logs when probe is deferred.
Patch 5: Export function to be use by device driver to configure i/o voltage rail output which communicate with Trusted Firmware.
Patch 6: Update phy and regulator supply for Keem Bay SoC.
Patch 7: Add DT Binding for Keem Bay SoC SD Regulator.
Patch 8: Add SD Regulator driver to support Keem Bay SoC. This is to model using standard regulator abstraction during voltage operation
as for Keem Bay SoC, i/o voltage rail need to be configure by setting specific bit in the AON_CFG1 Register.
AON_CFG1 Register is a secure register. Direct access to AON_CFG1 register will cause firewall violation in secure system.
Patch 9: Add Ultra High Speed (UHS-1) Support for Keem Bay SOC. For Keem Bay hardware, two regulators are been used to change the I/O bus line voltage which are "vqmmc-supply" and "sdvrail-supply".

All of these patches was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Muhammad Husaini Zulkifli (9):
  mmc: sdhci-of-arasan: use of_device_get_match_data()
  mmc: sdhci-of-arasan: Convert to use np instead of pdev->dev.of_node
  mmc: sdhci-of-arasan: Add structure device pointer in probe function
  mmc: sdhci-of-arasan: Use dev_err_probe() to avoid spamming logs
  firmware: keembay: Add support for Trusted Firmware Service call
  dt-bindings: mmc: Update phy and regulator supply for Keem Bay SOC
  dt-bindings: regulator: keembay: Add DT binding documentation
  regulator: keembay: Add regulator for Keem Bay SoC
  mmc: sdhci-of-arasan: Add UHS-1 support for Keem Bay SOC

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   7 +-
 .../bindings/regulator/keembay-regulator.yaml |  36 ++
 drivers/mmc/host/sdhci-of-arasan.c            | 313 ++++++++++++++++--
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/keembay-sd-regulator.c      | 112 +++++++
 include/linux/firmware/intel/keembay.h        |  82 +++++
 7 files changed, 532 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/keembay-regulator.yaml
 create mode 100644 drivers/regulator/keembay-sd-regulator.c
 create mode 100644 include/linux/firmware/intel/keembay.h

--
2.17.1

