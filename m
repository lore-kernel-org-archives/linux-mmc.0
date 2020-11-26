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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD40C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68402173E
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qHdtCn/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgKZLTt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:19:49 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:2118
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388928AbgKZLTs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:19:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIvSHpt2co1Fr8joRxlVVwd4OcIPndhcrl4R0SgensiBYPZOnltZZU5M1H2n7LUVu3c3uVqzyudP+PCfdn+uWchll6DX986EU4a9ZwpZ7EAvEtwgUOgLrZU6eA7905g9qdO1IFPxbk/5dsGmw78ET6HqfgJS1SlfN27GwbTyu2HxQgxV/hUuziTiTQ/5EsEXQtNbp0j0XnYGrtMoTv5ufdc9xEdLp1w16+Vi09YY6IYY1h5aYw4p4uLEwL1zzeo8vuPJOJ2fBkHDf0P9js1cxH36adfMldH1a+0GGpuUSmwMs2jdxky5W/yiJ8mxNZIayV5Kp2qmBMvOSItmx/a91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtLxtLzZ58M6iqN68joAR3m3hkf5X6RYpHeMEr9Ol3M=;
 b=QKQUoDq/MBV5rvl9xLmjWos6Hy9WJ1MD80VBn/rgyy/paBH1AJBXzzPppTtdFdMJ8kNKspLYV/yYgeRAq5cPrHurq1GXyL+PaLEs1wif7+MvNWT0vb4iq5wYbDXYB+111hnmnGqcKlOlZJf7X0s2ryHPLtlmiw+283bUkBK9COn/A83k7zQK9PWpTWQOtv6b/9GxAGo70WmNB0LkKNsNMQcySUqTeKk6NWKFpnON1VrRZTEP/9ReuPopjFkSYHZkRiApK/agDuU7UdWVpxzvPAEd/Cam+tG1KOAhG39odLw9mhhzJiFd3Rlthzu3TbdDDuknzKn8OjNTRt40RpGW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtLxtLzZ58M6iqN68joAR3m3hkf5X6RYpHeMEr9Ol3M=;
 b=qHdtCn/BUtVjH6VgUkAJYyCYWf5uS+JSuBQVbdgWcucHQO+xQNosVkofAj/8WnQgseUcks4Pl3UNhTL9LRE9W9ZJyj97CPb7prI4hXEUoSiZOMpDJV6YClrohVlFn4nlqhVYXrD45hpdSVeJ4xqV0rQfO10IIyROvfiY8cY1LRM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:45 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:45 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 09/18] arm64: dts: imx8: add adma lpcg clocks
Date:   Thu, 26 Nov 2020 18:58:51 +0800
Message-Id: <20201126105900.26658-10-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ed302c-a557-4bb3-7142-08d891fcc23a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB520649A4204CAF4E1D49C59880F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwmeVEh0XAiOIpsUbUw4JWViQ4BjwQ5X0byDCgcf9Gu9TmlvV2PqiKF2XRE8AkPk4m357s0zUsmyESv5+gxDs9lfuXENzSUb6cyCkqelD7RIrwNNDlnetkQmFplVBCnxtJScTOqtA39Eu4f6y9OCoK/Ph4vuXsR5rjThUvBGwpDhu3IG8QdzLSY82PPyCdY3mIJQ6z4weXosfnk8qbQSnyDpVlBZNo+DXZTZ+4j5NPTbN6LuA6d5us1DhUbdXGI/anU7kMfripzmw7fjrJNK8nnDBfDz5R89yaIKKnK12A8kvxf0/zyZCerC68ui52+2yLed/uoE9t9OzuDtqbYGFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UQJvA3G78YISu3t3SptmX43/+7/Nz71kQ/aE1zR0MpuJ6lS/oNU2aOwYi5p3DjdVq40+FMvp8yHfbd1iGXxKlrTVgek0pIKWAeC5b+xdrDx8010dKcSeGe6G34HEg1IE7Z/zp/wKvo0Ox8E0rOmetvjCqX/dsVtNhbHYbvn9Ymq+UshDXe1dmN+v1XU0jHQXvWC+lP5F7n5HLL1BafbnQdKj9wdNpNIU1al8CJKsfqs1O6UY+SSE3ruy7VodPFe5EcJmqGG3H7ScmGqUKBPnTQmOvdtEVy8rDeFURCryOrDQWwEXX0gpzNmemdzgB5j2xj6tkitfaOCLqhQZNPSwu7y/6jOiF95v3neKsunorjNw2poQ2E5pRq6U98T0zXvd0o25CkmxS7nlBvwp3sYC8xEh07B8aMMsK7AqpxROteyGUxpJ7K9swMo9/WT1HjjC1bHBH9w1rRkBsuq8OK2/R7qjRtQdUOpzOGkJNwfosVbHjYhMHKlrc7RjLUh+kkA9A95K+OZMh3Z4SbqV4saVFbxDZxDDOBQyU5ynUUWE55P7qeDaYDj1Q/Bu5IS9G17IfS9LYNX6l/+cie//Zqqu/xsTp8Pur8kv+xsijUj4GdPBZB1QA5oysnGMDnoJChD7uhO0MMM7HvUw4LolA6O4mzpnD4u3/dV3wJXFRHvjMCMQQSW7HUZ2fX8tXen9gFrrVo+CQMnys8mBfEXMaijpQI7OOJovNxzK7O2qBDit/j7MngUUAOS+3xoPxl2k/3Tl3xr/Zk4oZKmNi/4TGDnDBw9YSC5AJRakpSBD7ARHGgS1bPwkhAcUbbPGys2bN+yUetwXDyH9FRBlwDxLUw5zuBS2ZyOLMR/Q4kZH3mbD+r4qrF8rLTMQcfiRWZPTiWmtPScDUDjl8AdUooHGn4NwBA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ed302c-a557-4bb3-7142-08d891fcc23a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:45.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52CWJCmxfg/Iof+W2hR8WUAs7E4XNIrTo34lfem5+ZiGgYYIWsH+K4mhyMcy3/xqgrmHN0EN8OkulVleuM8qnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add adma lpcg clocks

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
 * add missing lpcg headfile
