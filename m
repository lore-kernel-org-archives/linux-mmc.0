Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2EFC2BA1E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78B20768
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rBH7qXRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgDFRou (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:44:50 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:20801
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727922AbgDFRou (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 13:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8iFNybzGONSoiKKjQiTQdBKdixZd9v4jv4xeY4dotfKObz8gqioz2JSxBoN0J8S7fiE3qq/ulomNQ+39SdTxgVt1MkY2m3x19l2qfqO0aQMUmHcYhnXfXNxrg9YUmHykQsZB8pZe1NTmlMqe3mPDjPmiOjEXyNwqiHsgcRmq75N4tnoZSHc7w+FysAukR4fUu5as91agP2lI2on+vOaDNtv6FC88tCLnLSKpputoX7scbgajONu8V5oUs7bsV/jLuzt0Ki/DeZT6SoUBtU6dHhcEFf8Tfdbdppi7kuf3rjLbELDUMc8MrkNBBalZ140qQgUN6OufSuEzHODt7Roiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnvUnlGESzpccOv2++1kW6+V57l3CI+sdKUmDoF9GJQ=;
 b=PJWUH02tLZpKPaqtnEXa7w35oSANZ+sULqVh+EOHZlaCu5+RT+zQ0un93oS8LEUFUEnzKt5i9NTfu3vbHNpjhpX4M29swYXwaOVcPGnS0Mw3DWGHd5JJC7K+zxzhAXglDjDq05j+ZeSk7EznVqXV9MHT9J1tIbStktknvEBkI0uS7r3X8HPJ26Rl+JaQ+jIKwS/cUVQrY/FomSOwguq9wyfN+4YHdfRgZqyvyJK6yuP/R1o2KYSFfeOUIgJq1KooPCIWTLgHqfPXEJaEpsOHnXtsUu5BZMuijiyerDHis3YKVPiW9AqYFl3wb1J3Xm414E2Qx1YAdd0gfGR8ZMTk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnvUnlGESzpccOv2++1kW6+V57l3CI+sdKUmDoF9GJQ=;
 b=rBH7qXRHcavsaHsdSYWc7WQ6EcEvr21emayjQCW7dEZIwGbU0Js6vyBIPwF3Xas19XnE++SEicZRjdo7Tykxw4R/VKIDL5FgeyfBNpPVcNyDsc46NYDEaRFzs6SvmaYy1mx5LKX8zoKmbb/EPUt3J2+eGAImBzAUVFVyk+UrRHM=
Received: from BL0PR0102CA0063.prod.exchangelabs.com (2603:10b6:208:25::40) by
 BN7PR02MB4098.namprd02.prod.outlook.com (2603:10b6:406:fd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Mon, 6 Apr 2020 17:44:45 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:25:cafe::58) by BL0PR0102CA0063.outlook.office365.com
 (2603:10b6:208:25::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 17:44:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:44:45
 +0000
Received: from [149.199.38.66] (port=46333 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVnP-0007b6-4S; Mon, 06 Apr 2020 10:44:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVng-0001k7-Mn; Mon, 06 Apr 2020 10:44:44 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 036HiXH9018058;
        Mon, 6 Apr 2020 10:44:34 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jLVnV-0001iS-DB; Mon, 06 Apr 2020 10:44:33 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 337AA12124E; Mon,  6 Apr 2020 23:13:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 4/6] mmc: sdhci-of-arasan: Rearrange the platform data structs for modularity
Date:   Mon,  6 Apr 2020 23:13:33 +0530
Message-Id: <1586195015-128992-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
References: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(82740400003)(4326008)(426003)(107886003)(5660300002)(8936002)(2616005)(6266002)(478600001)(44832011)(2906002)(186003)(81166006)(8676002)(356004)(36756003)(70586007)(6666004)(6636002)(70206006)(336012)(42186006)(26005)(81156014)(47076004)(316002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5077451f-c785-4234-8c7e-08d7da5231a0
X-MS-TrafficTypeDiagnostic: BN7PR02MB4098:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4098D60392CFCD39FB11AF99C1C20@BN7PR02MB4098.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tABiabFkUEbHO7skUQpsKy6mlhv9y67y0gJg7VVDBXlB1Mnkl3gSKRNmxqoSChFVl0nyhf2q0VS77uoKgmOHnuAjGz/3lESJY6Jm0Hvfr+dytqxrQjPtx+YhMUf00QII0Yyc+cWte8P/0hBBezajlUknHKR4DMBtJN+/W5yHwsUVblfkg7nqTy2Hlb4DJaadiOS1YTuv+4jPsp3Npg0etHvuAGYgKm3KToBnycW1nj4HKZCqDRahesUVgJ+STyfub4xn2YdrQbTLNGXzCd9QrpdAL6WvfV1S7oJ22olnuiz2bh+oxxJ8pH8/RJtBGjW0oa9XmNAdrp0YeA5vBZ/JjHAxMEizYotghW39hd0IIBecaeC63IWmn+vp/laNV7enSLtDej5nMuoViXe9BPgwceDQBz7SGH3ZIgpiSKYZ3RtVA6Vff9sMF3y1AswArxOTn9PbANQIK+pX+DiGarbFYnHtkMg06piHyLgJA1o09jiKpM9Kdj347Fz8hXbNk3/TAEnDCa0iUHz8n1TZ9GhPtA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:44:45.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5077451f-c785-4234-8c7e-08d7da5231a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4098
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Existing driver code has the platform specific structures scattered
throughout the driver code. Rearrange the platform specific data
structures for more modularity and readability. This will help in adding
new static functions with more ease.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 158 +++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 77 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 72f5d83..bff726a 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -357,29 +357,6 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_power = sdhci_arasan_set_power,
 };
 
-static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
-	.ops = &sdhci_arasan_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
-			SDHCI_QUIRK2_STOP_WITH_TC,
-};
-
-static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
-	.pdata = &sdhci_arasan_pdata,
-};
-
-static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
-	.ops = &sdhci_arasan_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
-			SDHCI_QUIRK2_STOP_WITH_TC,
-};
-
-static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
-	.pdata = &sdhci_arasan_zynqmp_pdata,
-};
-
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -436,21 +413,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
-static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
-	.soc_ctl_map = &rk3399_soc_ctl_map,
-	.pdata = &sdhci_arasan_cqe_pdata,
-};
-
-static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
-	.soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
-	.pdata = &sdhci_arasan_cqe_pdata,
-};
-
-static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
-	.soc_ctl_map = &intel_lgm_sdxc_soc_ctl_map,
-	.pdata = &sdhci_arasan_cqe_pdata,
-};
-
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -546,45 +508,6 @@ static int sdhci_arasan_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 			 sdhci_arasan_resume);
 
