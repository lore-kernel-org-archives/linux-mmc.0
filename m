Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE54EC63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627E520DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtxhxkkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgKZLRH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:07 -0500
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:29281
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388928AbgKZLRH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAREzkpH34ln0AfFGyvwGBvOkP0f2ftKUwnWJnDVY5akpLklexVLOeImwzMQGM6EBJ2VacCzEnjTP0AODtNzTMwzYo9uJZGZtDUpZY02eLUYjxmVYAtU4cQbWa5v55cK6aY9fJk7XvYUhHc98x7gGpX04YroyXu4rgllyS9NxwOvu3mBpIocbXelG+UWULEShBcAJTmXoJWWzBNFkv0j5IiQJ99mFQ/0WUAliHu4Ike0MXOnZS6/qNsP8VYHf6ZBtlXfbmIWRqPxYiPJGxu/bN8ItEu2MnzDErFCQw6bp3JCskm76LHGCCmPdZ5F3MwdKXEYPXv29PYrMIJkBa46XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjI6LWXf0+ZeUaGgqGvC54ikynpruTjhYyQdCQCOu6Y=;
 b=Cu4GslRInVUxR6twohx376mQONLpkaxFh4W4QgDtiqGWk/MI1RK4Ft8n9+ygrvE/1lUD/TBNL2WE0RPhl/kEPCEFOi9DjDKbnEfY4XUPLdHT8vCU9x33CWGQjM4hH8gUqaQVQXb832e/lwAgz1cEVxIyZDxycPJAlwKcyNhPSGlS9KLMtoAUZQZsbgaFLae76b1cB2bMNutKQkag+FDThHmkAl2boGp5T/vBQTzCxNIqv8jLaPNWbgVFYjG2plTCb5fSnUeCNrAdGUaVNsztRfozHbm5mag79toMtnMOLd+HMHDtIwH2Vizoqad1OiQ354qE4xf6hj8NAnn5/tF1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjI6LWXf0+ZeUaGgqGvC54ikynpruTjhYyQdCQCOu6Y=;
 b=QtxhxkkY3ZXJTQWqXUiOOzkIu9mxsZ+QA6A2ViEFWMywWwW1Mj0WVU9d4C3U6h/byaT1I2oHN5sIWW+9PqRyAPu8pHk1R4nK69cE5QRXI/UCFFwZJc9sxpp9HQg8h3WTWVnd7U5q0Hryv2wAkcF7hsVm3XJsAtdr0R1EsMeufmY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:59 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:59 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND v4 14/18] arm64: dts: imx8: split adma ss into dma and audio ss
