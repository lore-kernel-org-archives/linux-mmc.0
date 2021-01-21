Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42951C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83B8206FA
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbhAUDyJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:54:09 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:35302
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731688AbhAUDWS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 22:22:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fwx+MfrRiUU7mGhX3lB3CL1WgZ0TWVqwcS0RjAzMvTSQeFtVCmVPYtAz3k91mwnyoxjMaJWBf7N6pGknh7VV8NuwJEb5XvylX5gFyXKAbI+gJdKPBN8JOBExXVFbUfrrw12gi2ChxzAY4lMeIFhJNxgip0teMtPq/nsJZAPQRuRztyiRHfnxwMdgp/z0zonKbHMNgWxU2v6OhabUIPgybujadcleXp0/+M6WMom5HwobhIYZyDcWmAwpyuNf29MauVeM4QBpL3ZfO7j28Ab5M9fWCYgo4j21wabd7y6bp7hE2Pe5VcDZ6B0sQyjUBY8E5hTrzDLfpHi1m1jJZk6jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZVOUHJDqLF+mTpugRsqjottmEwzyYxavVvEC3suiFs=;
 b=FhMmCXgUmnEitLKWiF3l0KIVE9JKyTQDBh0HypmMu7AsZTrdk1/Z8IocUI2SDXAw7tD1b++km5JGIUm4iSWmqkvv2hhlgXbkZfdfe11nR1mHxxGvuytbb3kakTPYKCWSUmR2AAi54i+bcpJ/SxmUhXk23AiGPBq7Max9qoj7WPyWCgZwxosc+J08MJxNXIbN+6dT7DMLxoL+J5r942kuxjm5LPx0IG2FM1fR4s4o6MMZO0LuMUnJbdtCNJ8eaqy2ln24bnqx1Y1KqBsjAJTqOHYXlPOn6QlCt/ez7spE7hp+tIrpZMJLXzZFf2tm87pK7zadlhYVa586mq/vC0PBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZVOUHJDqLF+mTpugRsqjottmEwzyYxavVvEC3suiFs=;
 b=PnLXnPI6S/VFg/92azyMcnszpwbqm7t7cFI89fgG9Jv6uuMCtNVoxSvo1vC7GUeTPS7GeiAa+9AsNRVoDm9O+PSUHYJpdfYZAoSn3ou5lZ/qHXhocUNKw+lE/Q3Y7CObun/82EMkzbcL4dVTVyRKdWxA9EtfDy5XOlFPPQAFx9A=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 03:20:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Thu, 21 Jan 2021
 03:20:29 +0000
