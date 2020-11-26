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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7326C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA82173E
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKiExsSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKZLSC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:18:02 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:56710
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbgKZLSC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:18:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2gUmM3tAwW6m+XlMm4F+itMWeC1bhCpl2Vz4VeKtep7aRoEgO1BGm8n/Sfcy57Aca7OplMnYzBQ3hiO36MZxUche5LbKBmxM1K8V/1DYBmRWrXZvEDIBZAJyi1wmetKGO/GLjok/6ToVXcIonIRmdE37Zxl/X732D37ocGozHWScxrBzvR7P7uu2FWhgqjNRHf+qd0/pUxT93N/MMdJ2w+1jDzmRqVISzt6tShscm2trvm2g58g68PtX0m8Xf/cB9sbubud4YAYlMfMtFj8UV8cNhOJSB7/v0xb3WxRVLREsrPVBCV/zUCg3x1yCOFDb5PYPf4gDr47o9iKGlydoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzc4mCAstIXhqXy2MxhZ6AogDTZizW3HG+554sbs42g=;
 b=Du8Ogt0tRRUlE2gYMiNopN5BBQwY8R1szlviopCkFuGPMPmxTD74RYMdsGQ4eRQS/rDEFnz13xfWw4IgC1m9VoOWrmJNdHw/wo6uJBWROt9mwgUeH8924ODKLPjORcJgulHDo+0eMITS6bATgPgQyPYmsGu8m22unelaNMzQ1u+51hRMWJR3eJpbowA+BBfUE/8mbAMyDDJuBct/lU4trv9cEYNz9nar0QUtiiEIx/SmXmAC/S7PuajIbDJdtIh6QQ5K7N4EHWFa+hNxQJtuSB4WesNYEKKFdPhgQn9dPp7/Jsvj5XJn9VpfdY6zMit/lsEXVXZ3imG3Lzwv3W9qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzc4mCAstIXhqXy2MxhZ6AogDTZizW3HG+554sbs42g=;
 b=NKiExsSoc249y2NaSd9IEwBNs6L3hAvDLAtemRWtQdp180hov9f4CXNr7J3Y5/EaxpHz7SehQzHxE/oF6OgW5iYRsnzIDF0tYtkQYy8b9/RWH58p8Ig0c63kUCvVhL1EvefNIXnCM2iYU3Gur/J3veQwccfa87QaUvDaMTPsVJM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:17:12 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:17:12 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 17/18] arm64: dts: imx: add imx8qm mek support
