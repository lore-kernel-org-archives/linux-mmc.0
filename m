Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8FEC2BA17
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304FA206F8
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Wn6YlvRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgDFRpK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:45:10 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:50669
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727922AbgDFRpK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 13:45:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghECAGcoj6uXObkpyibByDNUsqLR7z0ihtVKlJctBnKEXeCnrb5IKokC+rW+EgkbhgW69x5SrlR4IfytabPFlBSaswgGN3WFmIppBTbAbqnT46ngZSCozjBSm5WL7eNuO8BGFOK1TzRrBNAC6iqyXZ2neoNvwV1sDaP5PPLpSbLMkJhQKRLBJt1/nG0YXtfojYIUIrWhq1t54BBy8/cdM3bBqS/AMbQF7nI8Y/ihxu/wvFR+MVrQBqTm/0Ex9QZnCoLPWstFMB3CU8ldLM7ZnbCGBdhcVmaGNo8SmMABZ5lvYkBCmHrMVDrgWrosvRnI30vSUxczf1efSbzhbuMgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn32ffDIsSfZKt885YQqYFdCOzb25fzxsgWQSNVQU6I=;
 b=U274sabF1zj9YbsQ/5MhDhUX98KLBM3y9iUYUW3aur0U+0qclp/N/MDtCgkaoBLvqSVoTr1TaUMyPHlpgmK1Ke/FdaXxrE2Di5e09jOgg5OEv2Db9X0Sk3VWajbMZHTYLnHDstEmLTRWQCt86ikxmdcxdGb5try8G37yi+GtDWv81ihg1ivO4SaIDNhv5b0As42G/O9+B+utD+FTDDCH2sRhabAayw7mEJoh2S3tyN40s+GKGHLSVfjNSmT9v07TPSpUrBFinyRTf9BaQCZmSvDE6PnfWdFyj4ojK+X7aDO4PutBxYowgteOGxHK4/4pNFLuk0tJTVOFTO9o+UTcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn32ffDIsSfZKt885YQqYFdCOzb25fzxsgWQSNVQU6I=;
 b=Wn6YlvRVh6vQpUGV7Cwn0903qITGq1V1VoDtsnWsDoiKpZ9+lu1vilFdD2u+f29CQLNbcNWPv97gmCDKVwnFGwTOvedjQqCe1xGgw5ZOiv+/P34whkf1uN57ImRYyJeiqDY3a5FhHxVk6FqS4FSgGVA94i1KpfMaxTmxsg2tv30=
