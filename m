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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C2AC56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CE8206B7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEUU2ICe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbgKZLRw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:52 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:56710
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbgKZLRw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjbWBC1Uux/NiGRh5E+AQP1UOCgQhS2aDHQgieaFxYVfy+cLslxMIUCVAKg04hKjIrx+IIU2GoC4oB3vRMb7+4+6hHRwYARfLz2tX3h91G+enBPxiiXEObFFf9r0BWcyVt/6BmAGpmgKWuTgyVWrwVN1KMS1ovfqT8cAgTCL6ROGw24qQxlTaX0q2Ute14Pc81AT4ZLe7iKWn/+CyzXc8ft4VaIb1BJkUvnkwD/yku2gK3D4E6nM6Ti3whpma6PBsZoK6oFNuUFmGJb0IsVCn4VQEXuH9qApVA/lkJDLTHHHAElzW88D9LJ0nTJH0LVvlFg5k+ogam9Y28cCxuYCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PiHOu+fWXcwPAtOJGTb9PJHQKxbCJKLrzR5MHi05/k=;
 b=eoCFdSaluE1oJPkHnLeUXEQ2TE92ksnNcP/tbnD062z7vSU4N5uaMzZsQF+f5K0sGuqZpzrKHq8Ue+YicxqI1KoNNzy+v5xV9y/Enyj+6vk0bHRRV8daRaXxSXgY+QXw3A9y1laIparki9g2gbK+bOqJgXi4lovRCNn259aE6NSgrgBVvNdmcoLerGRVjeVrV+r25X+lr8y4VxvVnt4xW2M4b6WvjKMcQS7KMxn3al/xUSjBK+GDNFxzwuygBY4DDyPNAZbh/fwHLofcfOccYoQDAXHX0XdDJkr9t27rE1/fO53/drHj1jZ4LsNaXBBeHnj7NDtfAQKsEF+0E3Q+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PiHOu+fWXcwPAtOJGTb9PJHQKxbCJKLrzR5MHi05/k=;
 b=UEUU2ICeyJV1DT590BlVyhFZtLgfClvMu9C13r+gAk0NN9zfKnnsgO9t6wdC+4NyJKLEaWXCRokm5J7aSsdx4AlZFVqxbppnbmd4YVQ16UVFER6nD8VgfEfk+ZlcpX5G889vmfcKDB8AvoOaj2/TSLrA6eit71AQHmP/KgyWMSg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:49 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:49 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND v4 11/18] arm64: dts: imx8: switch to new lpcg clock binding