-static const struct of_device_id sdhci_arasan_of_match[] = {
-	/* SoC-specific compatible strings w/ soc_ctl_map */
-	{
-		.compatible = "rockchip,rk3399-sdhci-5.1",
-		.data = &sdhci_arasan_rk3399_data,
-	},
-	{
-		.compatible = "intel,lgm-sdhci-5.1-emmc",
-		.data = &intel_lgm_emmc_data,
-	},
-	{
-		.compatible = "intel,lgm-sdhci-5.1-sdxc",
-		.data = &intel_lgm_sdxc_data,
-	},
-	/* Generic compatible below here */
-	{
-		.compatible = "arasan,sdhci-8.9a",
-		.data = &sdhci_arasan_generic_data,
-	},
-	{
-		.compatible = "arasan,sdhci-5.1",
-		.data = &sdhci_arasan_generic_data,
-	},
-	{
-		.compatible = "arasan,sdhci-4.9a",
-		.data = &sdhci_arasan_generic_data,
-	},
-	{
-		.compatible = "xlnx,zynqmp-8.9a",
-		.data = &sdhci_arasan_zynqmp_data,
-	},
-	{
-		.compatible = "xlnx,versal-8.9a",
-		.data = &sdhci_arasan_zynqmp_data,
-	},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
-
 /**
  * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
  *
@@ -1160,6 +1083,87 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 				 "clk-phase-mmc-hs400");
 }
 
+static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
+	.pdata = &sdhci_arasan_pdata,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
+	.soc_ctl_map = &rk3399_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
+static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
+	.soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
+static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
+	.soc_ctl_map = &intel_lgm_sdxc_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
+static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
+	.pdata = &sdhci_arasan_zynqmp_pdata,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
+	.pdata = &sdhci_arasan_zynqmp_pdata,
+};
+
+static const struct of_device_id sdhci_arasan_of_match[] = {
+	/* SoC-specific compatible strings w/ soc_ctl_map */
+	{
+		.compatible = "rockchip,rk3399-sdhci-5.1",
+		.data = &sdhci_arasan_rk3399_data,
+	},
+	{
+		.compatible = "intel,lgm-sdhci-5.1-emmc",
+		.data = &intel_lgm_emmc_data,
+	},
+	{
+		.compatible = "intel,lgm-sdhci-5.1-sdxc",
+		.data = &intel_lgm_sdxc_data,
+	},
+	/* Generic compatible below here */
+	{
+		.compatible = "arasan,sdhci-8.9a",
+		.data = &sdhci_arasan_generic_data,
+	},
+	{
+		.compatible = "arasan,sdhci-5.1",
+		.data = &sdhci_arasan_generic_data,
+	},
+	{
+		.compatible = "arasan,sdhci-4.9a",
+		.data = &sdhci_arasan_generic_data,
+	},
+	{
+		.compatible = "xlnx,zynqmp-8.9a",
+		.data = &sdhci_arasan_zynqmp_data,
+	},
+	{
+		.compatible = "xlnx,versal-8.9a",
+		.data = &sdhci_arasan_versal_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
+
 /**
  * sdhci_arasan_register_sdcardclk - Register the sdcardclk for a PHY to use
  *
-- 
2.1.1

