Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B9CC34047
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E0D21D56
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oIazEFoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBSM3O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:29:14 -0500
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:19251
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSM3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 07:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atiMwfqGWhZf98MMS3ISJvfhpGJaqFkZVAeVp/KUuZ7GH+S4iL8WrtgC5F2fA91xynvVULlWTLDz3i6RkoX4rA/HV8SnTDKjdb2myl/yrA/LLuDFQimqvGdNDjjmXJh9hL2zgWukj5XjvyKDZmdnw/yjxXqcY7SEzwxLBwK21Wrej/FKf/agYE+EvoYFuRgFE0PvBQgc65EsPmlp0eLhLKg/3LEigA/Wx5rXfbW1tTpND4l+FSDH+3p3yIa9+d40FgJNdcyZU5uoBT4VOCpV3Dq6XJVkYbsX2/nPuuLq4JPYF75+niRK1weCfc9QtmmHiOZbwaeCfYzlt3x4KswWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuhfFdey9TWHk2X1oJjwiMICoMG38917T1Gl/cbZD18=;
 b=cw7P08InEu7Dji9SLdZsxCV49v+5HK4rVEDO4/Grt0C99W82qpV0cdNIeDvLOSr1iaUPz9C1vI2IYVZx/xokIAymD52sse4+kLrfunSnqDistqLG3vL4WJIC5dGmg9OVKr0hNzDWIrznn+RNKCcDNG8kQNfyWcFWFlGMJLXOVs1YcRB723dwWP1xaWJJTN9WSZ7YAyQRJLkjEF4fDPLnxMBLJGQ9pTzMmfcRp40BETxoq7kGoyJEmtTaiDcl1l88wXbsqzzLqs503PMN13IPR4wrouA6iEg4nZtfVppUxS0UK6yeALmTSOYcfCH1GLSLDEsmJR6Yoy0N6LMzYTqGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuhfFdey9TWHk2X1oJjwiMICoMG38917T1Gl/cbZD18=;
 b=oIazEFoG6rP4OAt91jjZ9xPMYapir4A79eUBEQCywbMl0FewlZfxFhRELOfmNrQNJSoVAwG+ls6j+x7oKKu9NleF/mYVhpxyu5ADxWHuFiRobYtaP0pjLm/CVCM070vufGkcZmrIFIItmWt4c1KlbwaN0s+13uqQnhJmcL+z1tg=
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by MW2PR02MB3788.namprd02.prod.outlook.com (2603:10b6:907:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Wed, 19 Feb
 2020 12:29:07 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Wed, 19 Feb 2020 12:29:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 19 Feb 2020 12:29:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OTR-0006c7-UZ; Wed, 19 Feb 2020 04:29:05 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OTM-00067V-RI; Wed, 19 Feb 2020 04:29:00 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01JCSqZ6029564;
        Wed, 19 Feb 2020 04:28:52 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1j4OTE-00065y-5J; Wed, 19 Feb 2020 04:28:52 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4671D121039; Wed, 19 Feb 2020 17:58:38 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/2] sdhci: arasan: Add support for Versal Tap Delays
Date:   Wed, 19 Feb 2020 17:58:33 +0530
Message-Id: <1582115313-115667-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
References: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(6666004)(356004)(81156014)(8676002)(316002)(4326008)(81166006)(8936002)(186003)(426003)(44832011)(36756003)(70586007)(2616005)(70206006)(5660300002)(336012)(6266002)(107886003)(2906002)(26005)(478600001)(42186006);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3788;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76d8c31-7ba5-4818-eb63-08d7b5374fff
X-MS-TrafficTypeDiagnostic: MW2PR02MB3788:
X-Microsoft-Antispam-PRVS: <MW2PR02MB378876D6ABD20EB89472FD00C1100@MW2PR02MB3788.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQzbtoos0/JXWwHlm0p7fZ4mvoPmAP/9DTFHl/t+mbBSHzUQ00IDsn354cLhz1LIvhHfMz+/a/SzKN+MNTmplA1ce9NHvZE3okr+tqDJYNpEw9nxz84b3qSUuh/1iC9q44ZtcZGHIeYLqaevE2EdODQwtHq1zYFmvLgYBofVCRj3i/F/iTQumA9zZwpdRlJotyYKqot1iGRiYb3laqvlOTBmiY7EYwDOerNXGHPD1W34DTdivlc65sq8MI7fvXu3Im5yPsNUu0u/QNxgcZt09fytGdkjKkO35DRdXNGZafAOXy9kDHCHvvClZCZ3sowuaXsdADcFlLHGSOtxdPj52H3Wm/dgqLOu5kR8MWkgsfMT44Xc3UKdMW6qbRC7DyZw5/QrNqPv8A2XmEBchE2Jf6dWsRMPtxQtgEwgujBfxCrn3iehSoo63NYa5rjtghPF
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 12:29:06.4083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76d8c31-7ba5-4818-eb63-08d7b5374fff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3788
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support to set tap delays for Xilinx Versal SD controller. The tap
delay registers have moved to SD controller space in Versal. Make the
changes accordingly.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 176 ++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0146d7dd315b..d18280793e5b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -28,15 +28,26 @@
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
+
+#define SDHCI_ARASAN_ITAPDLY_REGISTER	0xF0F8
+#define SDHCI_ARASAN_OTAPDLY_REGISTER	0xF0FC
+
 #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
 #define VENDOR_ENHANCED_STROBE		BIT(0)
 
 #define PHY_CLK_TOO_SLOW_HZ		400000
 
