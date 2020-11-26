Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7879C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904EC206B7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJjJ9pBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbgKZLR7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:59 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:56710
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbgKZLR7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQabaR7mqB9uA0QOLY52v0bJFbPGjlxOLwr5nqA6TvOxuiptOgKAuwZwQ1KYDzl+NqlgOPe2Nm1GtM2bFLa+rqAvKraRQFlDI8Nte37yohr6b0vU47zU34I/zCSiUrN8ZxAs+8MJc6eI11xFjC5i/2ymycnMVfPaIW6BavUKvGywJIxAWSZnF9+C9PaXORd2GTYvqonovPYiWn9IERkHSZZtbEGtzo2xTy6tKcAXFMgB9o8Kt5Yf0TLRLxS/WWmbETL58OMTAoDNSAMMxLl+8nPtGP5eo/aoW/G4CoOqBnKT2awTKSUwqN+VDw4eu/Zozg/azEQdYj5eoKEPPxnbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQAwr9eZBjVM9e2BjVNF3kEQVvoiL6/+vAjn15Lov+M=;
 b=k0Sg75rSPk+o7jJoowpwq+8LyoxOsHA3rsD0qXnJDRo31UTIKIBOxAKWXV7B2rsXiK8g88wtTOdEPr8oUWgZqcxiSogCOVbtDT794Zr43sbtpknjhM+fe9jIg9HlSoADu3IxrxuDLZBvjjXByAO3Khka4g86+amo8KXd2hGrH0flKFz7kBCeLjxsRQ7tH6muNUT4jaAW3Ls6/xyjs06vSZjqZmcFoV/mgfGYCd1ZQ6gdT4+mv2fGQiEvdNNhMGN9GA2b1iOpImh1jsExUmrklt6ibh9UMHqfteBfxA+qGHbPNIvhXdvkOc91QMId3VNPknxzSi+JJIA96QS6PA7Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQAwr9eZBjVM9e2BjVNF3kEQVvoiL6/+vAjn15Lov+M=;
 b=nJjJ9pBYyM9rZtbyrIywYV1SdsBmHJolhYkwM8O0JQxgchrFIZrRIVrN8dQ2Pf4tsSUqf4OWkjHCiS/sHzcde09xRQ0JQRKpj2EQbqP1zejOJs+bhmy87CYFSgTWAh7uVFrcJlo3ALOsaj6lJvh0iw54vPZkYQeoVdi5aPwdPVg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:17:06 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:17:06 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 16/18] arm64: dts: imx: add imx8qm common dts file
