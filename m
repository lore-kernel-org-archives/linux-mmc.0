Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB20C77B7D
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjEEIr3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 04:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjEEIrY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 04:47:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D718FC0;
        Fri,  5 May 2023 01:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5XroPNg4wDi8UJDrRTGLxGKUbIp84smUScS25dtQAf2gg0z+QmRhTIkXAc/ceslLa2O1V95r0Jn5Q9BINcgFZhgWIss41Dr3/K41kjMeRUhj8eD3GwYMvVxeQt9hZr6TTi9g84yuwOlptaQsap5JYvO7F2CoRGgtLOe4Ha5GmWF7UJWwHRAnkQE2E5VF0qn5HwHSIcR4sM/dNWopBJA1M10Q5YepzR+5vRTQoJ3qsylZba8VgNcJHRy6EOnZ6X3CVN/XIfq37xDzVYOMH3OkHFVTUvR8x13IQqLXEJs90DUHMG/PDMIlCWiPY3VGWCh1kRatoHEe9jEDtKc/Q2IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmRqw0xnNjHn24bXPAqPFwrvaUgl+uJL6cuf8sR2fJw=;
 b=XzXDRkCZnTN2OArqjnqFQttmYnCWKN4o/Sonzeu4tZ+zHVH1LtAtRFMmaTp+0qPV8JHhLbVMrCLROpQXPI6i7jfO4B/0dfw8i9E72YlqWpYlkUoeydLt/l5p7URPxFbPWn/XtPv0BnYTCZ5/RtUGDmY5SCdBj9triEZMi2SukAzw+w27e2+0tJvJ5ijtZHOr0xSJytWrBHs0bEhd4ismGUCbNuBXyLJ52n6N3scD7Eql8djAPeiiLV5U06ciOj4V4VrBqQxgZv3EDuPQbWmRASwoo1ju3ghtuu2PEqRmO0A3ZiJz0hQ2ifaC/aR2go3GyfNHqCOnNVE3k1Fc3/o8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmRqw0xnNjHn24bXPAqPFwrvaUgl+uJL6cuf8sR2fJw=;
 b=KyAg61NVOilG7lKpN0fmU7v0TEzQiWZppEb/60WyiSiuqjMPhELW41aeNWLD46hhA9e24XjPcdyKMTkb+ddj/N8PVgY9TCCtUR/5pw+G3JS+csLJ/v6V5XnepM2YKvQvCH2JGnR6qwIUpa9Q19JuT4Ed7mkbmTuOeoXuM6f04p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DUZPR04MB9898.eurprd04.prod.outlook.com (2603:10a6:10:4d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 08:47:20 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 08:47:20 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH 1/4] mmc: sdhci-esdhc-imx: remove unused enum cd_types
