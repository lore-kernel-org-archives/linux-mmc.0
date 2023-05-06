Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571FC77B73
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 07:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEFHid (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEFHib (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 03:38:31 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731CC3;
        Sat,  6 May 2023 00:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1X+7UtxkmCLOI09FPFcwJWwQCOfdj3K/M5K66Pn5v5qxpVyEXMUgSLLMeBJvvFdZIsqHRkojZTT36Zf+sEW7xaepaCt4nyBSun1lx6XoMG8rsiZJ565orz3/ooGk7TffKNsP153ibwhmDxtYitshTo4Ftsj1j4OAp2wZi2u4sibSrxEIqOLBpMS6JESho1myvIzVAjB+t0WflcLCEZKUkO8/nR+Kqn7A3IxDOn4TEYZbD/NzUaIU+l16RVQUY3vSXyBZ8CCp+y1w5Tzd65A/vjUEqUa6fUSq2/ypfqs+9dc5lZR9g4mt0v/DmRilp3mq+WYsm5U1IgORd9uaSMaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmRqw0xnNjHn24bXPAqPFwrvaUgl+uJL6cuf8sR2fJw=;
 b=CioszYn11lp49jFykshyjXv1fUkFijup/QRpfezhN9UH/rLldHUaQqk1GG2vhLzDnnQC2GgfXnkUlJ55lYoKpwcqbBVd4yhKmrJIDX2FXdtSDX54j8MHEO+0Ko7HINJXclT1kXBJZIRc7jhIEkjun8RbE/m1Cc14SvbJwuP14CEZfCHz7eLKSFgvaBNh10FoCiuHDj/j9dECYZy24s06vdOqYaCns9cBo/ULXUAATQ6wv3u80TncCpHFnff4mdc5ZMf5YyviR4TbkBCO2DSn4kpavmBEd1NEAT9dop3/av4uDCbCB7szBIoOthCgjbyuwP4RiTRmDUVPVJRkJXefzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmRqw0xnNjHn24bXPAqPFwrvaUgl+uJL6cuf8sR2fJw=;
 b=WmLJRa4rXpeI+JT9nKcFhTPLU7exoBfY+L0A1u+KiOCUpeNnH1uV8aomLDz9641QKglL5DAT9tQWj3DyHArvF2sbtgh04g1bJaEPkgK+p7nL3+OXxpru2cdoQrHCFvK1hkLKy9EYHwz7DcZsdPUAvU88GfhhOIZIErlpAinV8fY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:38:27 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 07:38:27 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 1/4] mmc: sdhci-esdhc-imx: remove unused enum cd_types
Date:   Sat,  6 May 2023 15:40:34 +0800
Message-Id: <20230506074037.522961-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506074037.522961-1-haibo.chen@nxp.com>
References: <20230506074037.522961-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2021f02d-eb60-4bf1-ab11-08db4e04e18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hde7J2Qp4UhWMLa8IbwZDEsL109JtL8XUgzp70N8ak7oMFDhQVrg1waqBnRJ40aaAk8hpyxctYW8XiyYpLqtcBzs3guCbPzca1/1djHMVMCr19tNrupoJ6ipZbmbvK1OeZ8Wn7ZVeK1vp5XEAD8dvMQrtBPSpEESkBpuYTLN0CCe6OZxzU369EXEyMBvB4tRAl7vPn3boJYYgqkgjz+sgJOw2bXgSQUDDVXjQWQ2jgM+OvkH6QwNqSnec+Fiy6WdAVFVTX/7+rUtc/+fSpyAyV86uXP7G3w0uJ9Uono0lvnu5WCy8a6vB685UhSl8NJanUzMU3iOBF8Q/2Qvj4VgGALDMpYgRo3Q/VeYWPo2x8dIdoIEddPWqnGdgNReIXOWuRBNSSaRb7HluvBFl3IszRZddPvzz4/TarIVw8aULD+sU4talnZUWJS1p79UiN0Lk6BK6RDEIp3nyPxzLzh9W+t1MUBEt64S7MWHhDzaNjbgSa0dG0BW5/nxLkk1g2wKeW/c1uGW6AzoGU969Y97WspSPRGLwPCQSvtnvaZnPlYdCCLv362y0o1ft9nUFWRbGu0A0At7J/YDnlxRCpeofKDFg1jZZgM+D4otve0uin2DUs0wVsI1bxaGdtxBfav1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(26005)(41300700001)(2906002)(186003)(83380400001)(478600001)(2616005)(6666004)(316002)(6512007)(6506007)(1076003)(9686003)(8936002)(8676002)(7416002)(86362001)(4326008)(5660300002)(38350700002)(36756003)(38100700002)(6486002)(66476007)(66556008)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4l05NNam6GDt/F0UFeD4FqVP2+HxbqMYKv6vr2pkUV9KDp4XOJry7s/iaQW?=
 =?us-ascii?Q?g73dJbWxG2nOldUmO7POJMnrygapajRzmQ5Fz8t/xW+i5TBlEUm9nv5riot9?=
 =?us-ascii?Q?Nd+pof9mDL1s9krzJwL6Nc49qDI3qHBRmUJkWr3V6oEtki9KwcSGrpzYs5Zi?=
 =?us-ascii?Q?J7B9IUdSflooQEltdXn+6gtVO9V0OODgCxv8PCpoerwb+1Uj5DDm2/IsoRDd?=
 =?us-ascii?Q?8DEHzDY5ivQ94ip8WFTAKIkood3CMrv4GTBXr8V+8W07bPRTchckvwRczbXy?=
 =?us-ascii?Q?nPNzk81FeQRf5ECSrezdGpIVrkUqaNwWQ5wX1H7k6liZyx287WVfsTCi8bYv?=
 =?us-ascii?Q?9IFJlZLCtXjQSAk0YFIyml+ZUZECz71tj4D07tWPA+1meXaOzDbM59be+ff9?=
 =?us-ascii?Q?DPpjcU90dGXW9bCcKEKRHd5s7IFjR1n5hO15QZvtfHqcRpICT2Vi18gbcIy/?=
 =?us-ascii?Q?a22279vz16LiJtUxstRJ8QeAtyUSM61WpdDXoTzCz5P1bCoXWL5ShJEGpbQZ?=
 =?us-ascii?Q?VRuW2F7EoN++W9Ac5HCqn2wlrIXF3uNy7cLh65C2QQerkm5lUi0Z5yZq0lV2?=
 =?us-ascii?Q?VvdQ1EUuTsh1VvKoXOsPQZsPyfipn2PTUws6CMhkt83WGdVybJTH2ywYiMJu?=
 =?us-ascii?Q?mH/0MgaPsOK6q541w3O5R8kw/aph2cPM8gjzB5qWXzQOEtfjSKOPa0nYeasO?=
 =?us-ascii?Q?K7StUSUQ5XuJHpUfdJrsiAIm9uTrqy4tn6SLU05b3o+annWETO5UnhDKoSux?=
 =?us-ascii?Q?+ptfmF9L4HclqQpnjThsNQSkldIKd2dl0Pb+RiYb6KpsETZVzIspW/bHAEul?=
 =?us-ascii?Q?BqTzWG3vMbVoGVW1NGmKHbv5VeNNELm/rLRni4rU3+njfCsHasSwfDMB+Mu3?=
 =?us-ascii?Q?+lGCEt4/0J4Q+zEmDlUh2iDn72u6imna4tm/4hwMKnyNREm/z5WPY4C4M2Iw?=
 =?us-ascii?Q?k6SGPFrMw69K8ZTguRkCzeJnAgJbZnEVyqYCYy8ziqnLBF/Fni9hqD9SZrW7?=
 =?us-ascii?Q?aHC6wLBQUp38Bjnz/R9Jif81hQ7ixgPfXig3934TWM4jg/Az8X14PeYa/MiY?=
 =?us-ascii?Q?hzxuAQzRnQfgEE/uF4csAh/tKU3w0k78qPM49gjE6LFbWhIiF1ozP0SdYe1I?=
 =?us-ascii?Q?65Te8Zy5lAm1UwDprdpQY5CnENvSE8sO7AZw/fvqNaDawWsBv9j0Dol01T31?=
 =?us-ascii?Q?vaMQdY0HRVnWy9rWxy1aljj+sgFcqNVz+3dksFpNYvUiH43N3OBnp9zyVMrl?=
 =?us-ascii?Q?keYVamvZbQh+ms6//d7kYN2RxfDooEK3Tamdk8RHYHf8TPE5k30onG6Z/U+J?=
 =?us-ascii?Q?TgmqXh1jBkPtalC5eHG9fdZLrPoCPHIILL+qcXhmtsvb/zcDZWvphtN6DvqD?=
 =?us-ascii?Q?BGNf78pW5lEEF2jX/3YP9CDLBQOE6OxM7uDmvYkcvDlifTM8ypG9IFY8bmXy?=
 =?us-ascii?Q?Fe26dbwSleh7n5W2JuXG4N4f4o92tVB418kj1RabTAYesPyyjcUWKUYsWV1X?=
 =?us-ascii?Q?2/gCVqkcdmarcrrrQ6T7DCat3Vr1klG69zAONxxl6eWn17P2SHcjk45iAu+E?=
 =?us-ascii?Q?d5/XOHp+PQ58x+O0oPXghmRsYYaNJxsJfvweTt+o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2021f02d-eb60-4bf1-ab11-08db4e04e18d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:38:27.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ2GQTTUXcMg7tHeuKC6vQFkVWAFOAZ2fFbCY6xCusT1iYqyp06Kkib6jNzuyFlumDCLaA1dcAYlJYR4xewEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

enum cd_types is no more used, so remove it here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..c7db742f729c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -207,25 +207,16 @@ enum wp_types {
 	ESDHC_WP_GPIO,		/* external gpio pin for WP */
 };
 
-enum cd_types {
-	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
-	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
-	ESDHC_CD_GPIO,		/* external gpio pin for CD */
-	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
-};
-
 /*
  * struct esdhc_platform_data - platform data for esdhc on i.MX
  *
  * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
  *
  * @wp_type:	type of write_protect method (see wp_types enum above)
- * @cd_type:	type of card_detect method (see cd_types enum above)
  */
 
 struct esdhc_platform_data {
 	enum wp_types wp_type;
-	enum cd_types cd_type;
 	int max_bus_width;
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
-- 
2.34.1

