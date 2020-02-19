Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25673C34047
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65CE24656
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ca0p3Gmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBSM3U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:29:20 -0500
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:29588
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSM3T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 07:29:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAACbgnkJw7QxCWpc9hlq+t0rvEaeH5K1chPLMOljng9prD9WQgYlGnSG1/FT8lUB7UwZa9c447k+6NyYsZoOU0MBbUa5IdxGYm0mdJan2LrUE3y15ZRAAQB39hYjPOx+Jo0jfXFeCy+yQt9x5X6ALCpT5PTlA38tKt3YlBDGrTSOHbHBnhH3qM2v6FMJxdulkRAuxQZohRpAUCnbpznJsp7xrkUUKn4xxTCOtt5yxRA1GsTAV4q0lDNG1dccGYjGKJVMKmdzRlZL8eBc6gOPNKh1tv+T5KWoDI+UUcGCopuLXOE87YvUw0l7cC/xoMHvljZJHiYXEfte4DFgB310g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5iT5czNjmdxK/eOshTn6bH/JruqwN47BJdQ77kgMoM=;
 b=TU4XC9PveW2kyP2KgePLYsLat7BUQyo+eu2/8/YPW2OpJulQa8ZO8AdkmQ5EaGqBfjd/JyS4fJ8qNaEF//d7LUVChe5Vq232/0q6llDki4ziP5mWl83k5Z3oKo9gVl2NEWSgn4Y2NJMObWfDEHCqGXrpJWSx1IIp1NGQPAlw8A9lSc2v1eeZBrKymX4bdaQOwVV047AY7E+/kJ2iqFERMn++igBnIY8E+wNgrhkljPXvCFdhrAOTGF83bWytSpPndVUsWNrSp6i1LfEovr8HQYOKmRYB5V3s1/0jzIyP4yJXbL1BUcUo39Q/i431QYicFGihTL3/Hsh8DZz++hRLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5iT5czNjmdxK/eOshTn6bH/JruqwN47BJdQ77kgMoM=;
 b=Ca0p3Gmf+/tYy0vmRiEBBCKJtzGjDUgI7UpNXhTWNgARJ/ehpvzIJ/mbxEwhOWdKXFCeSzmy4hpB2BvzIEQIQq9dEEk9DbLIPaObcbUdSAw3IQR+kYTvL+f9KxDSUBYLiKGOvThJRuguQbwN2L59H0dBfD6kuBWK9bUsZc84afs=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by DM6PR02MB6794.namprd02.prod.outlook.com
 (2603:10b6:5:214::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Wed, 19 Feb
 2020 12:29:17 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31 via Frontend
 Transport; Wed, 19 Feb 2020 12:29:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 19 Feb 2020 12:29:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OTc-0006cO-3X; Wed, 19 Feb 2020 04:29:16 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1j4OTX-0006DV-0D; Wed, 19 Feb 2020 04:29:11 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01JCT5rg016838;
        Wed, 19 Feb 2020 04:29:05 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1j4OTR-0006Cc-Ev; Wed, 19 Feb 2020 04:29:05 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 496601211EB; Wed, 19 Feb 2020 17:58:38 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
Date:   Wed, 19 Feb 2020 17:58:32 +0530
Message-Id: <1582115313-115667-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
References: <1582115313-115667-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(6266002)(186003)(4326008)(44832011)(26005)(2616005)(70206006)(70586007)(107886003)(356004)(6666004)(36756003)(8936002)(336012)(478600001)(2906002)(81166006)(5660300002)(81156014)(8676002)(426003)(42186006)(316002)(142933001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6794;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a7dd8f-5662-47c3-204f-08d7b537561e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6794:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6794DD77A82DF154B0EDCCA9C1100@DM6PR02MB6794.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjZ3V6hw248YPEja0/F7H+cNIQMeh+rZZK/ouXn82UvqNT7nO1zULEJJX565/nLB0fIhbklz2Z1dSJderb4i92HUXDXcUSUfHjAj5GU1tghICCjYkXwjPx0kqNwT7vF5yKDYLe8magJfVYRfaBxM88aJYm0LjpMHPx4h9HrPPnz9w//LwnaUsCZgO0bOQ81XY1LCAtoWOV+5CldTGZBKQkSsELi1ZRtRNZ4N2LPcCVO8Y2AFeEoySBJXYJcmC+vRa1bds+wzvxF009QRL/78BvArw15AMDhNj2HZ4ccVdpFmyNnNKVDrKYeqFhG6rowiZp9Ee6JPt4dJLQrj7J0h9cJ7rBbibCegiAYJDcnySuOZErlUtbVbA8USd7qWfax6/OvcseBMb/GxB6xCb4lNLuv7v3/O83jzDUgeKBv/8u656N/g9O7xSq8rqCAuZpCfzJ2BWep/HkCXJL4/z/tVU3GCq+GF/evVM3+/Lun4HkTAovE2SkpZAVzTWwIKyganx/AC68y7vMcjB+YKDt/opA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 12:29:16.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a7dd8f-5662-47c3-204f-08d7b537561e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for 'xlnx,versal-8.9a' SDHCI controller followed by
example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
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

