Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8908CC43331
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6575264ED9
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhBYDY0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbhBYDYT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 22:24:19 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C34C061786;
        Wed, 24 Feb 2021 19:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIfbN49Deo4GCueJ7zP4725uiPqm4zzI5o2d3iS8Ceopj5vr+pwOrpVFccTyqUgaZyEateiGuJ7X/EYRVeiG2F8DucD6dGcDvV60PB4cuO4A6xckrDQ/NCewdmHoBhzzQjDkYbeA2qdX1S1DxePt35op9R3rDxjPmZY1JPwE1h80uxj4ld8zA8x+XElYBRfcc3uD3mDftjUq9vos9QmfxvDq8V9qL/dfDVYc7rUo3458uJhZRnrunq4fCP74iqoikqqmp4uZkI5Ph6EiUWH82stg3YPeobcR7S37hhbFLpVms3JAR9SgHDsc9kyKYdY9SgY7G2hvhtzZRP8hdNLY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vAzw2LNJ+CxuC6sC6j1wWgOSiRfIuN8nFEHUw8TsAI=;
 b=Z7m57tiqFr2r5GAeiwbXgGW5aHbkKZP8fA4n8ui7s8nvO66/ojgICu697mvFSTXX8CHYYmWcGbOpH+JEUM/hPSaKVsf7jw/IRfxtPteLDHYrV3mcp3xbdYaFSgflySk4MFziMRfYYRN3uBpsSlfHuuaEXtgSC5Rujhbfd03clovL11VVYJT+csvvGXpn6ve9V/i5Hc8iNNrm7ni++n+BGnJ8ySechYjMbPYVoue0kBtH76mJo0dGhASutE75aDniQYcHQG8h57hlylXpiJynhhZ0TaaDqmtm6c0x9DySPB6hO+uMLtCdoXa6BNMmFmIOveVMzR2MdfDY96MD+KRHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vAzw2LNJ+CxuC6sC6j1wWgOSiRfIuN8nFEHUw8TsAI=;
 b=imgZE4a2RtfeM85iw5vKYmMUnNsQ7EjxmiLk6tkMuqpEYAPMKNatgyoIWkwY3YqP3tYqq9UW9gDAPhbPYKrqbdB1STdQ2/rsAm6rXDjlkYofOa9CjdmwPAWXzeS+CXCXeai0jMhP8ehd4r1CAMO+jyKKhTWjXKDr0iPSpDqeD04=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:22:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:49 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/5] arm64: dts: imx8qxp: correct usdhc clock-names sequence
