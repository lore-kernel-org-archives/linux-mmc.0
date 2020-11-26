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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D0C64E75
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7590E20DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHT8xLJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbgKZLRK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:10 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:2118
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388946AbgKZLRJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyq5M2saD9E2Rms40jEViwpereETSV/gUiAef8vOLx+R+/Tx34KOXsGR/3r9w18exEczu2NQTMxOG85ekvNU2LUC1pdO2xhGBplEMpOBqGviGacah6ROuFFtEtsH97LE0AdlMqVhdRKw0q1wA1xhXZIghllkNr0vtJwFROuMXFqG37BRv/pewgokpwl3NSCD+BoaYOPcxZ50nfElg/VWtp1pH8XBqDXCOmnXD98C4av/uSMKYw7+s6aQEbD6YAv4ZZb5aFUx6BEK888ZWP87dSyJJUREBtc1ehnK4eYd7UgiQFiHKjL+HKvBQy5Xyk23eePRxG/l+FGmFb2AkV9hTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atgUNxJJoofm3BJSmZXvsBvsqlfZV1aRkxkvM+lQtXM=;
 b=i+9BqsJhRolwmiXNxa7mr1voAZhbZP0KCTps5JcnVpCFPEOQ+zeQQrbAnTk57EinSEXKbaYAXH2XkYvVBqDU/hps181Z8i6dD++X/hKE7AtoE59JY/47DxHKKl4yadY/iyAuRqsvlQqVWQ1PfJatR1vzC3s30AgH20gaXAChaJ8Qx/xQB6Q+v5LWKMWP7zxa4jzSjag3P0FBEFVak+Q7rAygAJbVZj4WexMHJiYRpAaH5HyFR8QELvjxFirJl5E/KwLzbr8u5US3xpySf6PZLbhj1sR2VTlDLgUMk2+zoLwf9HutMfts7G4SCMiW7owwANS5JawKPY3Kr4GjpXfHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atgUNxJJoofm3BJSmZXvsBvsqlfZV1aRkxkvM+lQtXM=;
 b=iHT8xLJjx64Lqipp4YdcBvJ90/01SzklpP9+J7u9OazymW1oQMEgPwvxl9glf70l1JPpOB7lK7B83OK7MksyORAilE6LONGMvuKs7sJiBN2NypuYPgkPkorlmQfXmA1wmZ6p2UIux04PRKeVYqbFscKCKUv6AyANml+oHyK9jOo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:41 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:41 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 08/18] arm64: dts: imx8: add conn lpcg clocks
Date:   Thu, 26 Nov 2020 18:58:50 +0800
Message-Id: <20201126105900.26658-9-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5045402-3299-4334-1800-08d891fcc034
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206F118324A1FBA2DC7D2FB80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRbsz10X+0MlF/fJYRCE6ZYtxHIy1vZ8/MSaBXs5FlHEIlyptWOluyFVEaglGifZDK04ocZoJ/v1q+pPNZx+mtU5EVW3wuQPjGwhsEwv6ilfk0BrjLgyttl3gWPhtHKR5XOU6aXq1mNG/0HuX+f86WwYIUI+5JARRV3Hqdn896UgsGPgpTQBEbnacf/aZVPlYQR8r2fzmIprW2fR1FJGce596vX4xkhwhRIXyeTHbsQI/72EvvrIOH/I9M4ZhRB1hH683VwLoZ3bVTHHbpueY2OleVtoR6avuaIiJMevOvahOPA42X7PCkvwigbyPvS06wQEE9ypu34HnpASjuI3Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZJc6TLHp7sI0SmRcaf354nK99ySjeYOpFaL5vKu+fWNNdOEeBvrrGVz3+lxLhaOejLstytxzfj0xsUyGSl+/rHuAUEqwgbXQaEhQet7BEA2BjoHXdI0h+IP2BnawkBYw/CrK1J/YVVnfNQoRUAVHO0vVA202DWgM4SDQ2DHP4n4G4fdhYzhul7KdHXpU3kkDyG39TTyqbOHLqVcq0cHdhwWUGiHHUtRw7POmWNEOKEiMbixO/tcXu94ovMy77m4ZpythWkiBBYm1Bkvzp3yhpLZXNeZQ4Hf3ZjyVJDQrvkytLnitm+73dX/4C8if+A38NiHxO/dlInTxw3xfigDLqsJ3Tk2C2t4Vhggo5XX8eW7t3Tf/FhqbMcxkp9vxBky3/TWiDF2Hcu+er8RB1UBnN68piwzhzlwyH5tmOHruE3uSfMJ7MVLYFsWTsfkh42oI4R2FAXtSV0NdseGc8PkImUyfvjHaE0xSXEBH2tg4OdNZ1x4GwVJgJ56ExseKVP96FvNlBU9UtEPZ3YR3tbXw7dmhQ5lmdoS3MAie7kmcyzl+r2VcU/Q/nP8heoZIrpHhqH8ankEwpa8tCsUrPRIMY1MvvzBznw1IxoKJtE3oix7Vo67PTP8bFA1o5Q9/Q44lPI1sr6xcet24ImuNwEDqSEjhup04pDZoma7EmnbO0s1r8oLTrZB/inlPxG/gch3YhxLvejH2iBN7aA1AR+5uRQDtwXEPM53yhLvCB32f1uMs7tz9f7whM+Wm1+zcJPRYVNqxS6Etm4mlhiGNyTifyOY/B24FBXi2D6vKV4BeJ9AQT2Ma4DeyMFzSM84SsC19+BUCgbw2v8yyuK1vZ6Ibdl+UNPlvbmKC5t0sL7fD9SIRMhzIPv1taWl6+FtkXVMVObbrj9Andg4hwUG7pFem9A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5045402-3299-4334-1800-08d891fcc034
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:41.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnZ9YayGvtuemd/q8wUwp4T3l2FeeB2I2Mc3cSrkzg4ASEG8L2J6il4jg6/obf9l9Ofz52VCOu+CHg/Q2TE25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add conn lpcg clocks

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
 * update to use clock-indices property instead of bit-offset property
