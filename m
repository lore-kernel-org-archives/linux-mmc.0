Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B7CC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0F8610C8
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 11:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbhJ0L6E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:58:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:10405 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241711AbhJ0L5z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Oct 2021 07:57:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253691257"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="253691257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 04:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="597333280"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2021 04:55:22 -0700
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
Subject: [RESEND PATCH v2 1/4] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver
Date:   Wed, 27 Oct 2021 17:25:13 +0530
Message-Id: <20211027115516.4475-2-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027115516.4475-1-rashmi.a@intel.com>
References: <20211027115516.4475-1-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Intel Thunder Bay SoC eMMC controller is based on Arasan
eMMC 5.1 host controller IP

Signed-off-by: Rashmi A <rashmi.a@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 737e2bfdedc2..6a2e5a468424 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -191,6 +191,13 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
 	.hiword_update = false,
 };
 
+static const struct sdhci_arasan_soc_ctl_map thunderbay_soc_ctl_map = {
+	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
+	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
+	.support64b = { .reg = 0x4, .width = 1, .shift = 24 },
+	.hiword_update = false,
+};
+
 static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
 	.clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
@@ -456,6 +463,15 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_arasan_thunderbay_pdata = {
+	.ops = &sdhci_arasan_cqe_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		SDHCI_QUIRK2_STOP_WITH_TC |
+		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -1132,6 +1148,12 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.clk_ops = &arasan_clk_ops,
 };
 
+static const struct sdhci_arasan_of_data sdhci_arasan_thunderbay_data = {
+	.soc_ctl_map = &thunderbay_soc_ctl_map,
+	.pdata = &sdhci_arasan_thunderbay_pdata,
+	.clk_ops = &arasan_clk_ops,
+};
+
 static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -1265,6 +1287,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "intel,keembay-sdhci-5.1-sdio",
 		.data = &intel_keembay_sdio_data,
 	},
+	{
+		.compatible = "intel,thunderbay-sdhci-5.1",
+		.data = &sdhci_arasan_thunderbay_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
@@ -1626,7 +1652,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
-	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
+	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio") ||
+	    of_device_is_compatible(np, "intel,thunderbay-sdhci-5.1")) {
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 		sdhci_arasan_update_support64b(host, 0x0);
 
-- 
2.17.1