Date:   Thu, 25 Feb 2021 11:10:02 +0800
Message-Id: <1614222604-27066-4-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47f2cd93-2993-4904-7bf8-08d8d93ca091
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40899EE0452C7A371EC9D7BEC99E9@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fc+B2TLdE6d6rNhWIz2fEHNpf22H+fMHOqybNtXVffH1nTUi43UirhiTAfwp1IQtLA0in1S7ZxA5Yt08/AzeqKd6FDGOuDwzo/kpYM3tydrhCV3QGrpeKowPbYHUdibf65k1mA0DahX5XRmA/BOYDfom2uRr+0/z/DMkFnzMWY3FwhMOfRcUJST8UJdp8sAlsmrIg3Q4wSA6vTpZ0FsuhWQ1RjUErGp72tv6HmuR4Z8KUlG3FN14gYMMmzA4MV3d3TfIzPgX0i0F3qB083H6mhQYy6on9bifxjksJMl4LJV/HlRb4J9nqvMubNJJgWUebucwI6y7bXDoMyvzvLB5chNGhQr+/uWhYEozA+raqQLCFV83dvafyOalCRni6f3584HYfkh2UqNFgyryhTpLAhQXycNtm5dZIKFq+I8YY0ljgtLcBgw1KA9UwpZvMvOVC2Zegm0FlgUOOOsXyVuh/rMneV9TXBmuPeDY0sC6EbmSyOnK5WO4YmJwR1Z1WoFZ6SYcpmzwLj4v1/XQ0UphMN7SQZyAg5EcQ6WE9uqX+myDtu1fa4U3NI9F3X7S8/s3XtKpi3pNzO+/yxtT+XBk/mJZsx+HznE/31gSa//x34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6666004)(66946007)(316002)(8936002)(8676002)(66476007)(66556008)(2616005)(478600001)(52116002)(186003)(4326008)(86362001)(69590400012)(956004)(83380400001)(26005)(6506007)(6486002)(2906002)(7416002)(16526019)(9686003)(5660300002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+lEHOdj++wTa4J/EDObZAcWKJAGkWDv01ZQ16iB83gbUJDzofB2BbQoqTiz0?=
 =?us-ascii?Q?Ibc3lWCBpQgiBRgSney3WZ6gJLNm+/9kfX7Rb/obbfR0LVOlqufo1+3rgwKx?=
 =?us-ascii?Q?yJvTLyPQwCCJrqdRC0CTan4M7f+LPRInqP3nWbvolgaxTjOn9DHrMi2BnkQz?=
 =?us-ascii?Q?xaetmm8Tc99SavwRfODmZlMJDkA7oaPZIvhub+WjJiixoPoDUq3dfZTb08P+?=
 =?us-ascii?Q?TET1m3NCK8cdXwadhnup2P9+EIYiFxtM7oBItH2EyDfOD1BuNdgxvY0xk5bP?=
 =?us-ascii?Q?p5TPFTAVhKHgkh46MoXtx5VcxPyO/OA7DkIQt5OdBJRAEcWOaxqNwAAoEyAB?=
 =?us-ascii?Q?JwV2Bb7GQGbtmka8bKaRD2eAY4D8nwjjUSlhhg046/f5cGAfzgR6FDbJZBV2?=
 =?us-ascii?Q?ggwNuqPPoumoMt/7l/rvixzJkBNLMYMCiv2ZRAPvhFJrwGVc7BvSSd3mPnNu?=
 =?us-ascii?Q?++bFJKgPVNXW/kxMSCoenuakhutAEjEdevABno2BOFV3TetMliw5c6f9Vlzv?=
 =?us-ascii?Q?D8CZCqyXWRAxIL0VyPJcS0qveRP+mNiSAYu2EPjscq0raucIStE2Y/3sC2GP?=
 =?us-ascii?Q?X2YSR7Gy65eFXhpH6F5gFA7eASh5siM7jb9V+HmouaWp+YMFosCmddASxSyT?=
 =?us-ascii?Q?unJ1f/zzU9IemmcILBlJZYE92cODZeUYWbGja57J/8u03sJ7AH+bvkME9jyq?=
 =?us-ascii?Q?rQfMTQ+Wijv4mJQ+aQ/yf/Ki+xms3dPCmJMQ9fq9w9f+a7tDcXmnbmgqwpQv?=
 =?us-ascii?Q?EKvDciKnfODRawiAqV/kaGtDr1zj82e18yqT5SIApOhvWvgCCrnR6FZA5jRZ?=
 =?us-ascii?Q?90UZy8+Rv8YYEpfiwi1tt8E6iDwg8hK0l/BIcWV9ldrPZpKPxmI6nvZabejb?=
 =?us-ascii?Q?A5+JbRBFfwJ1z66fTuTwT4iyFz1o8hsrsTfy773Z7YugOKqSAkJw24Rq683J?=
 =?us-ascii?Q?fiZhhhQHGX8f46C4PxcrlvWBvqVJTw2dQAsKS3oj4jlfnaZNjqrM2VFakEj1?=
 =?us-ascii?Q?HQIgzpkXg38aWaix8up07NCk8eyNLg71SFz1l2sBa6WXyBU+6TBi3br9LJiI?=
 =?us-ascii?Q?IDdei6TR8ouFwOwe698mt6bv/YKY3J8aBmrBCfpXURHCV+wKuIQMqh7UQN76?=
 =?us-ascii?Q?S6WBY+i/YGOnu2FxT842nuAhkzN62vYsd8FNpop3P54BPoebcHCb02A2JVkW?=
 =?us-ascii?Q?AsKToFN4A99zQ2qiktROWKoOD8PyfYy0k/Ike8IcX/OiandY977ebJqy48gg?=
 =?us-ascii?Q?TnmXQqoqqiJ8diZTahjjhBVlTdMcEDw6cqFJFTW6UZ1mqwZDquBQ6ZEyPUWn?=
 =?us-ascii?Q?VvYURGIFjtVSIE2KxoqtlyCc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f2cd93-2993-4904-7bf8-08d8d93ca091
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:49.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7L4y4fqjTHF5N+v2oIq8Muv9rtMhMxpMnvV6u5StOnDmgN8hDOMdr1wTxdhW1+Ro2UTlCOtFubSLYzvg+SA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
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
2.30.0

