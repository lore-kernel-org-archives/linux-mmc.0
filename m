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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C7C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F21221E9
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c47JPq4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbgKZLQp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:45 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:36938
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388881AbgKZLQp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSfR9UVBwQNCrWG97/GR5yD2qFedf3kCYvIt+uxNTEDDAXkKgecZk2ydSiohzuf8I4fI14XkdkZNwjo0EKKp5gPryzKIHSD+2/hhfih8nKIlszTj87H0YR6Z5gbKkjgUeTL5su0iJE71RFocaDqHSGGfY2h7OgEWaBvFoYtOSbrRsxaNr49O73iN4zHC02oB1ljuwYN6TVDCPj7GCLY1+/AOrbwdxDg6yXjgSm4EbhGPzsiY2STc1OvrZnnuQwXg8JwowPb/nQoDVJhxKOR+9u2Lgj6m8xvbe4IrnXXdQBkt0We0DKEyegTKuHX16uWlwTN1bMBUtb3Th6/IGD99Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2024zE0btuNGn53gPOEdEqvLVSUqRSXzjVmCGDRoyDw=;
 b=ilYQA5No9d/ef9qHUdwBlEsl+91rY3X2FDCCbtWZQ3ORcdQX+nKPJ8D22ehHaf4SvOdeNXsD+dLLjuC/tQpHXVsp9ajU02UXgcsLVQeXUqL/wqPEeZrX8xPHsLqB248AkRQSaA/77qsaGLs/JgU8KyoV1o9lcueC9srde4NS1z+k74Jaa7bOEX+9dGPLjQ3NLU0gSdrWlcXMwiZZx22qnJ9LxGuk8Zi3smIFMX4a6BLhNwqadS0OZOc/bY+NXNXChQbRFB9YRtNqQ1rfgJN2gSImfFJPamDtmoKgwpecJ5V4h9JT9wd+DjAMsSx59Kxh9CRfkzo13QaSnkxM7wzKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2024zE0btuNGn53gPOEdEqvLVSUqRSXzjVmCGDRoyDw=;
 b=c47JPq4ANaBOpPqzx5Y/77XHitP0LhrLpM7c8SuQB2fcI3BDTWPvtZo9SuXZ1sH7zaRyj/DNrsZ+Hx1lkx40P5LjMmN7ry+0tqUn0Zp4RLlHecGyo+KaJAci1ybpU4SmnkLENjKZ5VZnygK2uOpZUhEUd/M7G2CRp35PIIvRD1E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:35 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:34 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 06/18] arm64: dts: imx8qxp: orginize dts in subsystems