Date:   Thu, 26 Nov 2020 18:58:56 +0800
Message-Id: <20201126105900.26658-15-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af81b33a-6c60-4c0a-25bd-08d891fcca7f
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB68694D373D5899361A39A12080F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGfpgkSPmYZZrzFQPUEKJwKsNCmlUdohWlOaLJWIMfm44+BaPPoKfFyt6/cQ38+28Vp4Ftwz0FBMOrM2hkDf+NGKRVMu+vUnH4pgr5/rkeq5+l/MGiIRojaRqo5QJk9Ih2wuns8n0UQf8yI1U346yKx1XzOwD1GqSCaCZNOBO4SJF9HZtqiPqvfc2L1wdq2PY9Ww8fdQm8xdKxMzyhFI5327j8MK0Xrs0nUE58QcmaWRqwHKrIcIPfKyRMTwVYHXw9BEmsZyKfoCWE2wozeMTkELrdpUqeMjR6ICHTMNTJSVl2nzW1cnkgO+/ClzW259tkmjsZ9DN6Yg/G0RUtiP3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(83380400001)(186003)(30864003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(52116002)(5660300002)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hPKlpM2029f7cfIW9E+E6lY15YR8bXLmwHqCLbuTbClWS0sWBEqFPPZFEQZ/r8dSMCjs84qarOccTyOugjUOkjH24qRo7gLy6WyPPmQXMLfKzclxrjLN5gq7mZab+2X1ivZ8YG2VtzWruXaOhIzb7pi/OcUkpzleP7wA3bdrjFgZyE835xWDRV6TiNdyjwJj3InrDC+g+0rIi2lE8UKAjEKUrRz9wyISsA2xrbOFLSRWVhiXss0QzsUA7CF41qsjmDb3LrF/ie1AFOvx4N34tjOuNe/Wgh5kwthuEfhoMErNzRa5WUeW4VL8ejV66MsQMRboPAGs9plmK9h8Lu5k1JZMAGBNnb2g7VFJ6frm1bIShjBZFL+GAoVpIm+4EVwL82R7/wc2bIMhts8Q89wkMEHiByCEAhCzWI5Fbqi9jkvDun4r1KnSBtldtpjEihd2E+WKUDRSkFo/ctJ8zYVUU9vY46e8F0qV2er5FBFypuUoG4WAlh4wmP24c7T9Cj8VILkbf7E/ploHyPgkFROwtcQWDSh3hZcMCEWOg9pYqgUbdiGAngvQSGFi5ynK4TsgP6EEs4AfSf5BgfUa+2/aZmYBU5Kqux8Bn1cZRr5XCVZGhdzNpvwngsAdM5LZDo11J7t5ROv2VzPAqsVGPtLGysPowhgOw+JkRRzce+E2RrjWacwehl8kFAnfdqpVAjKCVkHgdYK0Vc8eXHK8MDjZzAV9RZ78IvuPQgI0D9oh8Vla5ANVfAlDUU7J7ZbYIHDGLuDc4VciXmbs/oelRfb196PqZnvF+JGEG/CS0iHCIiqeAuuWYi84O3VnF/j9R1x4T8BIqi8D8qS4X3mwDTbht98vez5wR/WWGZ9k8TXG5X/bgY8Rtb+Kruj4azVO7SabwNCot6YavkwiFmK6kROkcg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af81b33a-6c60-4c0a-25bd-08d891fcca7f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:59.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdhwQj48XXn+5fxLGN5xhEQZqWYbvDd8575XnpXNa7wOnkP6Jicsf+Y1yRbR5XIL4vldH+QrnnJVVG3XO2g+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

amda ss is consisted of dma and audio ss in qxp which are
also used in qm.
Let's split them into two ss for better code reuse.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->4:
 * remove amda_* prefix for new boards colibri
v2->v3:
 * use new clock-indices IDs
 * remove ss prefix for adma
v1->v2:
 * change to the new two cell scu clk binding
---
 .../boot/dts/freescale/imx8-ss-adma.dtsi      | 244 +-----------------
 .../boot/dts/freescale/imx8-ss-audio.dtsi     |  68 +++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 202 +++++++++++++++
 .../boot/dts/freescale/imx8qxp-ai_ml.dts      |  16 +-
 .../freescale/imx8qxp-colibri-eval-v3.dtsi    |   8 +-
 .../boot/dts/freescale/imx8qxp-colibri.dtsi   |  12 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  46 ++--
 .../boot/dts/freescale/imx8qxp-ss-adma.dtsi   |  16 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  16 +-
 9 files changed, 329 insertions(+), 299 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index ff0696d80654..9386d1a59e82 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -4,245 +4,5 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-#include <dt-bindings/clock/imx8-lpcg.h>
-#include <dt-bindings/firmware/imx/rsrc.h>
-
-adma_subsys: bus@59000000 {
-	compatible = "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
-
-	dma_ipg_clk: clock-dma-ipg {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <120000000>;
-		clock-output-names = "dma_ipg_clk";
-	};
-
-	dsp_lpcg: clock-controller@59580000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x59580000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&dma_ipg_clk>,
-			 <&dma_ipg_clk>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
-				<IMX_LPCG_CLK_7>;
-		clock-output-names = "dsp_lpcg_adb_clk",
-				     "dsp_lpcg_ipg_clk",
-				     "dsp_lpcg_core_clk";
-		power-domains = <&pd IMX_SC_R_DSP>;
-	};
-
-	dsp_ram_lpcg: clock-controller@59590000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x59590000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_4>;
-		clock-output-names = "dsp_ram_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_DSP_RAM>;
-	};
-
-	adma_dsp: dsp@596e8000 {
-		compatible = "fsl,imx8qxp-dsp";
-		reg = <0x596e8000 0x88000>;
-		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
-			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
-			 <&dsp_lpcg IMX_LPCG_CLK_7>;
-		clock-names = "ipg", "ocram", "core";
-		power-domains = <&pd IMX_SC_R_MU_13A>,
-			<&pd IMX_SC_R_MU_13B>,
-			<&pd IMX_SC_R_DSP>,
-			<&pd IMX_SC_R_DSP_RAM>;
-		mbox-names = "txdb0", "txdb1",
-			"rxdb0", "rxdb1";
-		mboxes = <&lsio_mu13 2 0>,
-			<&lsio_mu13 2 1>,
-			<&lsio_mu13 3 0>,
-			<&lsio_mu13 3 1>;
-		memory-region = <&dsp_reserved>;
-		status = "disabled";
-	};
-
-	adma_lpuart0: serial@5a060000 {
-		reg = <0x5a060000 0x1000>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
-			 <&uart0_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "baud";
-		power-domains = <&pd IMX_SC_R_UART_0>;
-		status = "disabled";
-	};
-
-	adma_lpuart1: serial@5a070000 {
-		reg = <0x5a070000 0x1000>;
-		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
-			 <&uart1_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "baud";
-		power-domains = <&pd IMX_SC_R_UART_1>;
-		status = "disabled";
-	};
-
-	adma_lpuart2: serial@5a080000 {
-		reg = <0x5a080000 0x1000>;
-		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
-			 <&uart2_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "baud";
-		power-domains = <&pd IMX_SC_R_UART_2>;
-		status = "disabled";
-	};
-
-	adma_lpuart3: serial@5a090000 {
-		reg = <0x5a090000 0x1000>;
-		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
-			 <&uart3_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "baud";
-		power-domains = <&pd IMX_SC_R_UART_3>;
-		status = "disabled";
-	};
-
-	uart0_lpcg: clock-controller@5a460000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5a460000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "uart0_lpcg_baud_clk",
-				     "uart0_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_UART_0>;
-	};
-
-	uart1_lpcg: clock-controller@5a470000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5a470000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "uart1_lpcg_baud_clk",
-				     "uart1_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_UART_1>;
-	};
-
-	uart2_lpcg: clock-controller@5a480000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5a480000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "uart2_lpcg_baud_clk",
-				     "uart2_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_UART_2>;
-	};
-
-	uart3_lpcg: clock-controller@5a490000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5a490000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "uart3_lpcg_baud_clk",
-				     "uart3_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_UART_3>;
-	};
-
-	adma_i2c0: i2c@5a800000 {
-		reg = <0x5a800000 0x4000>;
-		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&i2c0_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "per";
-		assigned-clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_0>;
-		status = "disabled";
-	};
-
-	adma_i2c1: i2c@5a810000 {
-		reg = <0x5a810000 0x4000>;
-		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&i2c1_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "per";
-		assigned-clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_1>;
-		status = "disabled";
-	};
-
-	adma_i2c2: i2c@5a820000 {
-		reg = <0x5a820000 0x4000>;
-		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&i2c2_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "per";
-		assigned-clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_2>;
-		status = "disabled";
-	};
-
-	adma_i2c3: i2c@5a830000 {
-		reg = <0x5a830000 0x4000>;
-		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&i2c3_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "per";
-		assigned-clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>;
-		assigned-clock-rates = <24000000>;
-		power-domains = <&pd IMX_SC_R_I2C_3>;
-		status = "disabled";
-	};
-
-	i2c0_lpcg: clock-controller@5ac00000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5ac00000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "i2c0_lpcg_clk",
-				     "i2c0_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_I2C_0>;
-	};
-
-	i2c1_lpcg: clock-controller@5ac10000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5ac10000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "i2c1_lpcg_clk",
-				     "i2c1_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_I2C_1>;
-	};
-
-	i2c2_lpcg: clock-controller@5ac20000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5ac20000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "i2c2_lpcg_clk",
-				     "i2c2_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_I2C_2>;
-	};
-
-	i2c3_lpcg: clock-controller@5ac30000 {
-		compatible = "fsl,imx8qxp-lpcg";
-		reg = <0x5ac30000 0x10000>;
-		#clock-cells = <1>;
-		clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>,
-			 <&dma_ipg_clk>;
-		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
-		clock-output-names = "i2c3_lpcg_clk",
-				     "i2c3_lpcg_ipg_clk";
-		power-domains = <&pd IMX_SC_R_I2C_3>;
-	};
-};
+#include "imx8-ss-audio.dtsi"
+#include "imx8-ss-dma.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
new file mode 100644
index 000000000000..6c8d75ef9250
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+audio_subsys: bus@59000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x59000000 0x0 0x59000000 0x1000000>;
+
+	audio_ipg_clk: clock-audio-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "audio_ipg_clk";
+	};
+
+	dsp_lpcg: clock-controller@59580000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59580000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>,
+			 <&audio_ipg_clk>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_7>;
+		clock-output-names = "dsp_lpcg_adb_clk",
+				     "dsp_lpcg_ipg_clk",
+				     "dsp_lpcg_core_clk";
+		power-domains = <&pd IMX_SC_R_DSP>;
+	};
+
+	dsp_ram_lpcg: clock-controller@59590000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59590000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "dsp_ram_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_DSP_RAM>;
+	};
+
+	dsp: dsp@596e8000 {
+		compatible = "fsl,imx8qxp-dsp";
+		reg = <0x596e8000 0x88000>;
+		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
+			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
+			 <&dsp_lpcg IMX_LPCG_CLK_7>;
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
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
new file mode 100644
index 000000000000..960a802b8b6e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+dma_subsys: bus@5a000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x5a000000 0x0 0x5a000000 0x1000000>;
+
+	dma_ipg_clk: clock-dma-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dma_ipg_clk";
+	};
+
+	lpuart0: serial@5a060000 {
+		reg = <0x5a060000 0x1000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
+			 <&uart0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+		status = "disabled";
+	};
+
+	lpuart1: serial@5a070000 {
+		reg = <0x5a070000 0x1000>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
+			 <&uart1_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_1>;
+		status = "disabled";
+	};
+
+	lpuart2: serial@5a080000 {
+		reg = <0x5a080000 0x1000>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
+			 <&uart2_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_2>;
+		status = "disabled";
+	};
+
+	lpuart3: serial@5a090000 {
+		reg = <0x5a090000 0x1000>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
+			 <&uart3_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "baud";
+		power-domains = <&pd IMX_SC_R_UART_3>;
+		status = "disabled";
+	};
+
+	uart0_lpcg: clock-controller@5a460000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart0_lpcg_baud_clk",
+				     "uart0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+	};
+
+	uart1_lpcg: clock-controller@5a470000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart1_lpcg_baud_clk",
+				     "uart1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_1>;
+	};
+
+	uart2_lpcg: clock-controller@5a480000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart2_lpcg_baud_clk",
+				     "uart2_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_2>;
+	};
+
+	uart3_lpcg: clock-controller@5a490000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart3_lpcg_baud_clk",
+				     "uart3_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_3>;
+	};
+
+	i2c0: i2c@5a800000 {
+		reg = <0x5a800000 0x4000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&i2c0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@5a810000 {
+		reg = <0x5a810000 0x4000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&i2c1_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@5a820000 {
+		reg = <0x5a820000 0x4000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&i2c2_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@5a830000 {
+		reg = <0x5a830000 0x4000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&i2c3_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "per";
+		assigned-clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+		status = "disabled";
+	};
+
+	i2c0_lpcg: clock-controller@5ac00000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c0_lpcg_clk",
+				     "i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+	};
+
+	i2c1_lpcg: clock-controller@5ac10000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_I2C_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c1_lpcg_clk",
+				     "i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+	};
+
+	i2c2_lpcg: clock-controller@5ac20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_I2C_2 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c2_lpcg_clk",
+				     "i2c2_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+	};
+
+	i2c3_lpcg: clock-controller@5ac30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_I2C_3 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c3_lpcg_clk",
+				     "i2c3_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
index b5352706e3f0..47bb68823b24 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
@@ -13,13 +13,13 @@
 	compatible = "einfochips,imx8qxp-ai_ml", "fsl,imx8qxp";
 
 	aliases {
-		serial1 = &adma_lpuart1;
-		serial2 = &adma_lpuart2;
-		serial3 = &adma_lpuart3;
+		serial1 = &lpuart1;
+		serial2 = &lpuart2;
+		serial3 = &lpuart3;
 	};
 
 	chosen {
-		stdout-path = &adma_lpuart2;
+		stdout-path = &lpuart2;
 	};
 
 	memory@80000000 {
@@ -82,7 +82,7 @@
 };
 
 /* BT */
-&adma_lpuart0 {
+&lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
 	uart-has-rtscts;
@@ -90,21 +90,21 @@
 };
 
 /* LS-UART0 */
-&adma_lpuart1 {
+&lpuart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
 };
 
 /* Debug */
-&adma_lpuart2 {
+&lpuart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart2>;
 	status = "okay";
 };
 
 /* PCI-E UART */
-&adma_lpuart3 {
+&lpuart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart3>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
index c7336f387605..144fc9e82da7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
@@ -26,7 +26,7 @@
 	};
 };
 
-&adma_i2c1 {
+&i2c1 {
 	status = "okay";
 
 	/* M41T0M6 real time clock on carrier board */
@@ -37,17 +37,17 @@
 };
 
 /* Colibri UART_B */
-&adma_lpuart0 {
+&lpuart0 {
 	status= "okay";
 };
 
 /* Colibri UART_C */
-&adma_lpuart2 {
+&lpuart2 {
 	status= "okay";
 };
 
 /* Colibri UART_A */
-&adma_lpuart3 {
+&lpuart3 {
 	status= "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
index f38acff0d25c..89d70e030433 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
@@ -10,7 +10,7 @@
 	compatible = "toradex,colibri-imx8x", "fsl,imx8qxp";
 
 	chosen {
-		stdout-path = &adma_lpuart3;
+		stdout-path = &lpuart3;
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
@@ -22,7 +22,7 @@
 };
 
 /* On-module I2C */
-&adma_i2c0 {
+&i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clock-frequency = <100000>;
@@ -49,7 +49,7 @@
 };
 
 /* Colibri I2C */
-&adma_i2c1 {
+&i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clock-frequency = <100000>;
@@ -58,19 +58,19 @@
 };
 
 /* Colibri UART_B */
-&adma_lpuart0 {
+&lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
 };
 
 /* Colibri UART_C */
-&adma_lpuart2 {
+&lpuart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart2>;
 };
 
 /* Colibri UART_A */
-&adma_lpuart3 {
+&lpuart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart3>, <&pinctrl_lpuart3_ctrl>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index c40bbb313b78..863232a47004 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -12,7 +12,7 @@
 	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
 
 	chosen {
-		stdout-path = &adma_lpuart0;
+		stdout-path = &lpuart0;
 	};
 
 	memory@80000000 {
@@ -30,11 +30,30 @@
 	};
 };
 
-&adma_dsp {
+&dsp {
 	status = "okay";
 };
 
-&adma_i2c1 {
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
+
+&i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clock-frequency = <100000>;
@@ -110,31 +129,12 @@
 	};
 };
 
-&adma_lpuart0 {
+&lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
 	status = "okay";
 };
 
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-		};
-	};
-};
-
 &scu_key {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
index 3dc3238e7ca6..dc1daa8dc72f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
@@ -4,34 +4,34 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
-&adma_lpuart0 {
+&lpuart0 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
 
-&adma_lpuart1 {
+&lpuart1 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
 
-&adma_lpuart2 {
+&lpuart2 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
 
-&adma_lpuart3 {
+&lpuart3 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 };
 
-&adma_i2c0 {
+&i2c0 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c1 {
+&i2c1 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c2 {
+&i2c2 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
 
-&adma_i2c3 {
+&i2c3 {
 	compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 9513bb7b5c89..1e6b4995091e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -30,10 +30,10 @@
 		gpio5 = &lsio_gpio5;
 		gpio6 = &lsio_gpio6;
 		gpio7 = &lsio_gpio7;
-		i2c0 = &adma_i2c0;
-		i2c1 = &adma_i2c1;
-		i2c2 = &adma_i2c2;
-		i2c3 = &adma_i2c3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
@@ -42,10 +42,10 @@
 		mu2 = &lsio_mu2;
 		mu3 = &lsio_mu3;
 		mu4 = &lsio_mu4;
-		serial0 = &adma_lpuart0;
-		serial1 = &adma_lpuart1;
-		serial2 = &adma_lpuart2;
-		serial3 = &adma_lpuart3;
+		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial2 = &lpuart2;
+		serial3 = &lpuart3;
 	};
 
 	cpus {
-- 
2.23.0

