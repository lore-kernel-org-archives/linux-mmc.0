Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B83C77B7D
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 10:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjEEKKj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjEEKKi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 06:10:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54A13864;
        Fri,  5 May 2023 03:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAIK1WUfb8GJbs62ShEA/yyOIxIMqYtT2n8f69sBKNmb8uZ+qtCjZrZozx+7RjBWCcynDYqgH8eHT1Z+v5t65OzTe8PVOqatNd5LZJ89sWHxxT7bjUtUJRAKqrzcoeb7AhN7V1fMGtGmXp4HVimAaXrw/qJgaIqXskq7ndRBsStoS1FCTolKeMRpueQZ+d6jUMFY+t+qmDpl3mcUjpYcu9Q/lybWH4wgzptIGcBjTtxAkoxkqESbWAgEVwBXOtLkZeytPgNfkHIGp+bpWPeRPn7NPYraBIIuuC/kmqeHNc4r79ctTgpVVxS1/K6xA/kvdKvMzgYUBQom83xIXlGEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPqaID97zX3dsYBwz21hYomtWEi69Tlx29FDEfIj/Uw=;
 b=IJyVAXARCGurxA/daq/VMZmWdcqCb5A+pOxh4sukL8+Xpgp2mpuim+kQPXmCpAMkTH9LrIl5gHJOTEABs+uFKWLh1HC78f5LsRwCJHJNm4LCUlODEQvIeWyXWJWiVT5MIIp2Ynld7omrS4cKdXV7pkaUjbiJ2zwABVTUFxmddVNv+ollQqn9cBkSaQCX8cytfwkUJlvqAjiPSlfHcap8z22Gz30mkJWEgIS1W8757hphMNWaak50XqeSKKqUy0dLNIG9u1cKaRj4dmXkaCHpbFuwRtAKQOyyxtd12EbxkPxX8yJLbUwSpJ8NcSPacrEVu5uLeDwf1UH6xKurOCspfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPqaID97zX3dsYBwz21hYomtWEi69Tlx29FDEfIj/Uw=;
 b=kzasKyq8Lbw8Ra8pUi/VYa6mOcyQv/0FWGE/7d4nrx5yEeblLpc5XH0V9baF30vTfu1sz287FQRE/1zqiafr75MeskhteJ5s9rxji5EphgSSxT2Y9/OVzffwZUgYH8ll8+tt9q72GPkTrM+cAg8ib5RoZQCnrnXrEBitBPOSp1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 10:10:34 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 10:10:34 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property "fsl,wp-controller"