Date:   Thu, 26 Nov 2020 18:58:48 +0800
Message-Id: <20201126105900.26658-7-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c27eebf-488d-43f8-14c6-08d891fcbc0e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206A0D60534802971E8F98A80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8HLRAL1WbnkeF2y2rAr+XJgQXVvajFuicgErYJ497h07gotNvEgpsQQjm9vgH459a6nHjol4zgnWnppKwuS9PyB8YcAAYNP+KkS6WwzjwgQ93Cu9J/ukk3U3dwSqK2E5nV2QflBv0PxNGsWlLBZKO/Sj29K4zJL6uzXdyf2fYfNbBy2+m+egijm0WQX/XrJLCj+toq58EsVxg36NvJikoLoazSyeuNJ/9O32ej5vXUpXjLerEdgM520lPWvXLpbx8v9Fcww0oC9Gg4uI7fvUW/8ebTzIlUPtLSQLgVEbB5I2+ZKc1+fzlg5f9tLAjkHe4dSXQ38pFBcMjT9QmspfP+Cqijl4YHBhyUdlcfgq5maztjUUikKh1x9vXHsNsnr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(30864003)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oy/9yHg2DtFONCG/d/l71kuckNcKlL/GKBeiw5gDiFpggG5nNHeiDQiqqLLAHAPMIYB9Gy09rzWzl5rU/AF9ShoFyZ5pDUKBLrEt+ZGHtLElpZQKN9TYiSxugRPSKNqSZhLMcMrplfwjIvLI40p3G9HQOE7e/1B26vJQRww5A5y5hMAcFCudgL0fHyISCgrclFw6Vp2WoJa3hXlCzEBVM0NArfYVrPquk0SYM/hr/H2KydbFcNO46tdC78qMppX7jrJQ3+ETzl9tSSCCMVNXPKtApTIeB+n6+d+UA2YppF4Wjl77CzRcm93U4BX2cO+EMRUXvHQ9ldaD33W5GJUY8NROHyzdnDvg/bylrWnLqrYdR74f2YgAn8+H8XSkkIpXq2If2RV5fHDpV4xnIDByONUXPDrULekNMOIjIghXMFNAts/SfacRdU9GJAg+m9Qk5VkmJ5HqlcuNz9st4Aei2StPsqFQXTEUgCpqLOQ+AvZ3aFdu1CRmVcij/dzRl6/wGLo7euPspFU3W7TtawO4qR9COy0gE2hejJV/sKxQVzucrf69s/OJ7p7QcRXtV18X0dLBjR8g+BEY91OXhKt2gAtb0yaE/USzjGLhc9C77lcN+V7AV8w/SLda+YrKZz5dnge0GdcyniBhnO1wtuBkw1j4gnlys9125lBrlbxgTFANzwsyx4ScMDivOpeEuBIb/Xkmmy4K4hiyb4d481JPCLWRPluzVm/eDTglPC2qGl3jc5Bkk4yZtpX0kLm+/xRIUvfrVZvsnsFv0cdKbzdeRtMVPiSFPdtl+p3a66gTNG9bEETucOv/J4ps6aS/Ddmjp7STAKiEkcz2zpxngmogxyR5tB0gcubLnDFoIWpcA3wzvzyaAqjgwYvggi2aX4HNacJYh5v8C+fLnejKevgtKg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c27eebf-488d-43f8-14c6-08d891fcbc0e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:34.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqijZkBi6Q9nYyrZts7L6b5SWerRQ5cZGBzWCQjwz2cAssdhXGx1z/IcSBFeB0ZZ+fZLft1DDu2AsSGI2TTjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MX8 SoC is comprised of a few HW subsystems while some of them can be
reused in the different SoCs. So let's re-orginize them into subsystems
in device tree as well for the possible reuse of the common part.

Note, as there's still no devices of hsio subsys, so removed it
first instead of creating a subsys headfile with no devices.
They will be added back when new devices added.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v6:
 * no changes except rebase
---
 .../boot/dts/freescale/imx8-ss-adma.dtsi      | 122 ++++++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |  86 ++++
 .../arm64/boot/dts/freescale/imx8-ss-ddr.dtsi |  18 +
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 138 +++++++
 .../boot/dts/freescale/imx8qxp-ss-adma.dtsi   |  41 ++
 .../boot/dts/freescale/imx8qxp-ss-conn.dtsi   |  29 ++
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   |  65 +++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 386 +-----------------
 8 files changed, 510 insertions(+), 375 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
