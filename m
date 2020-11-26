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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE9C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31388206B7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBtdXz/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgKZLUY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:20:24 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:36938
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388890AbgKZLUX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:20:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6gi/8k4RZthylbEmtMdfziAmfgRfILt2oRUHdBrsBzR+7GxQbc6qvvXBqtR16yaRgzyBl7JILhEZ76PWfaBZjh+fQ2eqffraq6oXvBmUl+JTFK0M79mKp+0y0RfZzcQnRZVTvzRovr0pZT1VAlJtfJ2/rHV8H9ebzhKA+nnRW71t1FAOzCtajKyVgO+RnpDuM8O4n7j4uVnTVVOt0+OtUqoQQdBjQiIxtv8G1xPZoAZXor8FunwLdzmPSVTX+uKRp9k3Yva41OyN0CBcvOAVkqDMSvp4gg9Y4gnG9ZrBxqtydtb3d8qPAZ1jor4wLseE1N8b0su03ek3BjAIQoHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzaJfegNyVimKKM/ca6WLBlc+EqPbPDJcxbkU7WtxiE=;
 b=jpe0BeFml3hC8VzscSnaSK3wwlMfUWn6Fippky2nXgmuEilJ9OfzJiJRqVKEeMqNAXCi4ZmLSuiWgL5WO96iXf0VVr09kG4efq6ciawlp4e3I/fvpUkGGw/dpegj7Qjh7KSc1ZYNo+aBvlUVcwBGrnha/8cvbwaSEx4wOFm9sjDWxXjpGyavEE7ix33x0Ci2ICG7/jqrMREh4e4Q9koA6AgSKcAM/IJ97DBkzqSCvJAUOrmhJLJeEQ+TcAkxLjZwhQyrsJ+ueFVsOyKT0HH1fmc8AsdnTvWA3QxgrLXuzuxZebVrUW+ZYyCfmzkeBum1jX80mEwVdiB1bBDzW7IwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzaJfegNyVimKKM/ca6WLBlc+EqPbPDJcxbkU7WtxiE=;
 b=CBtdXz/k4oIybG1gEyZ9Ez5VjALkf3BZUG1j+4tYfdzCcY5HA3Y7eJLtEgpsDV40j32v63m+ZkuRih1MAYHmDeuQWNNrKwIKd9K/9df93/N7CeJSPw58jP5AhS4mWTEsLCvceZYHYFoh1yDW7gHftR2xhaEnpzZz4qXFjWzpmfw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:38 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:38 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 07/18] arm64: dts: imx8: add lsio lpcg clocks
Date:   Thu, 26 Nov 2020 18:58:49 +0800
Message-Id: <20201126105900.26658-8-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aabee84e-95b1-4351-4999-08d891fcbe2d
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB520644F99791AF3702CCD6BB80F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7w6lfWMOxdqok8DALi9u2SyWV7zeebvgVMun/hZxjFHfQ5oDw17unLxPskFScG3KjjLvL8VKBIn7AJjbtPmPyeYlY4IuYVEpJktyfcYUWCABJ0gJ/xL3atH0tPwHeRis9v9NwE76Si/gMhq1zkMvyuDOthxQEDK4FylmzJO9HkJoYKqeIMgAenagDSJvX3MvrxcFV4/taqbIXEIy1TL/O557As/3ehgUV9jXGBEEUv9ePUXMJHcZ0aLUz2bXYIY+HM1IoCZgP1ptJNatppbf48a6/7jhdUM3B7Qt+fp/+ki9xoUtCj8sb1EmPb1EvofeOCxxmwygXSCrgdESPwrabQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GGlKepFYtSAHAln5NkJUv/6/oXTqR3zQoffUHgjFihxyQv72R6goJhQDPtcFfowEQf0ZbV8xKgtPix0MCjDgJu5I1e6DIk3OeiRWs/l1S8H0DDwcRAs3YN2wKDaC7RbvJGuuri+/K6YHzGyh5C+C9xMlwVO7rq60EtbNds5dI6PwNnqaUE3FqLzx4HHh8VwT4wz1MtEFYAIb3Nuh7XZ96JyCtHTk09576t5FihgvVD+pBcC4Ps3LjKUc0OGZWsYekCJO5d6xgh+AAtc4XmE5dBvfCupCDn6VwNsuqjRG+TTsSyam0KQA/6vK06BP7Wb6N8/GHTcB/q2RGwMSl0kImjLJ5iF5+Ba/BfW/oKBi33ATGWaLpf/LE73ZJ23tS2wqpBCY8X+dNG+3QBPxJT/34ajPoPUZ5yD7+YJ0fMZNFDS6EnSfxuMV4OvCQ5EAoxowu9Y4S1dlJN9dnXRPtgINlbHKxSXbLnjjJXGx68zqTBKJr3FT12nd+q9URo0LN2Poquf1bBJjYMfn65j1rA3bSvielRq1Kw+Qlx7j6sGgMWWoMFn3hHbVnUyeW+QRiI+bJ+QaXuR6Ig65zHwccFlrKWydVlCiT4ndGNQzamlP+0OWOcX0nvkwiSbOH7y+9mNB67lroMZT+YrQMQpU6ps6uKUP7LQ0dOqUx2Y7EWEuVRFYv1iqO0OZ5vNiYp6iv07nTEO36sHAQOYHqbuU5n/vhH4k3a5EGyGEsPspEm+s5NLsolc0FFUGsjJnQN+EwAMm3EnJDWm53Ne/RCnbRatPsSb0KjOeiuaA1P4/J3TfZP/PRek3gcGj9KO3h9Ly7HxZqqSz7oI9ZmaQ/zeMykGJ2eBs0V8fq4qVO/xAm1/EUpgVYmAHj/u7UgtnNS0wRdpUVNEepX7ENez0Vp7/HABeAQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabee84e-95b1-4351-4999-08d891fcbe2d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:38.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qI6oQhyGi1FpzjxTFr4EDEwPOLzXZHLiqXnjQbIwxSSKPOhREdonsQcs4I94Q8TkwwR5seDPBhCRlA2CYJoHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add lsio lpcg clocks

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
 * add power domain property