v2->v3:
 * update to use clock-indices property instead of bit-offset property
v1->v2:
 * Use old SCU clock binding temporarily to avoid build warning due to SCU
   clock cell will be changed to 2.
 * add power domain property
---
 .../boot/dts/freescale/imx8-ss-adma.dtsi      | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
index 2c0bb822c179..9301166ea629 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
@@ -4,17 +4,51 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 adma_subsys: bus@59000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x2000000>;
 
+	dma_ipg_clk: clock-dma-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dma_ipg_clk";
+	};
+
+	/* LPCG clocks */
 	adma_lpcg: clock-controller@59000000 {
 		reg = <0x59000000 0x2000000>;
 		#clock-cells = <1>;
 	};
 
+	dsp_lpcg: clock-controller@59580000 {
+		reg = <0x59580000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&dma_ipg_clk>,
+			 <&dma_ipg_clk>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_7>;
+		clock-output-names = "dsp_lpcg_adb_clk",
+				     "dsp_lpcg_ipg_clk",
+				     "dsp_lpcg_core_clk";
+		power-domains = <&pd IMX_SC_R_DSP>;
+	};
+
+	dsp_ram_lpcg: clock-controller@59590000 {
+		reg = <0x59590000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "dsp_ram_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_DSP_RAM>;
+	};
+
 	adma_dsp: dsp@596e8000 {
 		compatible = "fsl,imx8qxp-dsp";
 		reg = <0x596e8000 0x88000>;
@@ -76,6 +110,50 @@ adma_subsys: bus@59000000 {
 		status = "disabled";
 	};
 
+	uart0_lpcg: clock-controller@5a460000 {
+		reg = <0x5a460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_UART0_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart0_lpcg_baud_clk",
+				     "uart0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_0>;
+	};
+
+	uart1_lpcg: clock-controller@5a470000 {
+		reg = <0x5a470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_UART1_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart1_lpcg_baud_clk",
+				     "uart1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_1>;
+	};
+
+	uart2_lpcg: clock-controller@5a480000 {
+		reg = <0x5a480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_UART2_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart2_lpcg_baud_clk",
+				     "uart2_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_2>;
+	};
+
+	uart3_lpcg: clock-controller@5a490000 {
+		reg = <0x5a490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_UART3_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart3_lpcg_baud_clk",
+				     "uart3_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_3>;
+	};
+
 	adma_i2c0: i2c@5a800000 {
 		reg = <0x5a800000 0x4000>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
@@ -119,4 +197,48 @@ adma_subsys: bus@59000000 {
 		power-domains = <&pd IMX_SC_R_I2C_3>;
 		status = "disabled";
 	};
+
+	i2c0_lpcg: clock-controller@5ac00000 {
+		reg = <0x5ac00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_I2C0_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c0_lpcg_clk",
+				     "i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_0>;
+	};
+
+	i2c1_lpcg: clock-controller@5ac10000 {
+		reg = <0x5ac10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_I2C1_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c1_lpcg_clk",
+				     "i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_1>;
+	};
+
+	i2c2_lpcg: clock-controller@5ac20000 {
+		reg = <0x5ac20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_I2C2_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c2_lpcg_clk",
+				     "i2c2_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_2>;
+	};
+
+	i2c3_lpcg: clock-controller@5ac30000 {
+		reg = <0x5ac30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_ADMA_I2C3_CLK>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "i2c3_lpcg_clk",
+				     "i2c3_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_I2C_3>;
+	};
 };
-- 
2.23.0