Date:   Thu, 26 Nov 2020 18:58:58 +0800
Message-Id: <20201126105900.26658-17-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201126105900.26658-1-aisheng.dong@nxp.com>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0160.apcprd03.prod.outlook.com
 (2603:1096:4:c9::15) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e592f56-06b6-4459-947d-08d891fcceef
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB52069F21B27072C374C669F980F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMhIc3Ys22Xc+wg8fWMCSFiX4GzRpeLaOshN4Surp0iG/7Km6X1+Yg7ht6+fvvp9y6rZstsSP82zF/7gCoB2/GMWG5komYY1h6ti8VXZgompn1feB0k5+7Rgji5DHq/2w/igWkH/hq5YOq/LEyWeP4hvgqghQzjgTOa+SroCOWQNV0MkOMzO2XwM1b2h2lQn5R3jWYHN2C5ETSrTTKp6BZIIBzZkeyOPQu0h1vFXBv08jWIE2GVJh1fT8ILP0VFS5oILeeBsRMI+oOQlJ5VpBPhGMfNyxpys7667aBRSaYalnuDv4fQYlWJK0qpJMVTPv0k8daYMIcFLick2B/L/E7z4hP+c6Ubqo9A9PFwqtewcncRJsnaSrxp1UXsWb86w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: taTFUYdv9cEQYN0mt/WDnd9ajONVKrV6r8lFmQkQewCkyw14O/2AaGQpjjoaQSlXKzTu2AKqJIlYXxQoxxMR+Ewil2PxAZMCMuoscjtgMpFaM7R8akgIsyddHBil/k/N0QJymwExrZiSqpFEYHlD4VfmRgyIWY6PniedFooProJCDrp7BLkwk+51/wBP0PRrWV8OHO8wv3p+E5HPxOSO41T1s1xm7X7twdz/T/VFgFlyvLsYavfo1XRaJXrrMCWSUW5qB+MMCQXiRnTNOa5zkKhnxrO6DL0hhHoEiZ9xPggllaD+PPi6jWYDHLlERxVc5hZgFYQq4qS4fv10i1QzeAimNwUj9nfg+Zwfk5mFuENgGzCfRIFT4FI9RCQnV8bfmJr6AQLd67+CTdY09DGW/eofwbWLGz2xgH6sVzJYYo5tUXnojlNz8brsYLwZGgtowo8kb172AHE7CjBYrS5Oh9DGo2BKb9xV2m95aZXq0qe4CTW+JkybWTrCUfreYlD4/YWqvWCQa5t+sJJ8+UheK6WXkGRQBjgX22VOlGE3icj+DJyXeiYcnnEgneMPY41aeyxzTNBi46ku5qehVzhdxDU1Jg7N2UYfCwqp2H5RCmpU4wliyNhhtJechgg1f+JeifZ0Ulk7oExUlqIGCSoJWyFHHp7+ywz0x4lZZrBZ2PiyG5ElAcBM9L7BADpYievrNfAgU6kjjVzxGoBdeK8EEzzaGT/nPXmGlU0FnSj+thP1c2byC1+PzbfuusMhQqNBN7FVz1NGPXsKpEbvGpLn9Q/DnIgf2LaDRLbl02WUao/fHIIXg4daN8mntfiTkytKgrztpPJi5OOan7VG0yNvxBzk091mzNOC3L5TjyOoigopHNv0LXc8CgKWd0MT2DNFsVyLQ6TI5x658N5y66lNmQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e592f56-06b6-4459-947d-08d891fcceef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:17:06.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrAHQ/xkLe2179e0jO0TMWwP6JEv0rXA3D5AnH/rBdSoj/v/eT3T3+tuf2r8Gz41edIClHxrsran4YHea7xPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The i.MX8QuadMax is a Dual (2x) Cortex-A72 and Quad (4x) Cortex-A53
proccessor with powerful graphic and multimedia features. It uses
the same architecture as MX8QXP, so many SS can be reused.
This patch adds i.MX8QuadMax SoC dtsi file.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * change to a new supported scu mu binding
v2->v3:
 * remove a typo change on imx8qxp.dtsi which is unrelated to this patch
 * include new imx8-lpcg.h
v1->v2:
 * change to the new two cell scu clk binding
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 176 ++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
new file mode 100644
index 000000000000..12cd059b339b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/pads-imx8qm.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &lpuart0;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A72_0>;
+				};
+				core1 {
+					cpu = <&A72_1>;
+				};
+			};
+		};
+
+		A53_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A72_0: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+		};
+
+		A72_1: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+		};
+
+		A53_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		A72_L2: l2-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@51a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x51b00000 0 0xC0000>, /* GICR */
+		      <0x0 0x52000000 0 0x2000>,  /* GICC */
+		      <0x0 0x52010000 0 0x1000>,  /* GICH */
+		      <0x0 0x52020000 0 0x20000>; /* GICV */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
+	};
+
+	scu {
+		compatible = "fsl,imx-scu";
+		mbox-names = "tx0",
+			     "rx0",
+			     "gip3";
+		mboxes = <&lsio_mu1 0 0
+			  &lsio_mu1 1 0
+			  &lsio_mu1 3 3>;
+
+		pd: imx8qx-pd {
+			compatible = "fsl,imx8qm-scu-pd", "fsl,scu-pd";
+			#power-domain-cells = <1>;
+		};
+
+		clk: clock-controller {
+			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+			#clock-cells = <2>;
+		};
+
+		iomuxc: pinctrl {
+			compatible = "fsl,imx8qm-iomuxc";
+		};
+
+	};
+
+	/* sorted in register address */
+	#include "imx8-ss-dma.dtsi"
+	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-lsio.dtsi"
+};
+
+#include "imx8qm-ss-dma.dtsi"
+#include "imx8qm-ss-conn.dtsi"
+#include "imx8qm-ss-lsio.dtsi"
-- 
2.23.0