Date:   Fri,  5 May 2023 18:12:46 +0800
Message-Id: <20230505101246.289278-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cc7049-1812-4b11-128a-08db4d50f73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFYvURpYKI6vSL1NyT3Z1Q1Hf8khRBWg16LpTiFfI48ouy4fup3jSxzHSsZS7Gnnx261OTkLodJ7/EnbzVHKwkzZbdNrpU1eknl+XgeS1+pHWRF44yBXL01l2X148MKpQiG3jgJwNVSAcVnHiE3P7EyNRY1IRqRYI3KLRIJDh9e/fxbQSIe13RMyXUqjGrvWYfeFrpTuq9m50SIqWpDkoqtotSiaCjUR2clt7q/uJFYKYG+qs07BKlqdn011fMWaKrCbCFm4zxKNcObbMbGLFTwW28o8SaxuXGj+JX9Cfqnn4qg2E/PTbE9R6wfuTk0qWmCGv3k8JpXxb1MwC7J9Ta6DtbUYqz77KAwkNYWlCNslUA42F291hUFTrLgqaFEyl+FrQl/a3iCBYaIXL/wlNBanFPpfeNOcm5zMMglqusSzd8NzEZVo8zX/7T1vbWfY0o7lal0JuarsOtDNbdIs5EGe5HQwGMWktUHjIIHzUmfA/hPECQoakWFya0cjmCmNZFHwBSmwtZamx5B7qY4STNEJzN4ZOhaxc2ruzfx6EHbfyNWjP+x8oadWUpd4oX9PqVxivTCA++MyTxSaeM2hYHM9g5I8IbOeeWT7xmWrISZAhPZGEqw9Ldsm9Jg43GaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(41300700001)(4744005)(2906002)(66946007)(5660300002)(4326008)(66476007)(66556008)(316002)(8676002)(7416002)(8936002)(478600001)(6486002)(52116002)(6666004)(26005)(186003)(2616005)(36756003)(6506007)(6512007)(9686003)(83380400001)(1076003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzGBWjuSCGbXQqfcjIRnBaTaHVEoDsE1hv3Dyk0bRlogngjJGjGq1VcROrSr?=
 =?us-ascii?Q?RU1THJI9sd86fHjAZrTjW802YTdyzRSSP5254xI62B2txdXDF7jSfR97pSva?=
 =?us-ascii?Q?OhhWFPfje/Dj9qQbKKJXPQVfvbOGLvtsgpsvXdpEcCj8ePfqeXwlAxYxMnw4?=
 =?us-ascii?Q?RcHuVr8Ae6Fm3jx6s4kAcSDiiPvCAwZv/pNTJMyhE1+rAGZWxk9xcDWY7WiX?=
 =?us-ascii?Q?h97dlnrggv//6dzcGjQOuCCeCFpZNmeO/Sksol7PDDOZPnxX9CFI3JbdC/8b?=
 =?us-ascii?Q?Bw+jOqSXZ+tswhYHWM/UWe8PZgCMl/NyYotJYug2WHLZYBO53CK3Scfqs3Cy?=
 =?us-ascii?Q?46CwB/Uj/FQhKK1LbuhT6vEFzRCPMR6dq9lCkdjRzfd1NuHZn68D7pm6QiYG?=
 =?us-ascii?Q?WxzqqXwz3tPB2tHKKR+g2xBBUhxJQ18BaAW6DVQbLF0iAV+s1AMVPT0lrERr?=
 =?us-ascii?Q?kDYPJigrMwhYsYJfWMFPC5EHvu0E4VKGN31RZERELiWeWByUh8r2F5W3Crqc?=
 =?us-ascii?Q?51Yy8tJcyHaZjA53u9yLmy73hYZiY0kCSY9aqXoMnjZQMi4rwQQ28A5NEW5f?=
 =?us-ascii?Q?B9Q22aFsUfwdI9Nfl/clJNGbZGmZZSvLBqerMVu+oVB0cfQkWHlExZn/J048?=
 =?us-ascii?Q?hT/Vh3sPjcFKO8ZWxyS6yIYVYpNu739MBhYQ/bQAWzASAiZSsUNdBY6sSf5p?=
 =?us-ascii?Q?8/fw9c28YbmfIF/OzZ+Z2lCf6Y+xSni1+CxxlKv8OMrnJVVRTT88KRiNfpL/?=
 =?us-ascii?Q?C7JGJNQ1c9Mls+MWrQ8OfAHpo+WXhN30O5qs6QkyYE/PD90DsifYf4Xecg5x?=
 =?us-ascii?Q?t0sXfAOaQjwPpoMeAAS6IwVUhi3upvAZHKMCh2AjxTqzpxeydp6Ky7U8EPZ7?=
 =?us-ascii?Q?Ze3u94G/OdbTr8iwYTQCLI0jq4fxfLSzU8wzSrSJmvbZNL6EluRfDr0FAS1/?=
 =?us-ascii?Q?p8K+8EgPpOWQu9/w7ym35t8RdJpgLhMCuVuCxCcx8f0NjGf3NiTecpkENon5?=
 =?us-ascii?Q?0J11dWh02Mb7y/LDqYUgQHr5ztXeuacDgnDN7sjLjC5plgRoNyfvw9Cot8yR?=
 =?us-ascii?Q?WTdsMsNUa8lT/7oXXZtMeZar7W66V3DUeOE0Vn++82al20uTM14mxmbyBcfP?=
 =?us-ascii?Q?c3KX1obsQ9tJdsMamhCeEsWhQFBbdCEeO8uiuicZSZS0RCVKXu3Ie9zq/Rr+?=
 =?us-ascii?Q?Ty5PKavX1+HNLfbD8SaV805GjgbxQm0zwyHPw3OZXWbhMwCf34Ni3GFeVkc6?=
 =?us-ascii?Q?hflYPRczhPbkFKRChOZ/dVHSa/fEtc4SrmuwgOPFb7zaV1bxcPB8hJCfdozk?=
 =?us-ascii?Q?fUrv89i+8O4ddjX9lm7ypGsH+eAI7FwgrZOZtTGP1nq9aYBF3vmrCX4wIjCT?=
 =?us-ascii?Q?ZbTGJ4VQ3rlLAvBRB67dgSC+QBbhgqDgq7wiiqQopXcLls0fB+9R+1B3Jptf?=
 =?us-ascii?Q?Ua7ZQSKTWRMAlB2q1WXOOjo+fcODpTh0MbAmRi/1n7HZOKz6mm7PlyfGgs6d?=
 =?us-ascii?Q?uu6TsxmGJ7THuHAEJLK+pGZbR3qNc2durI5IHG72H6zfB4e90vfaZQ31d/1z?=
 =?us-ascii?Q?gGb9rM6MLiYNH1WqByeYMOtw7/u1Gy2g2+jrNAEl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cc7049-1812-4b11-128a-08db4d50f73c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 10:10:34.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIjGB0ID/5fG0ROqOlwPFVI7DX+j332OAyRWGK8E+qiGMrlXK/AOJwP/XqXPvaJFR7vPUL9s+CU8Tu76pA/Qhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Driver do not use this property, so remove it here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index fbfd822b9270..e34b4fb4778a 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -96,11 +96,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  fsl,wp-controller:
-    description: |
-      boolean, if present, indicate to use controller internal write protection.
-    type: boolean
-
   fsl,delay-line:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -190,7 +185,6 @@ examples:
         compatible = "fsl,imx51-esdhc";
         reg = <0x70004000 0x4000>;
         interrupts = <1>;
-        fsl,wp-controller;
     };
 
     mmc@70008000 {
-- 
2.34.1

