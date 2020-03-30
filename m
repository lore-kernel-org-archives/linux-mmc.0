Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C5C43331
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1132F20786
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 05:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Lvnre4Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgC3Flw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:41:52 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:6041
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbgC3Flw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Mar 2020 01:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijfyynB4kZWVuMMcsT5Azq5D77pRFOE9FiVOi20du9jdjUPzpjlDTAIgTZ8Rtr4Iv7nMKY51QWrRBsI3tstFSigW46Hy44+zWi+Nbnt6mnnZOUcwRIfvOtJI0NrRpls45lpWnt86sqKk5i+mWgvLCxDEyxHkyEdQ5TAmpiJbS1QpJ1LgxXNVZnQO+GRC2W5/UaoRn3qgQ8e2W9TGnvl9A5PDtL0VbCeAsuSNebzoy12YcixWBXkWRyBCrkSYA9/ddgsiHr6VagabYhk1IusjReY/ROdt6eW8iFAPY6KCifdmDu4ZVWgZknAM47f0OX34IZT7xc0+/6Kj2zOGNWfmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEdBKRucfupAhW/34/J+1/Qe4wKbYKRn5Z+iT6ZNhJ8=;
 b=ZhXqQPL/ggF220eiaG8eIXifYq0tju0qNv2ZgiuqA+uRzvrihYxiIcbE7LDpI1jBx9XLiiI0ZpnQ577+quGpPs6fniJDpZQVrEFVu1ov+yijwThIHxjEzUAse0D37qSMj1Ci/kASPvLT8HwnOFhJ5myI2LjqfWWBZMAnQBtql1G5G68A7pChvj/MPs7sMsDThkm/F5RJUI09sBBA950WwYFv2VQBl3spz8wwKv/u+fNaLuYQmK4Dt6C9kykOk5W+DM+x/KhTvM1W+yyClciISUB1PPgnTIMB4hj1BMHX08McD+MYbqz+T93OfGF+25qPJp0RChSUDy8ujGBvKo6JjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEdBKRucfupAhW/34/J+1/Qe4wKbYKRn5Z+iT6ZNhJ8=;
 b=Lvnre4Q29i+w3BEwevrc13ppC5uySm353IMA4ARebFwYTjsolbc1TgpoZP76jTjEAFksE5N9lrhmlYMl93EB0d9UQjW7mfPmkQXPFYP/2sXjaA9hY8KZdsJPwWlLqVTacxn5R7XQONAh6+t2fkNA+QZXynj6kyzgGJuztfUJ5/Y=
Received: from CY4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:903:18::29)
 by DM6PR02MB5498.namprd02.prod.outlook.com (2603:10b6:5:7d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 05:41:49 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::7b) by CY4PR02CA0019.outlook.office365.com
 (2603:10b6:903:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 05:41:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 05:41:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInBE-0005gy-MX; Sun, 29 Mar 2020 22:41:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jInB9-0003I4-JK; Sun, 29 Mar 2020 22:41:43 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jInB2-0003GK-6w; Sun, 29 Mar 2020 22:41:36 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B2878121267; Mon, 30 Mar 2020 11:11:24 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 1/4] dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
Date:   Mon, 30 Mar 2020 11:11:16 +0530
Message-Id: <1585546879-91037-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
References: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(396003)(39850400004)(346002)(46966005)(356004)(478600001)(2906002)(4326008)(2616005)(8936002)(82740400003)(426003)(5660300002)(47076004)(42186006)(26005)(70206006)(336012)(6666004)(70586007)(44832011)(6266002)(8676002)(81156014)(186003)(316002)(107886003)(6636002)(81166006)(36756003)(142933001);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1467ff4-32e6-4f05-d84a-08d7d46d0ab7
X-MS-TrafficTypeDiagnostic: DM6PR02MB5498:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5498B1CAF0B1C46CAEC8269BC1CB0@DM6PR02MB5498.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL98bvVW9G6PHfvmigQ73T31+LSkbECnNhPOZcMZRIXTA5w2rTWiPfQrtFvwQ69+K0+jMVWVhXZJS6sIMY6s951UJN/Y4wkdxe8Rl520PylVbTj+74iGCoHS+m3z5XQGhmNplB6LIWeftdVIvRZMajeGsMzYoq2nPGlZgip5VOB0Yg4PsLI2y1NSIEUswshjrMWiqWcjHXdKiF3XTB7Ym6DQTVaQht1DbVCsMA/ZKwrS4E3rDzuN1a6i4f6e4k3urBVDoCF1S/GgWjAVTSjm49sxKI6XM7bU7PVjj8aRwqHnzFRIPiIo8WSa3fULSetUTbZJ5M9tt7FbY27q98nvBH0gN6Xuh4SFL3u58oS8KDgxSFNhTCU5cgDvsUEB5QUq16pkM/xnUDlHtR2sPD4sRenLpiv6JlOgnCMlrCF/Eq78ltdk9JeY9OOqMaAUZq2zjQV28LiyplLm02u7qjn5HdRjx+8gtWHcMk8qBiII/xNZBVAoIcSxr5Vq1F7crbtTd66DRT2bzPu7KM0VeEigxA4Ctp8j8DX5IjxcDtgIqTg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 05:41:49.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1467ff4-32e6-4f05-d84a-08d7d46d0ab7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5498
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for 'xlnx,versal-8.9a' SDHCI controller followed by
example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 428685eb2ded..630fe707f5c4 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -18,6 +18,9 @@ Required Properties:
     - "xlnx,zynqmp-8.9a": ZynqMP SDHCI 8.9a PHY
       For this device it is strongly suggested to include clock-output-names and
       #clock-cells.
+    - "xlnx,versal-8.9a": Versal SDHCI 8.9a PHY
+      For this device it is strongly suggested to include clock-output-names and
+      #clock-cells.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
 	Note: This binding has been deprecated and moved to [5].
     - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
@@ -104,6 +107,18 @@ Example:
 		clk-phase-sd-hs = <63>, <72>;
 	};
 
+	sdhci: mmc@f1040000 {
+		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
+		interrupt-parent = <&gic>;
+		interrupts = <0 126 4>;
+		reg = <0x0 0xf1040000 0x0 0x10000>;
+		clocks = <&clk200>, <&clk200>;
+		clock-names = "clk_xin", "clk_ahb";
+		clock-output-names = "clk_out_sd0", "clk_in_sd0";
+		#clock-cells = <1>;
+		clk-phase-sd-hs = <132>, <60>;
+	};
+
 	emmc: sdhci@ec700000 {
 		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
 		reg = <0xec700000 0x300>;
-- 
2.17.1