+#define SDHCI_ITAPDLY_CHGWIN		0x200
+#define SDHCI_ITAPDLY_ENABLE		0x100
+#define SDHCI_OTAPDLY_ENABLE		0x40
+
 /* Default settings for ZynqMP Clock Phases */
 #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
 #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
 
+#define VERSAL_ICLK_PHASE {0, 132, 132, 0, 132, 0, 0, 162, 90, 0, 0}
+#define VERSAL_OCLK_PHASE {0,  60, 48, 0, 48, 72, 90, 36, 60, 90, 0}
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This allows
@@ -566,6 +577,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "xlnx,zynqmp-8.9a",
 		.data = &sdhci_arasan_zynqmp_data,
 	},
+	{
+		.compatible = "xlnx,versal-8.9a",
+		.data = &sdhci_arasan_zynqmp_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
@@ -634,7 +649,6 @@ static const struct clk_ops arasan_sampleclk_ops = {
  * Return: 0 on success and error value on error
  */
 static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
@@ -706,7 +720,6 @@ static const struct clk_ops zynqmp_sdcardclk_ops = {
  * Return: 0 on success and error value on error
  */
 static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
-
 {
 	struct sdhci_arasan_clk_data *clk_data =
 		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
@@ -768,6 +781,151 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
 	.set_phase = sdhci_zynqmp_sampleclk_set_phase,
 };
 
+/**
+ * sdhci_versal_sdcardclk_set_phase - Set the SD Output Clock Tap Delays
+ *
+ * Set the SD Output Clock Tap Delays for Output path
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees		The clock phase shift between 0 - 359.
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	u8 tap_delay, tap_max = 0;
+	int ret;
+
+	/*
+	 * This is applicable for SDHCI_SPEC_300 and above
+	 * Versal does not set phase for <=25MHz clock.
+	 * If degrees is zero, no need to do anything.
+	 */
+	if (host->version < SDHCI_SPEC_300 ||
+	    host->timing == MMC_TIMING_LEGACY ||
+	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+		return 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		/* For 50MHz clock, 30 Taps are available */
+		tap_max = 30;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		/* For 100MHz clock, 15 Taps are available */
+		tap_max = 15;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		/* For 200MHz clock, 8 Taps are available */
+		tap_max = 8;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	if (tap_delay) {
+		u32 regval;
+
+		regval = sdhci_readl(host, SDHCI_ARASAN_OTAPDLY_REGISTER);
+		regval |= SDHCI_OTAPDLY_ENABLE;
+		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
+		regval |= tap_delay;
+		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
+	}
+
+	return ret;
+}
+
+static const struct clk_ops versal_sdcardclk_ops = {
+	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
+	.set_phase = sdhci_versal_sdcardclk_set_phase,
+};
+
+/**
+ * sdhci_versal_sampleclk_set_phase - Set the SD Input Clock Tap Delays
+ *
+ * Set the SD Input Clock Tap Delays for Input path
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees		The clock phase shift between 0 - 359.
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	u8 tap_delay, tap_max = 0;
+	int ret;
+
+	/*
+	 * This is applicable for SDHCI_SPEC_300 and above
+	 * Versal does not set phase for <=25MHz clock.
+	 * If degrees is zero, no need to do anything.
+	 */
+	if (host->version < SDHCI_SPEC_300 ||
+	    host->timing == MMC_TIMING_LEGACY ||
+	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+		return 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		/* For 50MHz clock, 120 Taps are available */
+		tap_max = 120;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		/* For 100MHz clock, 60 Taps are available */
+		tap_max = 60;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		/* For 200MHz clock, 30 Taps are available */
+		tap_max = 30;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	if (tap_delay) {
+		u32 regval;
+
+		regval = sdhci_readl(host, SDHCI_ARASAN_ITAPDLY_REGISTER);
+		regval |= SDHCI_ITAPDLY_CHGWIN;
+		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
+		regval |= SDHCI_ITAPDLY_ENABLE;
+		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
+		regval |= tap_delay;
+		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
+		regval &= ~SDHCI_ITAPDLY_CHGWIN;
+		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
+	}
+
+	return ret;
+}
+
+static const struct clk_ops versal_sampleclk_ops = {
+	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
+	.set_phase = sdhci_versal_sampleclk_set_phase,
+};
 static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -965,6 +1123,16 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 		}
 	}
 
+	if (of_device_is_compatible(dev->of_node, "xlnx,versal-8.9a")) {
+		iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_ICLK_PHASE;
+		oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_OCLK_PHASE;
+
+		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
+			clk_data->clk_phase_in[i] = iclk_phase[i];
+			clk_data->clk_phase_out[i] = oclk_phase[i];
+		}
+	}
+
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
 				 "clk-phase-legacy");
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
@@ -1025,6 +1193,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
 		sdcardclk_init.ops = &zynqmp_sdcardclk_ops;
+	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
+		sdcardclk_init.ops = &versal_sdcardclk_ops;
 	else
 		sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
@@ -1077,6 +1247,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
 		sampleclk_init.ops = &zynqmp_sampleclk_ops;
+	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
+		sampleclk_init.ops = &versal_sampleclk_ops;
 	else
 		sampleclk_init.ops = &arasan_sampleclk_ops;
 
-- 
2.17.1