From:   peng.fan@nxp.com
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        adrian.hunter@intel.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] arm64: dts: imx8qxp: correct usdhc clock-names sequence
Date:   Thu, 21 Jan 2021 11:09:52 +0800
Message-Id: <1611198593-16287-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 03:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77201304-2969-400b-eceb-08d8bdbb80df
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858C15D44641D8CFCEE5C3188A10@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1fVEbKGoctQ7Ue5ZZokIRyJNjR5U4SEV9SJlkOJ1nyv/eM+DEZhknRFeHrR2XJnyUD4ydcd00a0dI7TVO8nksPLxhG17F9MZ0r0jYHGzEFKoIk8BUnbMc8cAcHtJR1jdLjbeCqQF+aVPkCyroVw9vPcXqv5KsNpiaDbRob+n8v7knIHSUoWoOhKJSCu1rxrj4/y6F76W4nf1oThypJzioMIHtapgzIBl8gA4WdC0ruk48aerXQrugi1/8EsF5Sbeu++Jv70BZ0Oeg3eNOHRs9mA1anGZXiQ9IQkkqAEqnE0fMFJbtzR01R/dNJGigzaZqStSG9LkkzCkDZ5yyPuYEo6fDK/VphVtLkvH7YVKM006UvBy2qsQ5iVUOwsWQl3k3r5TvL/nkv4kjPyBlEboFMl/5yJXC8BO3TOhPfSidX6VGrTVN9j+SpScSd/IK+kzSjmDR2zin7qXjCEkS3kG6TaTFuFLnTO5mcbmZx7HMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(36756003)(6486002)(8936002)(186003)(16526019)(6666004)(66476007)(7416002)(316002)(6512007)(8676002)(5660300002)(66556008)(52116002)(83380400001)(478600001)(66946007)(2906002)(4326008)(6506007)(26005)(956004)(9686003)(2616005)(69590400011)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rN8dcUIsvHoS2OteaLZRHskzAfJUttcqX8lT6hbyj5tJlIsKbfWQdoiMhViW?=
 =?us-ascii?Q?DfP5VBO/rYvGq6h50y+J1eDgD13z3AY88cl8VdZpVLPOWvonWTIBJZdyP42q?=
 =?us-ascii?Q?OLOqE7esx0J9LWzu56CP0Y+4BXwdDfDMy4UvhIxHzOz0vewfL/cjSV8cNqRZ?=
 =?us-ascii?Q?8cSOcZ+ZCXikeG5JlaGujTsPixC0RgANLo3BaZufeXibHKHI22LG5gVfYA28?=
 =?us-ascii?Q?FrOomd/0V7MTSa1Td+iOva6lXczwG6QtXw6wFlT9ppQEKHaVbCoK6ZJiHAop?=
 =?us-ascii?Q?w2W6bdlUB7oyW3LsBs2Fr1wkmVQ8P3q9dLa0OsM+DrzgMUAnDSOv1Eup5tiJ?=
 =?us-ascii?Q?0KB1m7uuYeg7ma/MMeMk7iDp2mYI4o1lqHByNBdFQ4LTn64RtSchYoIbxK8f?=
 =?us-ascii?Q?yTSWuiWEIRCx9wh62jQGXuWJbtAyLXza6p5XSJsyW+Fohpz26SP1y6xu4R5m?=
 =?us-ascii?Q?TxwX3bOq2g+NSueifyDrZQOkrvCDLn/A5t37g56PSId9rpx8snIvS7MwXVIm?=
 =?us-ascii?Q?ZTW0k3APUnIvo8fpVWhgzHKlupG1wLvvjD/PR2bxVbKImChjkx2xhQHRsGc9?=
 =?us-ascii?Q?83cwciZDW8GJXtElxMjEDRq3dmLLhBaKJ2npzLLMT1dkW94h96Q0Rdbmw5Uw?=
 =?us-ascii?Q?3xXvU/BQvUHVgR0TxDiH4bRtBAmcPtpeIswU20Bhej12bZAnOy0GYx5qutw+?=
 =?us-ascii?Q?0BY58G1ZwBIp6Kx4nvMmje/C4QqYl1XIADTkqX7ED2/mlj/6S+Cu2EsI6iYk?=
 =?us-ascii?Q?Zcpwvx5fFwvKJKp7OawtDXaX/UmLsoeCVWsQ8JKY6cR4MdtQZJtJ/B/ms4zY?=
 =?us-ascii?Q?wCzWuRd90C4pnesEksqkXqCwuVKN7JTtHDmdxPKqQqyaMKOhZHnd2aYOUlXJ?=
 =?us-ascii?Q?sfCQA9X5/fG8RSBA6KCzRd5Jigt5vQhe+sMLoksI7HZYTZbURQikHQon3wvd?=
 =?us-ascii?Q?SIQmwuzCWD8FKWcy0AIiXh18fC+6HJ3u/DvRDm2dJwRlwmp7vwh+9eNsrRGc?=
 =?us-ascii?Q?OjY2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77201304-2969-400b-eceb-08d8bdbb80df
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 03:20:29.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8p3+vpNPtYKdr7L9+eOdSLV9RNX//L2Me38C6V4JjOFUa6pt9c4RHr9qEyazc9FWZsE7SdTgZ5XLRvF+44AFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per dt-bindings, the clock-names sequence should be ipg ahb per to pass
dtbs_check.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index e46faac1fe71..1d522de7b017 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -366,9 +366,9 @@ usdhc1: mmc@5b010000 {
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b010000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
-			clock-names = "ipg", "per", "ahb";
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>;
+			clock-names = "ipg", "ahb", "per";
 			power-domains = <&pd IMX_SC_R_SDHC_0>;
 			status = "disabled";
 		};
@@ -378,9 +378,9 @@ usdhc2: mmc@5b020000 {
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b020000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
-			clock-names = "ipg", "per", "ahb";
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>;
+			clock-names = "ipg", "ahb", "per";
 			power-domains = <&pd IMX_SC_R_SDHC_1>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step= <2>;
@@ -392,9 +392,9 @@ usdhc3: mmc@5b030000 {
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b030000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
-				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
-			clock-names = "ipg", "per", "ahb";
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>,
+				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>;
+			clock-names = "ipg", "ahb", "per";
 			power-domains = <&pd IMX_SC_R_SDHC_2>;
 			status = "disabled";
 		};
-- 
2.28.0

