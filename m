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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD8C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F37206B7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPNUZWml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbgKZLR4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:56 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:56710
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbgKZLRz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsDFlF7HJEBAAM36L0ZxktYdZsIGmEMGG/Ee3cPq8wImiUqy8r/xqK1VC8oPtQW+i5sgMkPUlxz4rGKoUVoZspZfEUTwRutLYQC6HjoeC7CluGoQPuvpTAC9G56tt4iZjJ60xj9epIkUI2G/sUbVg7ZfDUB+eq7X6pe6qIL48VzCbR7YtX50BjVFzpBSrodcY1VjcxH/OEVfqXvYS1j1hRvWPE7t9X2sfIyzl3FMOkrrAl7bAFh0JAZIhNkjMPEhmp0ws/XAuxetBh7AJyLFaDaY7GJo1JcBdXSELJudepmyj4QeJOl4wfE7/SUPsD/VznAfV8LVzyBYRt2H6pXCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/QX7pvrDBPuunUeGRpZP4kA2yTN60H+ojHjit5PJ0I=;
 b=Bcs2KVRbn38I8aBtWY7HaXAg/xkkrYKBOdyesRCt+xrlfBnUT/O/Rs4i5NdzlGzN1Tp2gdYazw/kQ0kPWBRJCXjsJwvtwhEcMvfyhuMeDSt0Xufd1XH3bNg3/FFrAHhWYcAr32hx7qykhZoEPVMu4kOcTOAiIgfNYBF9a/bHBxkWwy/PGHJG0SqO52xoUX7UamM46FZ7sZ/BGOdO//NWwJzryGZDyZ90vgtfelKN1xgO8XC4jdNieQfzL4jaEersqtRzFRON57kpSk2hNwWgLrOFj8Alts3YjahXFuMqjVCn8WvDmWi8aqo9nGBfxw/8AjZUGNV48LadFHr+RGNPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/QX7pvrDBPuunUeGRpZP4kA2yTN60H+ojHjit5PJ0I=;
 b=CPNUZWmlr0mNHWhX/daFZoi00wqlG6rsNsxCPbn4oH1exoLgG4ACHswnJzsocwjnqRwVdEBsfrIZ0Q0u9RshuszRQwMDDbzrgkY1gokp3lva78TDMQM47bbWWBglyxDxaZX5SwuyilIlQj9/eXVvnay1j09GKGDZCvdGvtbllo8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:17:03 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:17:03 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 15/18] arm64: dts: imx8qm: add dma ss support
Date:   Thu, 26 Nov 2020 18:58:57 +0800
Message-Id: <20201126105900.26658-16-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:17:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9694f9c4-60ab-4f6d-b8aa-08d891fcccee
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206728676F83A991BAC3FC980F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L86lgPQAtcks90m6emL5pfNinPQgNJUM/G67nsE0Uu2iXFkpyZeEMLdGCupxtOxD5A95oTSf3uE1UPMRuGh7jPXku7UExY2S87BL9UzAwEPVXkw3BikC5idMZ25nCdvCwCdjw7DuOXYjUyqkYJMNPbVpwht4GgCZ40G6EIElXVj6WjtKUPKb6GZoBkkyXfH0i2tFA1K98qLAQq41OC50Yt6KYFzf4DGf/SqW41wKWD/gP/Mh2lnBP/1NEVEfaH59ANSMhmP8yJ4y3hrZw5OgYD8FPJB+oVJTNxx9iVKKUqcpKJ9n6oo9wP5DcwhA+zzeCVxSMzcH1aj3MD6+xrzRpiX6nEcOyoAbp3eeV8k2vRwgO2QTOQ+gV9hTG8oTzWZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VzqgNZYuctgctNzzMQOxFItGA0ylcrthGQtm+zFd7D1uYK+C6QFt6SYV31/i3yd8WNbF8893fnwbAcPGcedE06RDN2s3RcxRdYTbUVk20nlcWUF0cgAHK7B4XhFhzxzVPkvxxfFzqKn7g2bxtPMzJqJB5aKmMn+kXWoGyx+vmTWbevt7DzUMNvpHmZVqIiETiBzXvZEZvj+MWLrMYeB7fJSfU83p/T9D03PH0zq+VOYZnP+/B2UPf8x1/QXCul5e4g/nLOFmEMR6SrsosiXZWSXbchBAoPr3kXNB7rEv2yQcGMM+iQ4N0Qrr1aylwC94IyCH8BETwfnrAj5PYAjnnStfJ1CB+ig6w9+K6zk5bdAuv78VYJL6q9CXC2zNG4xm0ZQ1RtA1vZ2VkvKGf8IE8CYZJsxthHVe29HbFwlFxt+m+zGz8WnxI7GqqiroOu3Tt3uEI8EiMnOGKVC33gUj+rrCAPjzRN1DtYXBzDp/eMcQmN/apu25RLDc4D3Tz4U4XhRYGzakjTdyKLOhaQEzViodN9mXy4b6xHqtvex5p2kyivoCpNY0ITEtRa0YpTSJTu9XAlx89WEjQWnDI0pX1arY3jri9Rq8sN34OGWanw5anPPi1e/DDW6vqiEIii4knHQuQARI43h/7YIJj6/7hqlpA+JAJEErhsXd4QSQblu9pfZEribsQe5n0rrZQ1SD+3D9z1IVYk28s4Mdi/hRLOscAfLxjb0EHckD8Rjq7W7HOo16f2KXC4/hmqmk31HvuOia2Bo9TuEnVgGBI5OVspxIpoLwrI63Hf/KXM2Odi5GG3Bxo41+/PTmo3oMS5rmxVUUcd229VvETMpaSsw5Bb2OBpgO60YS1sK81i7MjWTsBbNtm8rWik48mKtamZ1g7mRTqQbakwrNELOFyqppHQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9694f9c4-60ab-4f6d-b8aa-08d891fcccee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:17:03.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZErEP5Knro2/wtRVZz2DOBGxP+2btNOmUgieuWUpt+RVG5uTOmB51/v3Zi05NiNkZTOXy2/FwszYCb6uq/RSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The DMA SS of MX8QM is mostly the same as the DMA part in MX8QXP ADMA SS
while it has one more instance for each of LPUART, ADC and LPI2C. And unlike
MX8QXP that flexcan clocks are shared between multiple CAN instances,
MX8QM has separate flexcan clock slice.

So we reuse the most part of common imx8-ss-dma.dtsi and add new things
based on it.

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
 * use new clock-indices IDs
 * update lpuart fallback compatible string to fsl,imx8qxp-lpuart
v1->v2:
 * change to the new two cell scu clk binding
---
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
new file mode 100644
index 000000000000..bbe5f5ecfb92
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&dma_subsys {
+	uart4_lpcg: clock-controller@5a4a0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a4a0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_UART_4 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "uart4_lpcg_baud_clk",
+				     "uart4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_UART_4>;
+	};
+};
+
+&lpuart0 {
+	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+};
+
+&lpuart1 {
+	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+};
+
+&lpuart2 {
+	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+};
+
+&lpuart3 {
+	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+};
+
+&i2c0 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&i2c1 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&i2c2 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
+
+&i2c3 {
+	compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+};
-- 
2.23.0

