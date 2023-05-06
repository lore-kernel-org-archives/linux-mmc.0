Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E95C77B75
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 07:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEFHil (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjEFHik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 03:38:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C81BE2;
        Sat,  6 May 2023 00:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQrJhD6Mz8mM0SkpiIZdGktSbHNebqyqVlO3fXb9Sdi+s433/MfhgI5cjOSRjLwqw/OoeCWWg1PkbpwDPTitKRNwCeoz+ylV/IqILkL1CoxlUxCceJOwv7Rb2VZnZx+Z45jL/PsrgzbGzU2nGPrnnx//ZvBoZEJuNHwnb4isBHum+tmOI39BYyZnYc/hyuV2sGqeweGXu+c8GtcPnk/SI//8yYtOkD77XYyVhZda0QubYdhlpX/Re7PaR1od1Kv2MWS794E+/prF/qkS84jMQJlfVHvSonp1446tf1sG7wpNmogElD14W5ssFUiJZf3CEEG0WCRp+C0ALbxxfwX9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwoOrVm0pKb2cYqC43CdM1jL455leu+gPCJXbdFkY6E=;
 b=NOU601bgI08Vd+S8nJeA2fF7Cy53eG/QIkdgZoTW1K3IUZuOcIHeem1YqUoSUtJzLL/OOOb/9+dIj/JB5kS0/NS1bu6Xy3RR1fzTH4anBTb2V63g/0WvtjT8ZJu43qEjKXABwdcZY6vJGyEvV79aD2cRautzeC9npZGuot+Udsecb6GWfuMB78ZcyQtQ7nUYcYLJIZ/etPNOOfYJLk2Jt/mQvsdO9HYwdLxLARpZ+6/+k0NUm1Pw6Web6gBFucgzNUlA4dExt346PliYBdiI9LlAmf8t0vrEZWvjj0ZBPIj+LFSp+MUnDACF/nHt3zMCDZ4NTQjS6cfu4X41PIawOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwoOrVm0pKb2cYqC43CdM1jL455leu+gPCJXbdFkY6E=;
 b=D4Hs9FGkaaEOpzEWtv8Xf1m4UYlUMsv86Xc8kHvdH7nZwFD0czMwIKHx2fy01iyDga8xCkA94DhArw/SV6W99kUAsuHSiHSL0ggFTsvdSP5Jt2a6o4OCQkIaaeE5mAfoqN7rYrLO4NrhQCuFc3xvFr8hhtWOkek5e/BMLbcq3sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:38:36 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 07:38:36 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property "fsl,wp-controller"
Date:   Sat,  6 May 2023 15:40:36 +0800
Message-Id: <20230506074037.522961-4-haibo.chen@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2506270-5d64-470b-5394-08db4e04e6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0DAI+cNSOYGMp39yjT4M6yq4fWZAjUtU3z6Kb5uoPiHXmWCvU/bCJ9zrtdR92GE9WTaIRRya9D2IIXfsytF9Zk6QZd/5haRI2wmHbYEGssu4/fFP1BGAUOa67SEj5rZLU+SqM8GK+ghJHlXO3PdvjHoC1OvPlgKtJT4gEElScvcpSImaw8rpSB8qOff5vorB1Zrl4PS7LhI/xJgHscmqQPf8TnOpkS2B5vVsDz59Wt48t+GGJZZecMLDx4KBXE56C6t6nu4ZbRPk02edwnFVacSBzJoKI/9ulbSMSWw89X9W3lIWPIw9j+3vzNfHBgYNLy5RVDgIXPyQ8J5S6G9JoQFKWIBFhF9E5Ea9BHuaCLLDwC35aCwEaoJoNH9qCPjNYqDnuHNMlBKqMpG183CEkF0OmNDPSewS0LGhpVkNLFKGoL5s7htqMWgNILTRwQFAIxtXOJAGkeodcWFD6c0YRr7q18sTz4T1T+9JoOnvhUhPfoYANG05ZAeeRXlWX2gy0Lj8gxmW03/rnG50LDGruX8h5xVCqEia9VYBmcs4ZVxkxepAvQ5Y3SpTTbjd0DvC+1yI1Kh+5Z2oLpK8zh7EuoXPOCCJ3p/MC5Isb+DejazlIXW/N+I/LSFBa+QW5kd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(26005)(41300700001)(2906002)(186003)(83380400001)(478600001)(2616005)(316002)(6512007)(6506007)(1076003)(9686003)(8936002)(8676002)(7416002)(86362001)(4326008)(5660300002)(38350700002)(36756003)(38100700002)(6486002)(66476007)(66556008)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lw8/GAnpgJDxQp01vRp3nDcBNovltTDW9sLDwN/0xfTEjn512RduEIvBw/34?=
 =?us-ascii?Q?WQEu49wZJfQGygCf8Yg4GseQ1vQNYH0jDBRqIcBBjcagdlb2bhvPVfaQV+Cq?=
 =?us-ascii?Q?Z2CqiOkpp09JkY35j1L9v1Y79hvHBklTFTOXHrMQ+PKdzVjI+4AwNaDIW14L?=
 =?us-ascii?Q?ndfpeZwdWCmrVx0MNLDUu37/Jvh5J+Iotjz3rTlywxEXIkj+AD0u7YJ5DLdh?=
 =?us-ascii?Q?EFX3VKv8oLs7xa18OxWsP8m0JMqzjXjNAcP2mD3YOy0G5p4yMGM9ypHVAg+9?=
 =?us-ascii?Q?xHMy9VjNl70OX7ZVUuey7fQh75+Kr9ey5p52yWTUq4Q0uzl+abLs3LEp4kr6?=
 =?us-ascii?Q?dQUND7554wsXebcXcUdr0BMKsqpTj4/1/c2lTy9CzfLIsCqUpkO6x+zaSmSQ?=
 =?us-ascii?Q?B9mNhU8AlZ8HYjHWi0C/4d0CnzeoP2PCxiZ8R4us3KCQGYFkdfomXQtCrACF?=
 =?us-ascii?Q?AzNkKn3MN8mMOs03EGEuR45b2cTlnTbTd79wnthrT/A2GWsg0KBmwnhn2TYL?=
 =?us-ascii?Q?q8J8//XrlJxv5Zh77tFR1BzedHK39jXQ1wk86pzGBHgRP59PIPYfpm18/yOZ?=
 =?us-ascii?Q?G3en4R1XfKXyO6Xcvx/IvRX5rYdMgjmwtPmb4T5SADcV4HF2wOwD8BAeCRqK?=
 =?us-ascii?Q?WGDCVv3wG5nb0gbLfWrfoWLq+e7dMERUbWHa8V/5HiqVcghcTbKp1hlEfBKL?=
 =?us-ascii?Q?uarOAqNFUrDD7xRYGkBYGUFooExG5Gg44EpHvMj/27g4cd+ldw/pJIHlPX6B?=
 =?us-ascii?Q?EAF9KMpzPjM9koGZ37Y1/zmjV5e6G177pgfGYBgMHuNC+2javkrWv0qhHCPF?=
 =?us-ascii?Q?KlC+3OcUwnfWWOGj5RM93YZivCW2lA90p1Qk3uZWOTMxKn2FCmDkIbcdGRkc?=
 =?us-ascii?Q?C2n5Kf3pTB+Dob9JgAz/Jar/IxvYWEbNukF6J9lu2DO4KXoeY3Jrt+D3ejmi?=
 =?us-ascii?Q?lSBOzRsten0AsxJ81svjc5KB7xiFi8o9o/EeurHUWpHVDRcA+zAMrXqk1SYA?=
 =?us-ascii?Q?ooLwEP+OV1HKy7GTWCZlKgOm6V7wIn6KZByfa+0m8wYo58tw68F8F4nR/jQO?=
 =?us-ascii?Q?RsmRT4dY2ql9fDDuoA7lRzHtjS7MW0lEqNmaK/g8RHQXvtkHJ4KPmbjFn+Ia?=
 =?us-ascii?Q?UmItm/6a6WUxvgM5dY+Owf7KNt2baM6F0Ui5d5RPiROQmt7UEzHAewoZEuif?=
 =?us-ascii?Q?2bOsJftF6usBzW3cYOvQFtvSVNjcKBb2QITy9vQtc3H1vCnCFLiS7UYWfUBa?=
 =?us-ascii?Q?sskdD06p+Km4FIs5BSHtmwt7hG2nRoNToTtS4P/loi8YSeY0fvAwCukzj7cL?=
 =?us-ascii?Q?w6NDc3gs6XE58kt9IwWQzGSSc8I/BZ31vdZ8JkUGPyaOYkwMqlks+21fA40n?=
 =?us-ascii?Q?JhkpMc5iWwqMKotEwZxPHl26/+o+poa7mWgEQZZDW4DoBxa/0RMcQRA4c6Ma?=
 =?us-ascii?Q?fCu1R7aF1bUSQN0eE6vM/shP8DNPSI9/qLG3v/m9fsAZB5QFje8A01CmRE9N?=
 =?us-ascii?Q?rDS9r7u+LG1GQkRXh205Hom3i9GqBAZfByioUjHEN8w9IxelcV9GHN2c0d/h?=
 =?us-ascii?Q?ih6bf2Ys18fG16jvfxsV51nNC1UF137C9mjBHV/Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2506270-5d64-470b-5394-08db4e04e6c2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:38:36.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaUrtpPqVZw9A9kU0hW1VArwoVs2YnsmbvI3IqyP4YnJIUWj7QJZkF6TjeF82xUbGAuJacgY8vLUc2sndeUB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Driver do not use this property, so remove it here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
v2:
-fix dt-binding-check issue, also remove "fsl,wp-controller" in examples.
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

