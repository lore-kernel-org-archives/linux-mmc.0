Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B86AC4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272BD64ED1
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhBYDYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhBYDYS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 22:24:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F1C061756;
        Wed, 24 Feb 2021 19:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDvwMQ02+yc3SdCXKaPUGthXaolwTcWvEyu+Oel6EQx/TnuoqdljcvQPRAvP3bjAmhd+aJ/1PKlwv5pIK0L5R89ctMU84vKfcbO2DkbuTYDcVJy76OLC7IBk7eBRXC2sdfptuDWN8MmuphQ5QcTcGYMMFvBGM7p6WTZKaWpl6K6+5GZjgAUvN2LyBGtwht/H5zbQMbIOQ8W3mnQMTpuaFwZ1j71TVQ50hT7e3unbdn8ZI17MyMqwXEOEt9w3OhJYRDP/FlO/8CT2lbg7PymVfSokweZxcONzaq7iprkwOOSUYRv4rsYQ7HofO+dF2cDizAf0dj907Kx7Mhu7xg+B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYn7P8ESFWomIEBCDM9fYhthihQNTqKZH8k9H53506k=;
 b=oV9Q4otvxk1tGKtBV17hq2RZMH9GSUH6Gxx29CjJhEvEJeR0kEvcJjP2PalKFM3CNj401xycBIbXY9wSjoswbQi5yRjIcDwYuVMhsN38jn0sUonfAcnpjsF+3xNikPwx309e6jQw9QN6E9McLAq4xRaWlzYG7t2vhnI0z1RShoDU8kWxF6HDWuys0CkRrJ2dHcgXT/g+CNysHoQVZAtSjeKlJrUfoAt61it3QMMhw/RFwGxP50VpIdSf90dup2sAfgk3PKCIzkTsw5g0i9WkNMNaLyFAXIrY8Nj+SAxOA91H8OESmrjQcy9tWRUlZv/9nGQmUUYl+aW4pfi7VS8cwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYn7P8ESFWomIEBCDM9fYhthihQNTqKZH8k9H53506k=;
 b=HSp8pOY6x/CN5i30I//fw0v5V9wx8X09NlTtUyYTXk7e7Z3iF8Rprh6Kp1bz3JoizEkeV7BIqyORk83gNSfkOcPMKqDTAn3mBgsKByd2Jd3mVMAqixRnINnvMFLnNDg1MEqRZTXcgc2RsxfQezLZn1sLfKKrX5/d51pk83UkXTY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:22:44 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:44 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/5] dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
