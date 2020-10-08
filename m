Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A887C433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 02:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA3B207C3
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 02:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgJHCMs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 22:12:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:31771 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgJHCMs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 22:12:48 -0400
IronPort-SDR: 4xC+YK24E2Hmmh7HepWnd43QltlxctlkcmWDmyR34LmBPRObmq62/Lsa3JtA9ECBbSSAnj4Hi3
 sI/+ceDTA8YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152154691"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="152154691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 19:12:47 -0700
IronPort-SDR: koBqk6+6qChIDfC1odQe1YOdDdplcX5P9to+IEEk8KRbccgfobBiH7jehekdDXWkht7pdK4QEY
 8/gI5OJXU8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355211171"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 19:12:44 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v4 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
Date:   Thu,  8 Oct 2020 10:09:32 +0800
Message-Id: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Hi.

The first patch is the header file to handle ATF call.

The second patch is DT binding for arasan controller for uhs support.

The third patch is to introduce the structure device pointer in arasan controller probe.

The fourth patch is to enable UHS-1 Support for Keem Bay EVM.

All of these patches was tested with Keem Bay evaluation module board.

Kindly help to review this patch set.

Thank you.

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
- Created Firmware Driver to handle ATF Service call
- Provide API for arasan driver for sd card voltage changes

Muhammad Husaini Zulkifli (4):
  firmware: keembay: Add support for Arm Trusted Firmware Service call
  dt-bindings: mmc: Add uhs-gpio for Keem Bay UHS-1 Support
  mmc: sdhci-of-arasan: Add structure device pointer in probe
  mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   8 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 127 ++++++++++++++++++
 .../linux/firmware/intel/keembay_firmware.h   |  47 +++++++
 3 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/firmware/intel/keembay_firmware.h

--
2.17.1