v1->v2:
 * Use old SCU clock binding temporarily to avoid build warning due to SCU
   clock cell will be changed to 2.
 * add power domain propertyv1->v2:
---
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 104 +++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 8691a43882fd..4220a5cdc249 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -4,15 +4,34 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 conn_subsys: bus@5b000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
 
-	conn_lpcg: clock-controller@5b200000 {
-		reg = <0x5b200000 0xb0000>;
-		#clock-cells = <1>;
+	conn_axi_clk: clock-conn-axi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <333333333>;
+		clock-output-names = "conn_axi_clk";
+	};
+
+	conn_ahb_clk: clock-conn-ahb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <166666666>;
+		clock-output-names = "conn_ahb_clk";
+	};
+
+	conn_ipg_clk: clock-conn-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <83333333>;
+		clock-output-names = "conn_ipg_clk";
 	};
 
 	usdhc1: mmc@5b010000 {
@@ -83,4 +102,83 @@ conn_subsys: bus@5b000000 {
 		power-domains = <&pd IMX_SC_R_ENET_1>;
 		status = "disabled";
 	};
+
+	/* LPCG clocks */
+	conn_lpcg: clock-controller-legacy@5b200000 {
+		reg = <0x5b200000 0xb0000>;
+		#clock-cells = <1>;
+	};
+
+	sdhc0_lpcg: clock-controller@5b200000 {
+		reg = <0x5b200000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_CONN_SDHC0_CLK>,
+			 <&conn_ipg_clk>, <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>,
+				<IMX_LPCG_CLK_5>;
+		clock-output-names = "sdhc0_lpcg_per_clk",
+				     "sdhc0_lpcg_ipg_clk",
+				     "sdhc0_lpcg_ahb_clk";
+		power-domains = <&pd IMX_SC_R_SDHC_0>;
+	};
+
+	sdhc1_lpcg: clock-controller@5b210000 {
+		reg = <0x5b210000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_CONN_SDHC1_CLK>,
+			 <&conn_ipg_clk>, <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>,
+				<IMX_LPCG_CLK_5>;
+		clock-output-names = "sdhc1_lpcg_per_clk",
+				     "sdhc1_lpcg_ipg_clk",
+				     "sdhc1_lpcg_ahb_clk";
+		power-domains = <&pd IMX_SC_R_SDHC_1>;
+	};
+
+	sdhc2_lpcg: clock-controller@5b220000 {
+		reg = <0x5b220000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_CONN_SDHC2_CLK>,
+			 <&conn_ipg_clk>, <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>,
+				<IMX_LPCG_CLK_5>;
+		clock-output-names = "sdhc2_lpcg_per_clk",
+				     "sdhc2_lpcg_ipg_clk",
+				     "sdhc2_lpcg_ahb_clk";
+		power-domains = <&pd IMX_SC_R_SDHC_2>;
+	};
+
+	enet0_lpcg: clock-controller@5b230000 {
+		reg = <0x5b230000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_CONN_ENET0_ROOT_CLK>,
+			 <&clk IMX_CONN_ENET0_ROOT_CLK>,
+			 <&conn_axi_clk>, <&conn_ipg_clk>, <&conn_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>,
+				<IMX_LPCG_CLK_5>;
+		clock-output-names = "enet0_ipg_root_clk",
+				     "enet0_tx_clk",
+				     "enet0_ahb_clk",
+				     "enet0_ipg_clk",
+				     "enet0_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_ENET_0>;
+	};
+
+	enet1_lpcg: clock-controller@5b240000 {
+		reg = <0x5b240000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_CONN_ENET1_ROOT_CLK>,
+			 <&clk IMX_CONN_ENET1_ROOT_CLK>,
+			 <&conn_axi_clk>, <&conn_ipg_clk>, <&conn_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>,
+				<IMX_LPCG_CLK_5>;
+		clock-output-names = "enet1_ipg_root_clk",
+				     "enet1_tx_clk",
+				     "enet1_ahb_clk",
+				     "enet1_ipg_clk",
+				     "enet1_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_ENET_1>;
+	};
 };
-- 
2.23.0