Date:   Thu, 25 Feb 2021 11:10:01 +0800
Message-Id: <1614222604-27066-3-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23592fee-f905-49ba-fec4-08d8d93c9d8a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4089E959015762924611FBC3C99E9@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFZe3MmndgCK34nbOLTMXpKjH7aF3zUYR+4RLFC4KV0nhjax5Yh1z139EmL/x88kNaU70jeqpZxYBJd4rSOHkFR8sj5o2lbkFiCU2O/tp7qgE53KwLwS7uGRRhLWbWSdPGO2vHyYe4oaYmf74xf+pt0ciEazxbTdm7ed85rza0fLxn1kpteMGnoLKFPiR3Jb82KC7PFdpUTfSXGvSOYhMcwBw4FyQ5uveCbBTUbiGtGmXhTq0j8AsfRg88AdPD3d+k01o1ETuh3j4aBymzeM7PUlcAao8oFXBrJComNXHRMsZ0cPrpaU87bEJHhc20HMNfjmmDiCoV0h/mk6QcHcYysBlNiVWBpMP4gEt6m+W/CuQZlo+FDjbqD9GN4YiD/CBd7VDWa2MUFZCrNUSdCui8zr1eOp6OomdmGPnfx2HGXYGulIJ56CI3IcTuRYdPoKxjhw9vNxJuQfJe+ucSvXzlbdWdt7jYUCSkXYnRhMHaMEmoIZEvxHX0SVUQT50AtCkUL80/x7mRqeZl8EIK3/76o3zuej2n9kd+QtEd1Uj4a/4AL5R4OpU3wXJqU/7I0KZgzajHfmt1DbNhN6uqnMnYXzJLPsvxqRrUfImLaJgeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6666004)(66946007)(316002)(8936002)(8676002)(66476007)(66556008)(2616005)(478600001)(52116002)(186003)(4326008)(86362001)(69590400012)(956004)(83380400001)(26005)(6506007)(6486002)(2906002)(7416002)(4744005)(16526019)(9686003)(5660300002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9TZDTQP876IpZNwQna+M5cwf9NfMXH2yeEx0KzbgNDzMAPyuxyWiyVkXNXXD?=
 =?us-ascii?Q?TkVYWLace/bnj9DhBGkDcidHMH202xp/KcMM2MHwBn6ut0j8xhLhFVV5WAy7?=
 =?us-ascii?Q?a5+XptTloHdiO33zvuWWG3evhRG/pDtcn3HGjW2TZglWujbiOhCJ82BydzB2?=
 =?us-ascii?Q?pdeY+v2ZsLTQPp6d4NkOGXhWJP+MwUY4X1dUFfO9qGk+7qMVFKACDBtV1ceq?=
 =?us-ascii?Q?k0GMNvqHp0pyJBicMpx5ueC2vzb1ZIXUqdbuiyd1E3r/LXZG330RgEo1hVYy?=
 =?us-ascii?Q?X4Ey2E4fhtPrfuteFMcvXu/IYAyJd3ZLiLHorF1tG4pJ8RsSavB3HpdKrBUV?=
 =?us-ascii?Q?ontvnZXKQXLuKd6bxIkW7WBiEcHVhmwxxt/DilU9Mhtp4bZeZPMl2zm1QqxI?=
 =?us-ascii?Q?7D0BSTJqYRNoqg//RBvrtF8CZUkaCXQE99RG0E/8QwbGNAzIkeuVJt7AFvyn?=
 =?us-ascii?Q?IjA89USgCyDHa4Or8429NVsxBS6O7j0d4LY13owGWY0G7Qhet+nHNmPW+wg6?=
 =?us-ascii?Q?i786PEdemrq673xJNtApD1pi8RJakRNCfiirjy5hMnLoo+l1tiwpC48OnSAC?=
 =?us-ascii?Q?HeYKLxHU6ti4nmQUZaT4lIwkM/uZoaWOy4YygonfewD039xGR6/aUNErBo8h?=
 =?us-ascii?Q?PL9Bl4G3ebp2Q+355RdbacvbjZYwtL2zzyHnCmGx3lb5byAJisPSnZ+Gd8RJ?=
 =?us-ascii?Q?zvJK5byhHJby03G3LmP89y4iRgZsSSGsNqFFGtozJl2qp6ebFzkbIXcgRAPk?=
 =?us-ascii?Q?HsDbt63NPFrwsrR+NgzZyKkrapnOlAjbWK892YCVjhS9rS8hjSNKEB7SaZLI?=
 =?us-ascii?Q?nSRs/1Q+2mDC+BePvWN42HxhsRqam0HUMhMj6I11f7CpFK1i5q3PuoE3Eel0?=
 =?us-ascii?Q?sqgzd/elj+Hi2c/g268DKlpWCH6fgvR8/hNuPGrv9YS+rIV8vjP58loeFqwc?=
 =?us-ascii?Q?yXpXryNecGUO7lwCEfbAlzQL5dp9eKFkqocWAe4gn43Z30ISYU7ORvEBgXYf?=
 =?us-ascii?Q?ReVR1TH3/Zom6GqmSzChpeBkRkmzKKX0moAk0HIXMi0D2a2CSaiz6Zpd1sVK?=
 =?us-ascii?Q?7hmJKxIDrAjbdz82SvKImCxgLfyRJBlY2FAMSA2FX94rOosopy4zB/+zBVAB?=
 =?us-ascii?Q?bHfRgoQo/Dtkhf/0eNrTXcqEAnMFh5VsTodh+YxdoGJb+Yj6gSkKbNndKe4A?=
 =?us-ascii?Q?rJj+jXOnW3vjoHpvnJCsgPRpkz9bQNqIEQU9QGdHvq2/ujjlwNBQb97Op2vz?=
 =?us-ascii?Q?BcnD0ysuFQL8kXIerkEYpRvL4vkIMuFil2Q6cUYgZiKPwmDyhLCATmu39W9a?=
 =?us-ascii?Q?V4NsJf4r57mGtEKxtsBsuBIn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23592fee-f905-49ba-fec4-08d8d93c9d8a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:44.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7Oru2TgC5oYZob2LlPVf5fYGEbtiwgv6oQ9BJiE/UFEppQ3yghuQDjgtt6tk5r847QrB+6xUETb3u2FTmZe3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Align with all other i.MX using the mmc controller, align
the clock-names.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
index 940486ef1051..0f6fe365ebf3 100644
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
@@ -107,8 +107,8 @@ examples:
         interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
         reg = <0x5b010000 0x10000>;
         clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
-                 <&sdhc0_lpcg IMX_LPCG_CLK_0>,
-                 <&sdhc0_lpcg IMX_LPCG_CLK_5>;
-        clock-names = "ipg", "per", "ahb";
+                 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
+                 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
+        clock-names = "ipg", "ahb", "per";
         power-domains = <&pd IMX_SC_R_SDHC_0>;
     };
-- 
2.30.0