Date:   Fri,  5 May 2023 16:49:52 +0800
Message-Id: <20230505084955.238940-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DUZPR04MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf1fd67-a61d-40d9-ec69-08db4d455625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4g7fIRiDskn41tYWQvRKS8vPQg/v4YRoD5yoWGGe5gEmhEQYOCy4SblE6zz4D1TQ2mOsB5GzmKWZ4EIbZSuwNGCS4uW8mf5hk2HjTNuT6UMCdE77Kg4F/L1LeosHhqSY4oZNOauUnNLTwV4D6z1R7+vOHHodDLqDDmVYel9PG6eFJebq7a7mk4Kqv1mtrN2ayYqJD3f/GmnxgtmZMrmXkDYCjLisXSHooxUXgay/IKocOMj2QJemx+Z8Pn3H23S71/0Glrc8o937x3cwYYVWDeuZFMWzF0HdAsWqdH0GivP5g8yDwqol1U/kZ0IOC7l++4aSFrdfCLD8Mo39UrevhIL4k1M5x0fGauGlrB1x2cH5nsRbbP7ppDNQFzpG4MowSqJxnz1NO0TvOD/zdL4tVTIwATKGkBQabBSKmObIOwr2GXt01kVmECfzdFGFsYdfOmE3Sojr4f7it/WhAHmK59oRrSrQ1/3K6au+MhWveaFP11A+kvimMwalArRK9mok1/cMZIR7KYrNcKf/DpeufZQ2Yjh7hFVC2LW8QhSUHhqOZ/90oJcNq/Fhk0TgfrJ9nU56SXYsTfLATah1SInbmnT28DGW/Q2LuDxADVY9Ab9hL4rtRFB27PqtZXnQ2Oo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(86362001)(6486002)(6666004)(52116002)(316002)(4326008)(66476007)(66556008)(478600001)(66946007)(8936002)(5660300002)(8676002)(41300700001)(2906002)(7416002)(2616005)(38100700002)(38350700002)(186003)(6506007)(9686003)(1076003)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+155xPBvVjdq3VneKPUjM/X7Jldrv4U1XxNbRhzhHGubAa757+m6CJR9CRG?=
 =?us-ascii?Q?pJiyGjUYvfx1w7FxXKVJpy53FDCuiVSTt1CpkSLbNFt1tz0D6D92hfSvmr5o?=
 =?us-ascii?Q?ocSTmAwS2n4h7Rp3aro3k32WrTFtxk9BXJz+qakAJCRNnQ29ofQ/2kjs+wSc?=
 =?us-ascii?Q?1aEp6RovPVJqH74YphlcgeMv9K/Jx/1IrjDV5tJCX6SWZQS8dKpmHl4V2s33?=
 =?us-ascii?Q?HXK9iP1831zhO1gpLzRRHQuJVdMihKvIzR3h0Vo0FsdaY0cjXoqsXyrBSzCf?=
 =?us-ascii?Q?r7aKA2ipdSOjVrbakwnvE3IzjQvFNz0SqWHyF4fe/kHWFj4ciTMmJbqi2bCy?=
 =?us-ascii?Q?5qCliKA5tUli7oiVlC69Ef0r3P1tdliR3EMtVUEXLG8pT8A+Y9qIS89aeXqq?=
 =?us-ascii?Q?Gbm7K+idXyGnAIRBQlwCHdKYuqWJQn1/uIBeoBinNDfd/B/G/4XRBsqFCZtj?=
 =?us-ascii?Q?QwrNNQeNcY58JtD8A+m1I0ouPeEU9t4pm1h7+4AHJZdLXT3sZS68VREXsdfR?=
 =?us-ascii?Q?bufy/ooB23TgfSmVrgeEmhLYH67LTnercbdMspb9Wz1ptKpg+rcn35d7b0hW?=
 =?us-ascii?Q?+PzpeqkS7XhIg0c452SiS7mPEIK6H42THQkcDVSmbz8N3XkkOwtgHIsLACQz?=
 =?us-ascii?Q?Z8xfw6hjPBONToqTnP+f7TWm7Qnh3Q4/OAjoQaQmHeYCg8ilIvLwXeNNbfwT?=
 =?us-ascii?Q?nZrGrIRTEqkmz24FrZ3EAK+ww97x+zg+W7VupawRFilpUfCwCWVVX4pGCs9m?=
 =?us-ascii?Q?lqOV4kUjUGsZZwBRhGhJR35XfmUtdwxDDJ+6Z5KrgO5IftZMqJ/60SSkJntp?=
 =?us-ascii?Q?BkLdWZmmqZ9d4rGgjk/d1pxNHsOIXDFodAaM7VUPJ5Q6kU15VCn0RnJ5BfU8?=
 =?us-ascii?Q?KBWN1wgl0WlbvRwRA9l3g9KNBYhSo/+0bexaeY1XZ2LPexMXj2Zx705H+zIC?=
 =?us-ascii?Q?Ku51nP2vZrry0mm70X2eniEzeDydNwyhAMbdNxRZui46i1QcHhHyRUDxO5vK?=
 =?us-ascii?Q?jqvImVNpVm+JJg8xDgSE7C5v0ftXIj7jlWDYj2QBrN5tm0LEQYKw1Q/Ria2N?=
 =?us-ascii?Q?HlY2f0Nhu6fQamOxYuOraetRgNBDzTNu/MeoEcz1W/CMBlg06DGkyNZtTZLy?=
 =?us-ascii?Q?jpbtmO0oGnj9EHoMMKcRjtxusu4XGpkQr170p1IpIDRiXcuRaA5f3+18K36E?=
 =?us-ascii?Q?3ZnbbfgGTdxSSRLW4mRzhhlhoaeykswKW4e+pZvi4vFrDgGqq1KOoFbNSVG+?=
 =?us-ascii?Q?mLa0ii0023LE9NRMUKSsnIhHoL1HhSXI6nfgdLi5vUBv/2HQanzd+Q94S//I?=
 =?us-ascii?Q?Ovas2WQPzRCWW7iLraEOeIy50/WBuaP0Ke2AYncuGeIx1sw9Wlg/syGNvjt0?=
 =?us-ascii?Q?b64dlikhXmhQIe9D3mlAbd7erdmls1vBlo7VIHjEBerplCUcxGGaRFaI1Coz?=
 =?us-ascii?Q?V/RACd3D6emjK3gt3ulGx6pEbvMJk4zySgjJrugYa+TW/hIQOzVQIijSkj62?=
 =?us-ascii?Q?dBOxXxpu6jR3Bsh/3vDrWqgvOJOfC0FPR0tQGVqjaqaChJn+cLcnjuldEGFl?=
 =?us-ascii?Q?rVkBwonXtiI3yH7jGaSO5ZM6n17UzQCsep+inNdY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf1fd67-a61d-40d9-ec69-08db4d455625
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:47:20.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnZ2Y8UBJ4Inuc9C1dy3L9FxWWG94MBZnPXHQsRb1MnxKpBPeMqmz62l3PORmbJSoSuOpiFsVf+2K7pMOIteRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9898
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