---
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 156 +++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 70902f56cdb1..babe6c3e2c76 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -4,12 +4,29 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
 lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
 
+	lsio_mem_clk: clock-lsio-mem {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		clock-output-names = "lsio_mem_clk";
+	};
+
+	lsio_bus_clk: clock-lsio-bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "lsio_bus_clk";
+	};
+
 	lsio_gpio0: gpio@5d080000 {
 		reg = <0x5d080000 0x10000>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
@@ -131,8 +148,145 @@ lsio_subsys: bus@5d000000 {
 		power-domains = <&pd IMX_SC_R_MU_13A>;
 	};
 
-	lsio_lpcg: clock-controller@5d400000 {
+	/* LPCG clocks */
+	lsio_lpcg: clock-controller-legacy@5d400000 {
 		reg = <0x5d400000 0x400000>;
 		#clock-cells = <1>;
 	};
+
+	pwm0_lpcg: clock-controller@5d400000 {
+		reg = <0x5d400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM0_CLK>, <&clk IMX_LSIO_PWM0_CLK>,
+			 <&clk IMX_LSIO_PWM0_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM0_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm0_lpcg_ipg_clk",
+				     "pwm0_lpcg_ipg_hf_clk",
+				     "pwm0_lpcg_ipg_s_clk",
+				     "pwm0_lpcg_ipg_slv_clk",
+				     "pwm0_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_0>;
+	};
+
+	pwm1_lpcg: clock-controller@5d410000 {
+		reg = <0x5d410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM1_CLK>, <&clk IMX_LSIO_PWM1_CLK>,
+			 <&clk IMX_LSIO_PWM1_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM1_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm1_lpcg_ipg_clk",
+				     "pwm1_lpcg_ipg_hf_clk",
+				     "pwm1_lpcg_ipg_s_clk",
+				     "pwm1_lpcg_ipg_slv_clk",
+				     "pwm1_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_1>;
+	};
+
+	pwm2_lpcg: clock-controller@5d420000 {
+		reg = <0x5d420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM2_CLK>, <&clk IMX_LSIO_PWM2_CLK>,
+			 <&clk IMX_LSIO_PWM2_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM2_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm2_lpcg_ipg_clk",
+				     "pwm2_lpcg_ipg_hf_clk",
+				     "pwm2_lpcg_ipg_s_clk",
+				     "pwm2_lpcg_ipg_slv_clk",
+				     "pwm2_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_2>;
+	};
+
+	pwm3_lpcg: clock-controller@5d430000 {
+		reg = <0x5d430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM3_CLK>, <&clk IMX_LSIO_PWM3_CLK>,
+			 <&clk IMX_LSIO_PWM3_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM3_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm3_lpcg_ipg_clk",
+				     "pwm3_lpcg_ipg_hf_clk",
+				     "pwm3_lpcg_ipg_s_clk",
+				     "pwm3_lpcg_ipg_slv_clk",
+				     "pwm3_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_3>;
+	};
+
+	pwm4_lpcg: clock-controller@5d440000 {
+		reg = <0x5d440000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM4_CLK>, <&clk IMX_LSIO_PWM4_CLK>,
+			 <&clk IMX_LSIO_PWM4_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM4_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm4_lpcg_ipg_clk",
+				     "pwm4_lpcg_ipg_hf_clk",
+				     "pwm4_lpcg_ipg_s_clk",
+				     "pwm4_lpcg_ipg_slv_clk",
+				     "pwm4_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_4>;
+	};
+
+	pwm5_lpcg: clock-controller@5d450000 {
+		reg = <0x5d450000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM5_CLK>, <&clk IMX_LSIO_PWM5_CLK>,
+			 <&clk IMX_LSIO_PWM5_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM5_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm5_lpcg_ipg_clk",
+				     "pwm5_lpcg_ipg_hf_clk",
+				     "pwm5_lpcg_ipg_s_clk",
+				     "pwm5_lpcg_ipg_slv_clk",
+				     "pwm5_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_5>;
+	};
+
+	pwm6_lpcg: clock-controller@5d460000 {
+		reg = <0x5d460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM6_CLK>, <&clk IMX_LSIO_PWM6_CLK>,
+			 <&clk IMX_LSIO_PWM6_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM6_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm6_lpcg_ipg_clk",
+				     "pwm6_lpcg_ipg_hf_clk",
+				     "pwm6_lpcg_ipg_s_clk",
+				     "pwm6_lpcg_ipg_slv_clk",
+				     "pwm6_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_6>;
+	};
+
+	pwm7_lpcg: clock-controller@5d470000 {
+		reg = <0x5d470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_LSIO_PWM7_CLK>, <&clk IMX_LSIO_PWM7_CLK>,
+			 <&clk IMX_LSIO_PWM7_CLK>, <&lsio_bus_clk>,
+			 <&clk IMX_LSIO_PWM7_CLK>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>;
+		clock-output-names = "pwm7_lpcg_ipg_clk",
+				     "pwm7_lpcg_ipg_hf_clk",
+				     "pwm7_lpcg_ipg_s_clk",
+				     "pwm7_lpcg_ipg_slv_clk",
+				     "pwm7_lpcg_ipg_mstr_clk";
+		power-domains = <&pd IMX_SC_R_PWM_7>;
+	};
 };
-- 
2.23.0