Date:   Thu, 26 Nov 2020 18:58:59 +0800
Message-Id: <20201126105900.26658-18-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:17:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c816b9fb-16e9-428d-14cf-08d891fcd0f6
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206E03B5914C945FC80B28D80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGvAKrBmvXOc1bzFMM0mq5HEGt15phBbCW9lCK6ties8ApaL/X1nE6fYZf50Y6ifNGAgyAdTBNbMXABkZgN/IxJT1dMMU/vv7qdNJKwPQDmZ4Qudr2ev6EXSgotRQ8YolJriagTci5qWrcJcEJgGj04itBjQg6LS1lxXvF8WVaexyYaeof28cSnhtxAV/wmeKlHA4/IwpQ/n4lVY7ym1FxJvWAL5krJO7mNwW+oQ+VmJ9cVJk6Pib1SFN2tuk7C/5X1GMa7heTQCWM+pohipEyieHHpVOjvXQZ3rchOgL/iFdbGoFe27+yRYjEYwsLsRJWkC70aY3/dAVgDXMwMOtR9j8iFBxk86YUpetPk2ecOAw2MkZKHNrZ8c3oJK09v1EQfoE91maLNr3KxpFZKQVYEJQ+OQGTemIW2OLw0+ACw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hx6vA50LCZCHpkR/XFv/LOyFGXjKi160RWZoN0RyiwkSD0BoJSAypUodJx+AFn6Yg/dWZP6/i+rPnlbKpR+pPm6Y9DlLOtI4DhI7FMfBT1eVXubpxIMSSintLW5gOwYMkFN2NKzmYMTceGogZf5DFqpXk0/SRPHLN1jurhyIdFQSN6obBb7GGD3z5ej3kRF+XB5welWHxl67jyum+dOT7kFFL8BTF7ekYBjWhv8Z1cV0tJdHMzkZzcvyK0/+Wrr2/8v+uJj/sVS11ybSWMzKFUGeicotxG4h7aryFWAo1gtzewLSxAXBUbWvAFaOc778LASq1lPUe4OX0U5Yj/DuOWSZvUYSp2gzuuFGNSVMobN6gQH1yMbUSvhlN2zRavPLOHuJWDDoEdHmUoKHV02vGrNUk9qrqXRIniWbGSwsuwLEuT8LPu5b8HPE13KbKSBzcs/lqZRguGew7eRwB79YJ9XmOmqz/IYkpnZtBOePX9K+NQIwYDl50C64gMbtgHRNGW7pQPj7YZhmQHyaSP5f7kwVxsE0uT0xGPVVMqmxJBLXKNPgBF9T2o601gtX22U/GnfWu8ZUI7et3NvATm7ULTZ71oZzTbt9+U/OF2kx21zSLxLpMfUN5FiQPGGuyxWi7IhtwlUXR1OBw0FfyE7hHmrFirj7GnCAATiHLtNrakeL+p3Y1R9ZMLZzob9/PSMssA9Eaol46OGsksrULDgGIEbs/W4SswXJh2J3Sk0v8WNh34lHbo3J3ahDxSw6D9BIGmTFt8RKfPQc+DxbT22SJ5vWjNpJhpBRyhLvF2IQFAFwHMjlJ11SYU1cxcR5zoUWi8yQYaXqg7psLnrV17Z6iQWfM4Sq4qfLrWS2kRF4v/WCzJXNX/frtSfNMgilPIjn156JEV0EpOLiTl7si+4onQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c816b9fb-16e9-428d-14cf-08d891fcd0f6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:17:09.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G13S4bIpoj6xxdMMT/QlWUV2FxgNwVWu5pUEfuc/yaI1JAoeDjlhYd3Hu7wCLNmprFNHdTENjENRlgGbE9mQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The i.MX8QuadMax is a Dual (2x) Cortex-A72 and Quad (4x) Cortex-A53
proccessor with powerful graphic and multimedia features.
This patch adds i.MX8QuadMax MEK board support.

Note that MX8QM needs a special workaround for TLB flush due to a SoC
errata, otherwise there may be random crash if enable both clusters of
A72 and A53. As the errata workaround is still not in mainline, so we
disable A72 cluster first for MX8QM MEK.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * copyright update to 2019, minor node name change
---
 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 144 +++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6f0777ee6cd6..a0d6b50fc48c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
new file mode 100644
index 000000000000..ce9d3f0b98fc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/dts-v1/;
+
+#include "imx8qm.dtsi"
+
+/ {
+	model = "Freescale i.MX8QM MEK";
+	compatible = "fsl,imx8qm-mek", "fsl,imx8qm";
+
+	chosen {
+		stdout-path = &lpuart0;
+	};
+
+	cpus {
+		/delete-node/ cpu-map;
+		/delete-node/ cpu@100;
+		/delete-node/ cpu@101;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reg_usdhc2_vmmc: usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
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
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
+			IMX8QM_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8QM_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
+			IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x06000020
+			IMX8QM_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x06000020
+			IMX8QM_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x06000020
+			IMX8QM_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x06000020
+			IMX8QM_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x06000020
+			IMX8QM_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x06000020
+			IMX8QM_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
+			IMX8QM_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x06000020
+			IMX8QM_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x06000020
+			IMX8QM_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x06000020
+			IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
+			IMX8QM_UART0_TX_DMA_UART0_TX				0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041
+			IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD				0x00000021
+			IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0			0x00000021
+			IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1			0x00000021
+			IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2			0x00000021
+			IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3			0x00000021
+			IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4			0x00000021
+			IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5			0x00000021
+			IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6			0x00000021
+			IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7			0x00000021
+			IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE			0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041
+			IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD			0x00000021
+			IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0			0x00000021
+			IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1			0x00000021
+			IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2			0x00000021
+			IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3			0x00000021
+			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
+		>;
+	};
+};
-- 
2.23.0