new file mode 100644
index 000000000000..2c0bb822c179
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+adma_subsys: bus@59000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
+
+	adma_lpcg: clock-controller@59000000 {
+		reg = <0x59000000 0x2000000>;
+		#clock-cells = <1>;
+	};
+
+	adma_dsp: dsp@596e8000 {
+		compatible = "fsl,imx8qxp-dsp";
+		reg = <0x596e8000 0x88000>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
+			<&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
+			<&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+		clock-names = "ipg", "ocram", "core";
+		power-domains = <&pd IMX_SC_R_MU_13A>,
+			<&pd IMX_SC_R_MU_13B>,
+			<&pd IMX_SC_R_DSP>,
+			<&pd IMX_SC_R_DSP_RAM>;
+		mbox-names = "txdb0", "txdb1",
+			"rxdb0", "rxdb1";
+		mboxes = <&lsio_mu13 2 0>,
+			<&lsio_mu13 2 1>,
+			<&lsio_mu13 3 0>,
+			<&lsio_mu13 3 1>;
+		memory-region = <&dsp_reserved>;
+		status = "disabled";
+	};
+
+	adma_lpuart0: serial@5a060000 {
+		reg = <0x5a060000 0x1000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_IPG_CLK>,
+			 <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+		status = "disabled";
+	};
+
+	adma_lpuart1: serial@5a070000 {
+		reg = <0x5a070000 0x1000>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_IPG_CLK>,
+			 <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_1>;
+		status = "disabled";
+	};
+
+	adma_lpuart2: serial@5a080000 {
+		reg = <0x5a080000 0x1000>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_IPG_CLK>,
+			 <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_2>;
+		status = "disabled";
+	};
+
+	adma_lpuart3: serial@5a090000 {
+		reg = <0x5a090000 0x1000>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_IPG_CLK>,
+			 <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_3>;
+		status = "disabled";
+	};
+
+	adma_i2c0: i2c@5a800000 {
+		reg = <0x5a800000 0x4000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+		status = "disabled";
+	};
+
+	adma_i2c1: i2c@5a810000 {
+		reg = <0x5a810000 0x4000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+		status = "disabled";
+	};
+
+	adma_i2c2: i2c@5a820000 {
+		reg = <0x5a820000 0x4000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+		status = "disabled";
+	};
+
+	adma_i2c3: i2c@5a830000 {
+		reg = <0x5a830000 0x4000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
new file mode 100644
index 000000000000..8691a43882fd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+conn_subsys: bus@5b000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
+
+	conn_lpcg: clock-controller@5b200000 {
+		reg = <0x5b200000 0xb0000>;
+		#clock-cells = <1>;
+	};
+
+	usdhc1: mmc@5b010000 {
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b010000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		power-domains = <&pd IMX_SC_R_SDHC_0>;
+		status = "disabled";
+	};
+
+	usdhc2: mmc@5b020000 {
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b020000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		power-domains = <&pd IMX_SC_R_SDHC_1>;
+		fsl,tuning-start-tap = <20>;
+		fsl,tuning-step= <2>;
+		status = "disabled";
+	};
+
+	usdhc3: mmc@5b030000 {
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x5b030000 0x10000>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
+		clock-names = "ipg", "per", "ahb";
+		power-domains = <&pd IMX_SC_R_SDHC_2>;
+		status = "disabled";
+	};
+
+	fec1: ethernet@5b040000 {
+		reg = <0x5b040000 0x10000>;
+		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+		fsl,num-tx-queues=<3>;
+		fsl,num-rx-queues=<3>;
+		power-domains = <&pd IMX_SC_R_ENET_0>;
+		status = "disabled";
+	};
+
+	fec2: ethernet@5b050000 {
+		reg = <0x5b050000 0x10000>;
+		interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
+			 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
+		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
+		fsl,num-tx-queues=<3>;
+		fsl,num-rx-queues=<3>;
+		power-domains = <&pd IMX_SC_R_ENET_1>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
new file mode 100644
index 000000000000..8b5cad4e2700
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+ddr_subsys: bus@5c000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
+
+	ddr-pmu@5c020000 {
+		compatible = "fsl,imx8-ddr-pmu";
+		reg = <0x5c020000 0x10000>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
new file mode 100644
index 000000000000..70902f56cdb1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+lsio_subsys: bus@5d000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+
+	lsio_gpio0: gpio@5d080000 {
+		reg = <0x5d080000 0x10000>;
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_0>;
+	};
+
+	lsio_gpio1: gpio@5d090000 {
+		reg = <0x5d090000 0x10000>;
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_1>;
+	};
+
+	lsio_gpio2: gpio@5d0a0000 {
+		reg = <0x5d0a0000 0x10000>;
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_2>;
+	};
+
+	lsio_gpio3: gpio@5d0b0000 {
+		reg = <0x5d0b0000 0x10000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_3>;
+	};
+
+	lsio_gpio4: gpio@5d0c0000 {
+		reg = <0x5d0c0000 0x10000>;
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_4>;
+	};
+
+	lsio_gpio5: gpio@5d0d0000 {
+		reg = <0x5d0d0000 0x10000>;
+		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_5>;
+	};
+
+	lsio_gpio6: gpio@5d0e0000 {
+		reg = <0x5d0e0000 0x10000>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_6>;
+	};
+
+	lsio_gpio7: gpio@5d0f0000 {
+		reg = <0x5d0f0000 0x10000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		power-domains = <&pd IMX_SC_R_GPIO_7>;
+	};
+
+	lsio_mu0: mailbox@5d1b0000 {
+		reg = <0x5d1b0000 0x10000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_mu1: mailbox@5d1c0000 {
+		reg = <0x5d1c0000 0x10000>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+	};
+
+	lsio_mu2: mailbox@5d1d0000 {
+		reg = <0x5d1d0000 0x10000>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_mu3: mailbox@5d1e0000 {
+		reg = <0x5d1e0000 0x10000>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_mu4: mailbox@5d1f0000 {
+		reg = <0x5d1f0000 0x10000>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_mu13: mailbox@5d280000 {
+		reg = <0x5d280000 0x10000>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_MU_13A>;
+	};
+
+	lsio_lpcg: clock-controller@5d400000 {
+		reg = <0x5d400000 0x400000>;
+		#clock-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
new file mode 100644
index 000000000000..64e51dda2dfd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&adma_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-adma";
+};
+
+&adma_lpuart0 {
+	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&adma_lpuart1 {
+	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&adma_lpuart2 {
+	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&adma_lpuart3 {
+	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+};
+
+&adma_i2c0 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c1 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c2 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&adma_i2c3 {
+	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
new file mode 100644
index 000000000000..bed3934ca029
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&conn_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-conn";
+};
+
+&usdhc1 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc3 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
+
+&fec1 {
+	compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+};
+
+&fec2 {
+	compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
new file mode 100644
index 000000000000..82cebf04fca9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&lsio_gpio0 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio1 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio2 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio3 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio4 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio5 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio6 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio7 {
+	compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_mu0 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu1 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu2 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu3 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu4 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu13 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_lpcg {
+	compatible = "fsl,imx8qxp-lpcg-lsio";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index f4a2a76ee894..cd7a482dc3ff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2020 NXP
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
@@ -223,380 +223,6 @@
 		clock-output-names = "xtal_24MHz";
 	};
 
-	adma_subsys: bus@59000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x59000000 0x0 0x59000000 0x2000000>;
-
-		adma_lpcg: clock-controller@59000000 {
-			compatible = "fsl,imx8qxp-lpcg-adma";
-			reg = <0x59000000 0x2000000>;
-			#clock-cells = <1>;
-		};
-
-		adma_dsp: dsp@596e8000 {
-			compatible = "fsl,imx8qxp-dsp";
-			reg = <0x596e8000 0x88000>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
-				<&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
-				<&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
-			clock-names = "ipg", "ocram", "core";
-			power-domains = <&pd IMX_SC_R_MU_13A>,
-				<&pd IMX_SC_R_MU_13B>,
-				<&pd IMX_SC_R_DSP>,
-				<&pd IMX_SC_R_DSP_RAM>;
-			mbox-names = "txdb0", "txdb1",
-				"rxdb0", "rxdb1";
-			mboxes = <&lsio_mu13 2 0>,
-				<&lsio_mu13 2 1>,
-				<&lsio_mu13 3 0>,
-				<&lsio_mu13 3 1>;
-			memory-region = <&dsp_reserved>;
-			status = "disabled";
-		};
-
-		adma_lpuart0: serial@5a060000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
-			reg = <0x5a060000 0x1000>;
-			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_IPG_CLK>,
-				 <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
-			clock-names = "ipg", "baud";
-			power-domains = <&pd IMX_SC_R_UART_0>;
-			status = "disabled";
-		};
-
-		adma_lpuart1: serial@5a070000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
-			reg = <0x5a070000 0x1000>;
-			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_IPG_CLK>,
-				 <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
-			clock-names = "ipg", "baud";
-			power-domains = <&pd IMX_SC_R_UART_1>;
-			status = "disabled";
-		};
-
-		adma_lpuart2: serial@5a080000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
-			reg = <0x5a080000 0x1000>;
-			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_IPG_CLK>,
-				 <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
-			clock-names = "ipg", "baud";
-			power-domains = <&pd IMX_SC_R_UART_2>;
-			status = "disabled";
-		};
-
-		adma_lpuart3: serial@5a090000 {
-			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
-			reg = <0x5a090000 0x1000>;
-			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_IPG_CLK>,
-				 <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
-			clock-names = "ipg", "baud";
-			power-domains = <&pd IMX_SC_R_UART_3>;
-			status = "disabled";
-		};
-
-		adma_i2c0: i2c@5a800000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a800000 0x4000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C0_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_0>;
-			status = "disabled";
-		};
-
-		adma_i2c1: i2c@5a810000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a810000 0x4000>;
-			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C1_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_1>;
-			status = "disabled";
-		};
-
-		adma_i2c2: i2c@5a820000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a820000 0x4000>;
-			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C2_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_2>;
-			status = "disabled";
-		};
-
-		adma_i2c3: i2c@5a830000 {
-			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
-			reg = <0x5a830000 0x4000>;
-			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
-			clock-names = "per";
-			assigned-clocks = <&clk IMX_ADMA_I2C3_CLK>;
-			assigned-clock-rates = <24000000>;
-			power-domains = <&pd IMX_SC_R_I2C_3>;
-			status = "disabled";
-		};
-	};
-
-	conn_subsys: bus@5b000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
-
-		conn_lpcg: clock-controller@5b200000 {
-			compatible = "fsl,imx8qxp-lpcg-conn";
-			reg = <0x5b200000 0xb0000>;
-			#clock-cells = <1>;
-		};
-
-		usdhc1: mmc@5b010000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b010000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			power-domains = <&pd IMX_SC_R_SDHC_0>;
-			status = "disabled";
-		};
-
-		usdhc2: mmc@5b020000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b020000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			power-domains = <&pd IMX_SC_R_SDHC_1>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step= <2>;
-			status = "disabled";
-		};
-
-		usdhc3: mmc@5b030000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x5b030000 0x10000>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
-			clock-names = "ipg", "per", "ahb";
-			power-domains = <&pd IMX_SC_R_SDHC_2>;
-			status = "disabled";
-		};
-
-		fec1: ethernet@5b040000 {
-			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
-			reg = <0x5b040000 0x10000>;
-			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
-			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
-			fsl,num-tx-queues=<3>;
-			fsl,num-rx-queues=<3>;
-			power-domains = <&pd IMX_SC_R_ENET_0>;
-			status = "disabled";
-		};
-
-		fec2: ethernet@5b050000 {
-			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
-			reg = <0x5b050000 0x10000>;
-			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
-			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
-			fsl,num-tx-queues=<3>;
-			fsl,num-rx-queues=<3>;
-			power-domains = <&pd IMX_SC_R_ENET_1>;
-			status = "disabled";
-		};
-	};
-
-	ddr_subsyss: bus@5c000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
-
-		ddr-pmu@5c020000 {
-			compatible = "fsl,imx8-ddr-pmu";
-			reg = <0x5c020000 0x10000>;
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	lsio_subsys: bus@5d000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
-
-		lsio_gpio0: gpio@5d080000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d080000 0x10000>;
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_0>;
-		};
-
-		lsio_gpio1: gpio@5d090000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d090000 0x10000>;
-			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_1>;
-		};
-
-		lsio_gpio2: gpio@5d0a0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0a0000 0x10000>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_2>;
-		};
-
-		lsio_gpio3: gpio@5d0b0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0b0000 0x10000>;
-			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_3>;
-		};
-
-		lsio_gpio4: gpio@5d0c0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0c0000 0x10000>;
-			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_4>;
-		};
-
-		lsio_gpio5: gpio@5d0d0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0d0000 0x10000>;
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_5>;
-		};
-
-		lsio_gpio6: gpio@5d0e0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0e0000 0x10000>;
-			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_6>;
-		};
-
-		lsio_gpio7: gpio@5d0f0000 {
-			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
-			reg = <0x5d0f0000 0x10000>;
-			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			power-domains = <&pd IMX_SC_R_GPIO_7>;
-		};
-
-		lsio_mu0: mailbox@5d1b0000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1b0000 0x10000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-			status = "disabled";
-		};
-
-		lsio_mu1: mailbox@5d1c0000 {
-			compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1c0000 0x10000>;
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-		};
-
-		lsio_mu2: mailbox@5d1d0000 {
-			compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1d0000 0x10000>;
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-			status = "disabled";
-		};
-
-		lsio_mu3: mailbox@5d1e0000 {
-			compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1e0000 0x10000>;
-			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-			status = "disabled";
-		};
-
-		lsio_mu4: mailbox@5d1f0000 {
-			compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d1f0000 0x10000>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-			status = "disabled";
-		};
-
-		lsio_mu13: mailbox@5d280000 {
-			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-			reg = <0x5d280000 0x10000>;
-			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-			power-domains = <&pd IMX_SC_R_MU_13A>;
-		};
-
-		lsio_lpcg: clock-controller@5d400000 {
-			compatible = "fsl,imx8qxp-lpcg-lsio";
-			reg = <0x5d400000 0x400000>;
-			#clock-cells = <1>;
-		};
-	};
-
 	thermal_zones: thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
@@ -629,4 +255,14 @@
 			};
 		};
 	};
+
+	/* sorted in register address */
+	#include "imx8-ss-adma.dtsi"
+	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-ddr.dtsi"
+	#include "imx8-ss-lsio.dtsi"
 };
+
+#include "imx8qxp-ss-adma.dtsi"
+#include "imx8qxp-ss-conn.dtsi"
+#include "imx8qxp-ss-lsio.dtsi"
-- 
2.23.0

