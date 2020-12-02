Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C24C83019
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BCA2222E
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgLBHDf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:03:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:44047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgLBHDf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 02:03:35 -0500
IronPort-SDR: Mc7Nl/POy9nrzbNOdLoSU3QpfVkcwxiqa438y2UerZTXTFdZ7FUOHH32Y9nN8v9uWNdF+LNWYR
 W6dBt7lfyAnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169461823"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="169461823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:02:43 -0800
IronPort-SDR: 2JyL6Se+Ry3+cd4u2KnjN4S7t39Sxq8PBtnbkkq4AAZShMaHs1O1SaQ+VVI6T4mRNl8IZhiIDU
 SzE/FT8JvtZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481430040"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:02:40 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, mgross@linux.intel.com
Subject: [PATCH v6 3/4] dt-bindings: mmc: Add phys, vmmc and vqmmc supplies for Keem Bay SOC
Date:   Wed,  2 Dec 2020 23:02:03 +0800
Message-Id: <20201202150205.20150-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add DT bindings of vmmc and vqmmc supplies of regulator and phys for
the phandle of sd0_phy which contain additional property for
otap delay and sel_clk_buffer.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 0753289fba84..0cbfdd840889 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -83,7 +83,7 @@ properties:
       - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
         description:
           For this device it is strongly suggested to include
-          arasan,soc-ctl-syscon.
+          arasan,soc-ctl-syscon, phys, vmmc-supply and vqmmc-supply.
       - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
         description:
           For this device it is strongly suggested to include
@@ -299,5 +299,9 @@ examples:
           clock-names = "clk_xin", "clk_ahb";
           clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
+          phys = <&sd0_phy>;
+          phy-names = "phy_arasan";
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+          vmmc-supply = <&reg_sd0_vcc>;
+          vqmmc-supply = <&reg_sd0_vqcc>;
     };
-- 
2.17.1

