Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B7C48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AB2613DB
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFOKqU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:46:20 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:10977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231428AbhFOKqU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGxjQGA7i5Weo5Zzj7q4wOQnG5OOLlVqASFI/bVNmV60vCEtz1/WPNtJ0wDoCKRpS46Q0gBw20TeFKuo89wOEYQCg0oxPK/oFyzD20StXaDg8ZLvPBV9q/vzynY+ajbxGTdcWXycOrhfkI974k2LU3zCwWmjfxM4D5tx5HyKOZQT2KXONic5qTo7F847kn7CPNZgweTnb6nQDWn9fnmRJv3g7hQdnhCjMhKGBSUQ+AQgYse7gDy1Oii51uAuUuKHCPdBGPqaAEwtnAvo24YgBTv86YXmd8vFA3GxZ1VdZbQzMly+MfBqJnhvNGLBpvYExAPyNfLTs1a03NsD5T5jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPodYLyE7QHxmOGn50ccFh3gkdAT9OvB74QHdvxjwe0=;
 b=QEFEIoVd6NAWWLPnFXSIfwxGciNpxfuQPtMcXjoP64uHMb3SY9yWnTrxZ4My9AiuM/9AF3tNDXQjlUNfnQB8FcDzf738PoDYi29RznxgOXrQPWGBJHcUc8NCMLsfeHwAItzVIJzv1pxmatVFpx6eCjUESihR/ZfH9GNNBrtxhp5CfzTsczYfegm4qs4dnqCXxxUKQ7IMZIcjeLXtcQHYwFXHosX6Aet1vCObWlqUZljlNL8y6YZm2xTXkCJ0evFsObMucg9fwSG8cTW+RfTcznJRgzIKeBdcqELjTKeJbsXWTMotGiHdPHxx/rUA/JcrtGHntLwzSQsfne57kw+1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPodYLyE7QHxmOGn50ccFh3gkdAT9OvB74QHdvxjwe0=;
 b=if0sPTVf2hv6lCRIC9oQBG0UWnUk3Q208ityzq816P4j0NuL4Ia1wuRGNVis3BkBgvhqIDWFzPk9thxqxf/hBcLB7HrweHIOVJYF6YNOGJIyCyWCPhNDFNi0RzaMlEvrpwosg8fo2bvZb1BQ+4zYbtrPIepZuSfTVeofjO5vqXg=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 10:44:14 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::1a) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 15 Jun 2021 10:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:44:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:44:13 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:44:13 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49375 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6YH-0002VS-Kw; Tue, 15 Jun 2021 03:44:13 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BFA051210FA; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/7] mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
Date:   Tue, 15 Jun 2021 16:13:51 +0530
Message-ID: <1623753837-21035-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edad6ffe-cd45-4162-f38a-08d92fea849d
X-MS-TrafficTypeDiagnostic: CO6PR02MB7842:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7842A4D7FCBFBAEA6DC9998AC1309@CO6PR02MB7842.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gtn3zVAetad9xpdBfh7fL/xNFDLoTmv/OPECNUcwmSWLu8DMVc6varOGeNIpt1H7024Ezqhoac8DmHcjD+5Ye1FbYAKqu975ee21+vw/brJ0D9YqN7Ufmm3kXTqBESAlEL5Cl05hfMX7PRJkJrE0lP3zJoFlbQjjcwSJeTSf0998b4JSpup9PiYaHPJE10EIRI0vnFzyhWHcj2c2ELinVGJQmHs6q6Mx6Av8yI9RYblvk7ZFsNYti0lJk1o7lUQqcZIqpvpap3dvJjF7Xxb1ET1dcz3e9hKCw44jmH3SnuHRS1m8lw2//YrwtQOAw14CD1vIp/9779e8pAw5Bnc539osq7j5dtThGt4HDfjNFs5IrHnCuyG0d9si1z9gr1MFGh7xiafJXURlW61GnA7Yn6u87P1cILWBFKBmE9QaDAix1zIfL2pQdeBcKa4s8WYClCedviKGkETsYsxx0BMwK47soNogHXLwhJnyzmpbx1qTnpYaOOKSLUadVLdA4IhKnShy8u1oD9p/jeX6c8jTrh9QGCw+Rxm9vzN9GZJu50RYSdKRIn60EZAV9NBxYDIZb8zktLU2WTbLkDy+fVwqXDmtSsQaBEV9yesN7Fo/YtQzDUU8fZ5uERTq+0WwmiUCcLTilFdCxprHAaA1L7r+yyT0gdU6Mpkdkmt6JNsA2DeY+gMInF+uxnA6l6/e949t
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(346002)(376002)(36840700001)(46966006)(2616005)(5660300002)(8676002)(8936002)(70206006)(70586007)(26005)(47076005)(2906002)(36860700001)(110136005)(36906005)(478600001)(316002)(83380400001)(6266002)(336012)(107886003)(54906003)(426003)(82740400003)(36756003)(186003)(82310400003)(42186006)(356005)(4326008)(6666004)(44832011)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:44:14.2532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edad6ffe-cd45-4162-f38a-08d92fea849d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SD standard speed timing was met only at 19MHz and not 25 MHz, that's
why changing driver to 19MHz. The reason for this is when a level shifter
is used on the board, timing was met for standard speed only at 19MHz.
Since this level shifter is commonly required for high speed modes,
the driver is modified to use standard speed of 19Mhz.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 839965f..fc3e41c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -159,6 +159,12 @@ struct sdhci_arasan_data {
 /* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
  * internal clock even when the clock isn't stable */
 #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
+/*
+ * Some of the Arasan variations might not have timing requirements
+ * met at 25MHz for Default Speed mode, those controllers work at
+ * 19MHz instead
+ */
+#define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
 };
 
 struct sdhci_arasan_of_data {
@@ -290,6 +296,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 		sdhci_arasan->is_phy_on = false;
 	}
 
+	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN) {
+		/*
+		 * Some of the Arasan variations might not have timing
+		 * requirements met at 25MHz for Default Speed mode,
+		 * those controllers work at 19MHz instead.
+		 */
+		if (clock == DEFAULT_SPEED_MAX_DTR)
+			clock = (DEFAULT_SPEED_MAX_DTR * 19) / 25;
+	}
+
 	/* Set the Input and Output Clock Phase Delays */
 	if (clk_data->set_clk_delays)
 		clk_data->set_clk_delays(host);
@@ -1598,6 +1614,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
 		host->mmc_host_ops.execute_tuning =
 			arasan_zynqmp_execute_tuning;
+
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN;
 	}
 
 	arasan_dt_parse_clk_phases(dev, &sdhci_arasan->clk_data);
-- 
2.1.1