Date:   Thu, 26 Nov 2020 18:58:53 +0800
Message-Id: <20201126105900.26658-12-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b4e0ead-0d8b-47e4-b105-08d891fcc4f1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206A3E206140A3455D2700E80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyrCWPBewncCv0NSzww+FlK9NjnDdIhwoQlSxkdGSMJtqZ7ZfOMkr5/3Rp5uBBK7p8PnVv3Gelu5cargCVTutGg/3gXK+783yf9KlY9xeg1eNCbp7oSm0CZ2k8QbxkSL0Sr1yVgjeW1my5ftDzQiDd7V2nsBBI+aT1rsyzxk1a1t0VhUCR5HS+aeE2Pa7dcInpVE1fUuDoYS4K3B+Aj5tEQyP2yolj4HjKtsbe/DddLouoCrQeBLpRpRYje0SQOZocjqpW5vx7EC2tvcxtlV41On3F+0FPWy8MS9Qp3C53BaVgvfxxXCIfAtQJy5pvxgnYNPriMGYk/Gk8zI8SnY+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(30864003)(186003)(16526019)(66946007)(26005)(83380400001)(6486002)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: T3jVtiJEIFjKFTP8YCmTKoPv7pXzuulndaCiMvj7M+BvXs9B8J5JW2NTQT0o33F221sgoAmGblrD8qyKzhFkxoWwbGkrSn09ee3KLfP6ZjZNPEWqXWl1vAn5mON8cg4fVvsWBo37DB3aiUYvw1yB++3RSPt7qBK4ntiAsmDaM9w6kiN3YJcizLuqQIbQTkbqePWczhcWkcsoFJPZnw0xBX+1Pbf+M0rRLRjfREEK0podov2b8li6o7rEvTO1KDMiZryZodyuRFmevi/3GfCY5csJkhjCnap3WA7NkUZc6RTYnJG9z7+PELkcxNojJPhpty6tG7hX3zcDOk+RoZonJcs9mwAMboxmBM1Wo95yHDM5h/oqcYkUeP/Jryhhbiet5Jqfb8hOI4BAAlydNm17a6EyeBd07bBzHwvLEdEX5Xgl0qn2wb73R2soC56rnPesz1RnRpowL8w+eV7JEHVRejXFqWzt5M72XRmjLwXUbGfcJg1M6n+fT/0pdpe4haBWLN9arTT+rxYmmib4kuQjVs48xfd52cvTg1pEsCG5ZYHl0J3aynDlcIthLZHTV2h50GvXwdPhY0LwMz+GFYVC0NeJvpTz3OIpqIMztz+jlOIemH0esS6SLgtIsGtPVWzx06CYwL7h6DyhB87kVTRcFkT13EMbBQ+aS2Gv4rECzkCDV25rWF+ABz8jNCPPCjIBsAu/LgJY2KJ85mI61RT/kllYzwyyT4TaNWbgXdOlhf9Ywhvu0DdsRxo+Ym1TxgR2cmsxaluTDm3Q8mGZNklroailLwPVEiwsCqR8BNU13ocDwYQvzg9hKHB/2DAczPnqsuZOoOqrYJUFyMC5WMXx9e/sfXg4O1zNF77dHCpafOclMpLt8tho8wfIAwilcl9trfORLYDxct+dUGwdC1pBvQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e0ead-0d8b-47e4-b105-08d891fcc4f1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:49.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQcpXHcAID2MAECyyOn19DzAkNtgX1tnBzZfVm+gwkdDRQY6M9J04UztT+lQ8rFe6dsAqMuzygRXg63ZPmTAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

switch to new lpcg clock binding

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->5:
 * no changes except rebase to latest kernel
v2->v3:
 * use new clock-indices IDs
v1->v2:
 * split scu clock changes
---
 .../boot/dts/freescale/imx8-ss-adma.dtsi      | 46 ++++++++++---------
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 44 +++++++++---------
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 13 ++++--
 .../boot/dts/freescale/imx8qxp-ss-adma.dtsi   |  4 --
 .../boot/dts/freescale/imx8qxp-ss-conn.dtsi   |  4 --
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   |  4 --
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  1 +
 7 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index 30f2089cfdc4..ff0696d80654 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -20,13 +20,8 @@ adma_subsys: bus@59000000 {
 		clock-output-names = "dma_ipg_clk";
 	};
 
-	/* LPCG clocks */
-	adma_lpcg: clock-controller@59000000 {
-		reg = <0x59000000 0x2000000>;
-		#clock-cells = <1>;
-	};
-
 	dsp_lpcg: clock-controller@59580000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x59580000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&dma_ipg_clk>,
