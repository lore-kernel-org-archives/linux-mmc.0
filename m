Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4253C83013
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664CB221FB
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbgLBHDW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:03:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:44051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgLBHDV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 02:03:21 -0500
IronPort-SDR: dSh0a4i0un78DEYoXidV93Z6O6tmkdPpw8jrB2LfPFR/tCpgCAmUSHhLjoyXJYWjvOURUQUwuj
 K789pe6dfeUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169461814"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="169461814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:02:35 -0800
IronPort-SDR: F5FL9BWhP9/jksfU/Tyf6FI/3KwHtZ08oEhhaeXhVKcp+A4P729DoD7m0DVlEx0gZMRVCDrANs
 /FieEoC1Jwqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481429997"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:02:32 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, mgross@linux.intel.com
Subject: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Wed,  2 Dec 2020 23:02:00 +0800
Message-Id: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hello

This patch series adds UHS-1 Support for Keem Bay SOC.

Patch 1 : Add struct device *dev in probe func(),so that dev pointer can be widely use in probe to make code more readable.
Patch 2 : Export function to be use by device driver to configure voltage rail output.
Patch 3 : Defined the DT binding to support the UHS-1 operation.
Patch 4 : Gives an overview of how voltage operations happen to support UHS-1 mode for Keem Bay SOC.

All of these patches was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Thank you.

Changes since v5:
- Restructured voltage operation for io bus line in one function and added comments in sdhci-of-arasan.c.
- Use gpio regulator modelling for expander pins.
- Add DT Bindings for phys, vmmc and vqmmc supplies.
- Renamed func name and added comments for firmware header files.
- Update commit message for each patchs to describe what goes on.

Changes since v4:
- Fixed comment by Andy and Sudeep on first patch.
- Add Acked-by tag.
- Fixed comment by Michal and Andy on the third patch to replace current users of &pdev->dev.

Changes since v3:
- Add Dt bindings for uhs gpio.
- Fixed comment by Michal and Sudeep on header file for the macro and error code.
- Fixed comment by Andy and created 1 new patch to separate the struc dev pointer in probe func.
- Fixed comment by Michal in arasan controller code.

Changes since v2:
- Removed Document DT Bindings for Keembay Firmware.
- Removed Firmware Driver to handle ATF Service call.
- Add header file to handle API function for device driver to communicate with Arm Trusted Firmware.

Changes since v1:
- Add Document DT Bindings for Keembay Firmware.
- Created Firmware Driver to handle ATF Service call.
- Provide API for arasan driver for sd card voltage changes.


Muhammad Husaini Zulkifli (4):
  mmc: sdhci-of-arasan: Add structure device pointer in probe func
  firmware: keembay: Add support for Trusted Firmware Service call
  dt-bindings: mmc: Add phys, vmmc and vqmmc supplies for Keem Bay SOC
  mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   6 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 282 ++++++++++++++++--
 include/linux/firmware/intel/keembay.h        |  54 ++++
 3 files changed, 322 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/firmware/intel/keembay.h

--
2.17.1

