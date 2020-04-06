Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FAFC2BA1E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FB21974
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bRoEN6tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDFRoM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:44:12 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:33816
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbgDFRoM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 13:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SICWbzxi8ylYmkscfQKpEnKaFXmQbXMZb1TxgzdyNzCzxrkLyDAJ3dFZxfSteJJzRDmZ8taW6jWezXM48xYvHvxqp4FMmCXGWukOqqC9baPmkohhPMmJWrlnOdLad8tDOhMckaLvKO4h81667oIL9Zsq9jKVblHTu0lArEycHDGJ8EmF7bRKXHEdezMsYbaZoTl8/B8gkJ7isa1D9CxHaq9uFpV527CUr4tcVSqvS45Hwj3fBrI/3XcS6XWCumqmDTL7sduS/3B/NsiXS12y11EFoZJ4OC7XLiTm8+hSrsgTJmkzbDZbdk5T2lGQY1GqQ7c/0y9slJgTfum/oCZkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeXMnopLbBUufzGWEASrcfq855OXaTcs7mSOVgVhBvw=;
 b=BoSLq9RpL46ltpINHHKPKwPkY/qq59Y2wOeMhtIlu3aQWd6EOOeyVET56L0OnOgAKSz8FDzaWRtMBinEKZKz19r7UfhbWDrPKeSXQA3JaXEuPbBAtVstCORwYZsvFoxf5NCRpstT202vIQbPRXIqXta7QFE5OMc7EKzX5I7QCQvOd64C1iQhu6c3iLtCOOQj/TgztHqEcrD8VG6yv1TFpHfr/bRkZiR3KaNjVmLn7u/rO6mVr26AQZJFPZaBPLXut0UdQ/paG2Nhbw0iDFNo6AA0aeGTo/n6rJemoS7/7t+mIVjwGLPU89ldPgFLBC/LJDR7a+MYX3ASMJdoLW98ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeXMnopLbBUufzGWEASrcfq855OXaTcs7mSOVgVhBvw=;
 b=bRoEN6twvLko4GGjCAfWgMRlqbt8ZDEMaFuTs1a+A0yDmMuA9CAaAY36/JNc/nXXYvcmCxV+JtY90ummEc7e0Z0JMVwxO4Wnmk0UJLIZJBOU8xczAwpvDWdMs88W5jmhlEZdPhCZHGvHsmbGzi5KkfEt4jYBzxrrC/GFZgsFFuk=
Received: from CY4PR21CA0047.namprd21.prod.outlook.com (2603:10b6:903:12b::33)
 by CY4PR02MB2421.namprd02.prod.outlook.com (2603:10b6:903:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Mon, 6 Apr
 2020 17:44:08 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::c8) by CY4PR21CA0047.outlook.office365.com
 (2603:10b6:903:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.9 via Frontend
 Transport; Mon, 6 Apr 2020 17:44:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:44:07
 +0000
Received: from [149.199.38.66] (port=45451 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVmk-0007aI-M3; Mon, 06 Apr 2020 10:43:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVn2-0001a9-8A; Mon, 06 Apr 2020 10:44:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 036Hhr3N017410;
        Mon, 6 Apr 2020 10:43:53 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jLVmr-0001R0-A2; Mon, 06 Apr 2020 10:43:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 25ECB1210BF; Mon,  6 Apr 2020 23:13:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 1/6] dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
Date:   Mon,  6 Apr 2020 23:13:30 +0530
Message-Id: <1586195015-128992-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
References: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(316002)(5660300002)(36756003)(70586007)(107886003)(6666004)(81166006)(70206006)(81156014)(8676002)(478600001)(356004)(6266002)(8936002)(336012)(426003)(2906002)(42186006)(82740400003)(44832011)(2616005)(47076004)(186003)(6636002)(26005)(4326008)(142933001);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb80b1e-3b51-4b10-19a2-08d7da521b61
X-MS-TrafficTypeDiagnostic: CY4PR02MB2421:
X-Microsoft-Antispam-PRVS: <CY4PR02MB24215D74FC840F0847B91F4AC1C20@CY4PR02MB2421.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0wOZgPySDCHA1f6Sq9GUrI36bD3CkTn4s3fyioYCuDpipw/IsFyLm9sXk1H75cbk9vGeBu7ddXLc6rttXNQhcMwh6Mna3zahIBjCY/Z4k1fTIM702pQMauhlQyihkzs9dyADLsj5WvvJ/Vlnlrmk1iOx9f8fwGDym0ogNhqyCSwLXRtDH021LSTfPyo5WlxK4/seziKw1XD1MBbZl/AkPlR4aJ8jFXodALvgJdm8I7om9fUn9Zqg1NbROI+YfSl7cYL1J4LmcGNQu2MieF+g2BDIJLM6+L0P0ufoYC3c0+WGczYfX/btKKSpBcUTx6NEoF+X/nEuwi0n2WndiAQONuo9xXkoyLOTidIn0RDdkDfQi32VWQohC2ZGKPH2HxFSReA9h8GrK4h9cWuCkQEb/9AeCkQWBguFc2BLs3V38D7k7Nntb4AnQZOc9v8bvvgNbszqOV15LcEXS6yCNokdho7S3Q1IqKd1K7xgY1SheNfO6xtVDbXAa7UxVmWM+jflI8P8uXmqGGY9fkW4V8+ip5vDg4ZzSS0tX5ajp6yJck=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:44:07.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb80b1e-3b51-4b10-19a2-08d7da521b61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2421
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for 'xlnx,versal-8.9a' SDHCI controller followed by
example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 428685e..630fe70 100644
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
2.1.1