Received: from CY4PR13CA0093.namprd13.prod.outlook.com (2603:10b6:903:152::31)
 by CH2PR02MB6309.namprd02.prod.outlook.com (2603:10b6:610:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 17:44:55 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:152:cafe::40) by CY4PR13CA0093.outlook.office365.com
 (2603:10b6:903:152::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend
 Transport; Mon, 6 Apr 2020 17:44:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:44:55
 +0000
Received: from [149.199.38.66] (port=46484 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVnZ-0007bK-9Y; Mon, 06 Apr 2020 10:44:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVnq-0001li-Rd; Mon, 06 Apr 2020 10:44:54 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 036HilLH018161;
        Mon, 6 Apr 2020 10:44:47 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jLVni-0001kH-Tf; Mon, 06 Apr 2020 10:44:47 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3C09C121242; Mon,  6 Apr 2020 23:13:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 5/6] mmc: sdhci-of-arasan: Modify clock operations handling
Date:   Mon,  6 Apr 2020 23:13:34 +0530
Message-Id: <1586195015-128992-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
References: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(70586007)(2616005)(70206006)(36756003)(44832011)(426003)(336012)(478600001)(5660300002)(2906002)(8936002)(82740400003)(4326008)(316002)(47076004)(186003)(6666004)(42186006)(6636002)(81156014)(356004)(26005)(81166006)(6266002)(107886003)(8676002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ceedec-08bc-4cdb-81af-08d7da5237a2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6309:
X-Microsoft-Antispam-PRVS: <CH2PR02MB63090BE24FB0BB8556077AB5C1C20@CH2PR02MB6309.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwF5Pavmw0EYvwsCgB+rBZtXHAPdgVACpZjcvm528CYEEGddiXK4I3zTd1OS4zPEsqPfxpRcs7V0iXid1GF5ISuQXmwUzgQlsFmmMHORxIQ/eoUtlPh7pWOyZ6AJqffyThzub163Q5n+eWT1tQlHRrV4sGImiRA3G/baj9ualeN8Pa9buSCSbJg0io3r/t1FTE+ZRlJvXNTF4hIbHLwlsFWXbyk19OnW9+bsUOI55nLyKTarQN5G0pRSV5AzucAoahNVBMZ9dVT3Z+NF1OiUgIYCmyAMXBsdWsixUdkqfrWBJlhiZ+9g1qxCGRRTAbDap+I6Xt5Lr1lhsDTtjkRF3AJ1myAO7BubqzSMkwhdYIW6i1t1YR+hIwQMtn2KWS/SsByym93t1t1bUQ1pJArt03a4B7m0HEv/+Q7w11dXV7C1gGqVwHaO67VG2jpTtNy6wV9DUmDq+pdwWTfTlRyls47icULNQXbixEZZ85cu7W8htUWp5aBjTcG9bnV1ZKhz4BlCjHVD2om5htS0vYctVw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:44:55.1665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ceedec-08bc-4cdb-81af-08d7da5237a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6309
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI clock operations are platform specific. So it better to define
them separately for particular platform. This will prevent multiple
if..else conditions and will make it easy for user to add their own
clock operations handlers.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 50 +++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index bff726a..60ad159 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -88,6 +88,17 @@ struct sdhci_arasan_soc_ctl_map {
 };
 
 /**
+ * struct sdhci_arasan_clk_ops - Clock Operations for Arasan SD controller
+ *
+ * @sdcardclk_ops:	The output clock related operations
+ * @sampleclk_ops:	The sample clock related operations
+ */
+struct sdhci_arasan_clk_ops {
+	const struct clk_ops *sdcardclk_ops;
+	const struct clk_ops *sampleclk_ops;
+};
+
+/**
  * struct sdhci_arasan_clk_data
  * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
  * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
@@ -120,6 +131,7 @@ struct sdhci_arasan_zynqmp_clk_data {
  * @phy:		Pointer to the generic phy
  * @is_phy_on:		True if the PHY is on; false if not.
  * @clk_data:		Struct for the Arasan Controller Clock Data.
+ * @clk_ops:		Struct for the Arasan Controller Clock Operations.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
  */
@@ -131,6 +143,7 @@ struct sdhci_arasan_data {
 
 	bool		has_cqe;
 	struct sdhci_arasan_clk_data clk_data;
+	const struct sdhci_arasan_clk_ops *clk_ops;
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
@@ -146,6 +159,7 @@ struct sdhci_arasan_data {
 struct sdhci_arasan_of_data {
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	const struct sdhci_pltfm_data *pdata;
+	const struct sdhci_arasan_clk_ops *clk_ops;
 };
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
@@ -1091,23 +1105,32 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
+static const struct sdhci_arasan_clk_ops arasan_clk_ops = {
+	.sdcardclk_ops = &arasan_sdcardclk_ops,
+	.sampleclk_ops = &arasan_sampleclk_ops,
+};
+
 static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.pdata = &sdhci_arasan_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
 	.soc_ctl_map = &rk3399_soc_ctl_map,
 	.pdata = &sdhci_arasan_cqe_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
 	.soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
 	.pdata = &sdhci_arasan_cqe_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
 	.soc_ctl_map = &intel_lgm_sdxc_soc_ctl_map,
 	.pdata = &sdhci_arasan_cqe_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
@@ -1117,12 +1140,24 @@ static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
+static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
+	.sdcardclk_ops = &zynqmp_sdcardclk_ops,
+	.sampleclk_ops = &zynqmp_sampleclk_ops,
+};
+
 static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
+	.clk_ops = &zynqmp_clk_ops,
+};
+
+static const struct sdhci_arasan_clk_ops versal_clk_ops = {
+	.sdcardclk_ops = &versal_sdcardclk_ops,
+	.sampleclk_ops = &versal_sampleclk_ops,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
+	.clk_ops = &versal_clk_ops,
 };
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
@@ -1198,12 +1233,7 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.parent_names = &parent_clk_name;
 	sdcardclk_init.num_parents = 1;
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
-	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
-		sdcardclk_init.ops = &zynqmp_sdcardclk_ops;
-	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
-		sdcardclk_init.ops = &versal_sdcardclk_ops;
-	else
-		sdcardclk_init.ops = &arasan_sdcardclk_ops;
+	sdcardclk_init.ops = sdhci_arasan->clk_ops->sdcardclk_ops;
 
 	clk_data->sdcardclk_hw.init = &sdcardclk_init;
 	clk_data->sdcardclk =
@@ -1252,12 +1282,7 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 	sampleclk_init.parent_names = &parent_clk_name;
 	sampleclk_init.num_parents = 1;
 	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
-	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
-		sampleclk_init.ops = &zynqmp_sampleclk_ops;
-	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
-		sampleclk_init.ops = &versal_sampleclk_ops;
-	else
-		sampleclk_init.ops = &arasan_sampleclk_ops;
+	sampleclk_init.ops = sdhci_arasan->clk_ops->sampleclk_ops;
 
 	clk_data->sampleclk_hw.init = &sampleclk_init;
 	clk_data->sampleclk =
@@ -1405,6 +1430,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan->host = host;
 
 	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
+	sdhci_arasan->clk_ops = data->clk_ops;
 
 	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
 	if (node) {
-- 
2.1.1

