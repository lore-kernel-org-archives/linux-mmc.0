Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F9C48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DD56137D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFOKr0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:47:26 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:54496
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231469AbhFOKr0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7c8N4Hz693aQQUyQaXmx+ceYq7kOnIiaTdolWbrtF47yH/EV05cikTvA+Ban3nsKsk2q7Uy51vK8TooA4CP7aMnV7bazHpDVERDcbfgwtg3ycd1DFjoTz0P3JVaXqyeDAL47ll7TNZuh4AnBnFVpc/gqHrRPxaxZTKyFeNWMEUNhHqHYqQ1V4XGAVnVVGTAHGQuQPfow4y+G6Hzxqgk1rBOyVwNdFFbj6N6UmQ8RBNlDoL7PIeBc3GumFjVE4yKyc+rr4whtVnRpADkBpVamUXqI3SLEiUxLRWKZteXcmUNpKo9Q0wiyjzXGFhZIvg9ED4a8VNZZGy4HTs2b/wkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVRakVuvA3WMUnZPLkvHCaj9dbsH9q41SKzsTcvxp2Y=;
 b=lxLpqjUjZ5N0USLbQIeE/wqT+3fuPX4GZjN4akhuoP9MbsM0Iy//mOPgdnbbvwey7PXs/2BVMRXKNocdHfAUZfT2SDilGeVhlLw4AkFmTfUzYZ8gWSj9cOrdeEXxHrNm2WLklVfkYioxLS/sGzg0hxpw2EMO58VD80cVHCkjy+iknMyxZWqxfDf+8CaTvjZkLlx5l+KHlBG2FfRuX7mUmwxB38//niyO3prkULpEiBAlgXpmkc+ehPMKzA2X//EDMHsDIhJvI8IRo+uQXdgtt1NyUonCgxBzaMX9IJrADstNzGE9a+NVcdYEfqGR1/WH3axb2ivx7QXYibRBWnO04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVRakVuvA3WMUnZPLkvHCaj9dbsH9q41SKzsTcvxp2Y=;
 b=T6GJZK4/l0cVmYx0v8G2qfOVvi3TYGA2u6tSQDg0x8XpBA6YCbXjqeZLe6l42S74vr7tKjGMImwFhUXdriidjENrIx8Z68H9XETYPHERR4akp0bO21cXTnfAi4FqugcbFj9RR5e6OOjxujySErwK10fqDF8u+GKWA1w3JK33G5Q=
Received: from DM5PR18CA0057.namprd18.prod.outlook.com (2603:10b6:3:22::19) by
 CY4PR02MB2247.namprd02.prod.outlook.com (2603:10b6:903:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Tue, 15 Jun 2021 10:45:20 +0000
Received: from DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::20) by DM5PR18CA0057.outlook.office365.com
 (2603:10b6:3:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 15 Jun 2021 10:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT060.mail.protection.outlook.com (10.13.4.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:45:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:45:19 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:45:19 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49399 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6ZL-0008Sa-52; Tue, 15 Jun 2021 03:45:19 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id DBC2B1222CA; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 6/7] mmc: host: sdhci-of-arasan: Modify data type of the clk_phase array
Date:   Tue, 15 Jun 2021 16:13:56 +0530
Message-ID: <1623753837-21035-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4316f451-e205-48c9-db07-08d92feaac0d
X-MS-TrafficTypeDiagnostic: CY4PR02MB2247:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2247C245C4790B27ACBFFD2EC1309@CY4PR02MB2247.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ak0vKjV7B4As4Xp4mz30h+zeGldIO86NtEt1J4tI+L1zlIVUNTo+VAG8wxtdOGRGk+yR9mTsZ83Pt8ftEJ1LuUl2L6X0DrLmoU+TYaK2/8oY1SlMuNjiwfWEYoq9Cv9OfMPaQo23rblg6ePul4DraNpf7fxG4D6VQe5DVr2WnDOStHB0+Mr+HD4v9QHK/1LGVv5h69XntAwRmVJ/qPUNfFPDwEqXpyORrGJhUWIFcLjW738kA6ys49ayonyFP/qf1yRN2DmKf1jt2wRvYe/blJ63ewb7aKCcNqwQh1O/XdlHGQ1GaKXrBqKrSFX8AyuPw6WLrl2fVQk25LEoNy+A2XDi2+AwzAoVpJp6WVGtJKMfBqc882LXflPvfHOHPoorhskLjmexYdtDkwd5K3Q0IiSlNMNaFsHj93H5YVIorjPAAMNc9FaQR0JE9KkoL8SMRn1r/UKckJWU+YWeNUVOETGZmlxjzNiAZLh+amfcM/hPGtRx5o0J5XKEV8QOXQjNGor8kJiAAJ+HjTeghKcg9nwV0d7+GAW0Ub5OSjd56PcwTUws0bRrjh+YlihVwhSWraf3OriXnYifctX+87UvEzQbwWnVmLWbzE2UxFTdm0bLzGMPysVzWP7YQjL3GfGFCVfMeK4k/FnfdtkopfiJzsuWEuNgbftc3H95mv5eBYOfz0wSKTdI45QcoTMiy4rl
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(36840700001)(46966006)(83380400001)(82310400003)(8936002)(8676002)(478600001)(47076005)(54906003)(107886003)(2616005)(82740400003)(70206006)(44832011)(5660300002)(186003)(70586007)(2906002)(426003)(36860700001)(36906005)(316002)(110136005)(7636003)(36756003)(4326008)(6666004)(4744005)(356005)(42186006)(26005)(336012)(6266002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:45:20.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4316f451-e205-48c9-db07-08d92feaac0d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2247
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Modify the data type of the clk_phase array to u32 to make it compatible
with the argument requirement of "of_property_read_variable_u32_array".

Addresses-coverity: ("incompatible_param")
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 510d8fc..61fe13c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1018,7 +1018,7 @@ static void arasan_dt_read_clk_phase(struct device *dev,
 {
 	struct device_node *np = dev->of_node;
 
-	int clk_phase[2] = {0};
+	u32 clk_phase[2] = {0};
 
 	/*
 	 * Read Tap Delay values from DT, if the DT does not contain the
-- 
2.1.1