@@ -41,6 +36,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	dsp_ram_lpcg: clock-controller@59590000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x59590000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&dma_ipg_clk>;
@@ -52,9 +48,9 @@ adma_subsys: bus@59000000 {
 	adma_dsp: dsp@596e8000 {
 		compatible = "fsl,imx8qxp-dsp";
 		reg = <0x596e8000 0x88000>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
-			<&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
-			<&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
+			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
+			 <&dsp_lpcg IMX_LPCG_CLK_7>;
 		clock-names = "ipg", "ocram", "core";
 		power-domains = <&pd IMX_SC_R_MU_13A>,
 			<&pd IMX_SC_R_MU_13B>,
@@ -73,8 +69,8 @@ adma_subsys: bus@59000000 {
 	adma_lpuart0: serial@5a060000 {
 		reg = <0x5a060000 0x1000>;
 		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART0_IPG_CLK>,
-			 <&adma_lpcg IMX_ADMA_LPCG_UART0_BAUD_CLK>;
+		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
+			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
 		power-domains = <&pd IMX_SC_R_UART_0>;
 		status = "disabled";
@@ -83,8 +79,8 @@ adma_subsys: bus@59000000 {
 	adma_lpuart1: serial@5a070000 {
 		reg = <0x5a070000 0x1000>;
 		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_IPG_CLK>,
-			 <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
+		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
+			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
 		power-domains = <&pd IMX_SC_R_UART_1>;
 		status = "disabled";
@@ -93,8 +89,8 @@ adma_subsys: bus@59000000 {
 	adma_lpuart2: serial@5a080000 {
 		reg = <0x5a080000 0x1000>;
 		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_IPG_CLK>,
-			 <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
+		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
+			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
 		power-domains = <&pd IMX_SC_R_UART_2>;
 		status = "disabled";
@@ -103,14 +99,15 @@ adma_subsys: bus@59000000 {
 	adma_lpuart3: serial@5a090000 {
 		reg = <0x5a090000 0x1000>;
 		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_IPG_CLK>,
-			 <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
+		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
+			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
 		power-domains = <&pd IMX_SC_R_UART_3>;
 		status = "disabled";
 	};
 
 	uart0_lpcg: clock-controller@5a460000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a460000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>,
@@ -122,6 +119,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	uart1_lpcg: clock-controller@5a470000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a470000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>,
@@ -133,6 +131,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	uart2_lpcg: clock-controller@5a480000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a480000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>,
@@ -144,6 +143,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	uart3_lpcg: clock-controller@5a490000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a490000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>,
@@ -157,7 +157,7 @@ adma_subsys: bus@59000000 {
 	adma_i2c0: i2c@5a800000 {
 		reg = <0x5a800000 0x4000>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C0_CLK>;
+		clocks = <&i2c0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "per";
 		assigned-clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
@@ -168,7 +168,7 @@ adma_subsys: bus@59000000 {
 	adma_i2c1: i2c@5a810000 {
 		reg = <0x5a810000 0x4000>;
 		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C1_CLK>;
+		clocks = <&i2c1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "per";
 		assigned-clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
@@ -179,7 +179,7 @@ adma_subsys: bus@59000000 {
 	adma_i2c2: i2c@5a820000 {
 		reg = <0x5a820000 0x4000>;
 		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C2_CLK>;
+		clocks = <&i2c2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "per";
 		assigned-clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
@@ -190,7 +190,7 @@ adma_subsys: bus@59000000 {
 	adma_i2c3: i2c@5a830000 {
 		reg = <0x5a830000 0x4000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&adma_lpcg IMX_ADMA_LPCG_I2C3_CLK>;
+		clocks = <&i2c3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "per";
 		assigned-clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
@@ -199,6 +199,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	i2c0_lpcg: clock-controller@5ac00000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac00000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>,
@@ -210,6 +211,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	i2c1_lpcg: clock-controller@5ac10000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac10000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>,
@@ -221,6 +223,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	i2c2_lpcg: clock-controller@5ac20000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac20000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>,
@@ -232,6 +235,7 @@ adma_subsys: bus@59000000 {
 	};
 
 	i2c3_lpcg: clock-controller@5ac30000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac30000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>,
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 83945cc720e1..1ce40a1a092e 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -37,9 +37,9 @@ conn_subsys: bus@5b000000 {
 	usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+		clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
+			 <&sdhc0_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc0_lpcg IMX_LPCG_CLK_5>;
 		clock-names = "ipg", "per", "ahb";
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
@@ -48,9 +48,9 @@ conn_subsys: bus@5b000000 {
 	usdhc2: mmc@5b020000 {
 		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b020000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
+		clocks = <&sdhc1_lpcg IMX_LPCG_CLK_4>,
+			 <&sdhc1_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc1_lpcg IMX_LPCG_CLK_5>;
 		clock-names = "ipg", "per", "ahb";
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
@@ -61,9 +61,9 @@ conn_subsys: bus@5b000000 {
 	usdhc3: mmc@5b030000 {
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b030000 0x10000>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
+		clocks = <&sdhc2_lpcg IMX_LPCG_CLK_4>,
+			 <&sdhc2_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc2_lpcg IMX_LPCG_CLK_5>;
 		clock-names = "ipg", "per", "ahb";
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
@@ -75,10 +75,10 @@ conn_subsys: bus@5b000000 {
 			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET0_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_AHB_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_TX_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET0_ROOT_CLK>;
+		clocks = <&enet0_lpcg IMX_LPCG_CLK_4>,
+			 <&enet0_lpcg IMX_LPCG_CLK_2>,
+			 <&enet0_lpcg IMX_LPCG_CLK_1>,
+			 <&enet0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
 		fsl,num-tx-queues=<3>;
 		fsl,num-rx-queues=<3>;
@@ -92,10 +92,10 @@ conn_subsys: bus@5b000000 {
 				<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&conn_lpcg IMX_CONN_LPCG_ENET1_IPG_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_AHB_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_TX_CLK>,
-			 <&conn_lpcg IMX_CONN_LPCG_ENET1_ROOT_CLK>;
+		clocks = <&enet1_lpcg IMX_LPCG_CLK_4>,
+			 <&enet1_lpcg IMX_LPCG_CLK_2>,
+			 <&enet1_lpcg IMX_LPCG_CLK_1>,
+			 <&enet1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
 		fsl,num-tx-queues=<3>;
 		fsl,num-rx-queues=<3>;
@@ -104,12 +104,8 @@ conn_subsys: bus@5b000000 {
 	};
 
 	/* LPCG clocks */
-	conn_lpcg: clock-controller-legacy@5b200000 {
-		reg = <0x5b200000 0xb0000>;
-		#clock-cells = <1>;
-	};
-
 	sdhc0_lpcg: clock-controller@5b200000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5b200000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>,
@@ -123,6 +119,7 @@ conn_subsys: bus@5b000000 {
 	};
 
 	sdhc1_lpcg: clock-controller@5b210000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5b210000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_SDHC_1 IMX_SC_PM_CLK_PER>,
@@ -136,6 +133,7 @@ conn_subsys: bus@5b000000 {
 	};
 
 	sdhc2_lpcg: clock-controller@5b220000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5b220000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_SDHC_2 IMX_SC_PM_CLK_PER>,
@@ -149,6 +147,7 @@ conn_subsys: bus@5b000000 {
 	};
 
 	enet0_lpcg: clock-controller@5b230000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5b230000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
@@ -166,6 +165,7 @@ conn_subsys: bus@5b000000 {
 	};
 
 	enet1_lpcg: clock-controller@5b240000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5b240000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_ENET_1 IMX_SC_PM_CLK_PER>,
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 813dbac71d10..ee4e585a9c39 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -149,12 +149,8 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	/* LPCG clocks */
-	lsio_lpcg: clock-controller-legacy@5d400000 {
-		reg = <0x5d400000 0x400000>;
-		#clock-cells = <1>;
-	};
-
 	pwm0_lpcg: clock-controller@5d400000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d400000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,
@@ -174,6 +170,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm1_lpcg: clock-controller@5d410000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d410000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_1 IMX_SC_PM_CLK_PER>,
@@ -193,6 +190,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm2_lpcg: clock-controller@5d420000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d420000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_2 IMX_SC_PM_CLK_PER>,
@@ -212,6 +210,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm3_lpcg: clock-controller@5d430000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d430000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_3 IMX_SC_PM_CLK_PER>,
@@ -231,6 +230,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm4_lpcg: clock-controller@5d440000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d440000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_4 IMX_SC_PM_CLK_PER>,
@@ -250,6 +250,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm5_lpcg: clock-controller@5d450000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d450000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_5 IMX_SC_PM_CLK_PER>,
@@ -269,6 +270,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm6_lpcg: clock-controller@5d460000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d460000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_6 IMX_SC_PM_CLK_PER>,
@@ -288,6 +290,7 @@ lsio_subsys: bus@5d000000 {
 	};
 
 	pwm7_lpcg: clock-controller@5d470000 {
+		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5d470000 0x10000>;
 		#clock-cells = <1>;
 		clocks = <&clk IMX_SC_R_PWM_7 IMX_SC_PM_CLK_PER>,
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
index 64e51dda2dfd..3dc3238e7ca6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -4,10 +4,6 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&adma_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-adma";
-};
-
 &adma_lpuart0 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
index bed3934ca029..f5f58959f65c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
@@ -4,10 +4,6 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&conn_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-conn";
-};
-
 &usdhc1 {
 	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
index 82cebf04fca9..11395479ffc0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi
@@ -59,7 +59,3 @@
 &lsio_mu13 {
 	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 };
-
-&lsio_lpcg {
-	compatible = "fsl,imx8qxp-lpcg-lsio";
-};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 095d3f69a9b7..9513bb7b5c89 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/imx8-clock.h>
+#include <dt-bindings/clock/imx8-lpcg.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-- 
2.23.0

