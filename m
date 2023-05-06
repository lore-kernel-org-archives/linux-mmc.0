Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213DC77B75
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEFHia (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEFHi2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 03:38:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD05FF5;
        Sat,  6 May 2023 00:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaklItUOUKlQ6aoB1thFJvkO+QazH/kF7DdZ2FVDMCmn0oNUS89mwAAl2MVhRyAK8Jtb+h3LZhjmdIQT0HewnDVA+HO56ZM/paBuYGgl/CaJ41orSDY1vGwWDDV04e9HMXH2iFX2tFIoKetwRW1tPcHx9i2O9ycABbB/2LudVt/8Jkn7wtF2fSNysEANAIbaqrWAWulnjhYCh6qFcL9k6msRbhEkDX3Zu+uCtXNCkah3rU+rJEXhvg3dg8FfrqCYDWl3IzcYyOkVfUnbvQ63iQsY/u5oZKP+eeztbQEeFhyV+qRD44wkxl8F04Z/t9ecgzl2CouEMSb43nO/0nVzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqxNDPS73ogA0DPZPMTghZVOz+6HGKIHGNS+MX0k+Ws=;
 b=JMgZ9Jn2q9T0ToxMYz8FaR6z/AumguqX5h16gK5wYjiuP5XOYbdBAm8J9QuAwPAyfxp+q9GFs9H2CNN5+lt7z4nvJp2hrG9DK+vQPGSZjTUsibihTGDbpMSd+WPmFVW6w2Br8LZOErznpmYyQjcMT+HHhKrAjC759XAkXQeqYV7hvyzSo6d1MLnuqFsIlFYL9hm0gbk83/Vz6EI513hTAY3hPMS5lQk7k6g0Qoej5IFHNg/Kga635gmqpHdJ1WO7UA9Eo4SeKJHm2sEly8iAWdSznKBwb3JWypOs+euFeI3h40XNxZDnS7HGuf0etTsUdJ6uQeuRg0eDFDRWpFhiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqxNDPS73ogA0DPZPMTghZVOz+6HGKIHGNS+MX0k+Ws=;
 b=lDzT278xLmjE50LZFQyDJZAS2HlS094sY+inyQm6Sa+K+3BeV40RknfJZ3+nmMmybOAJyK+EqcvmQ6M4BHsxhY1fm05N4Jru+A8wBrhtEqjlp3M1kvRXjaqzJUMgD/uNxoMwGVC7KjCZv26DN1PSJITip6jhyKZ/jesUjQeXtxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:38:23 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 07:38:23 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 0/4] cd/wp code clean up for i.MX USDHC
Date:   Sat,  6 May 2023 15:40:33 +0800
Message-Id: <20230506074037.522961-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: f75172cc-cc6f-4a46-aec7-08db4e04defb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: souI+Xy/atPzAPKK+0rYV6J8K5aRax5ezJOnIm7g5JzPyXxAJAG4AfYQ2fWrWXrHyllOTsIIAEts1ebpkb3N2Yi0OdeG7Rl6EbxJus0B/a2Se7SVkcyLCp4ayjfV2K5ERvB/ptbtMHSZH09cNbRB/a6xEWz9P00zsKYQWvnnPp3FGvN51jnsOuEeufLUuCiIzy+Gh5LdoC7O2grKxjp5dgIZyu5LKLbrqiR4TCpeCnN8/tU4Zw5BnWaDw4Kx3Ob3Q4CgSrh3nCXS/oHeFeEd2RsZC3HlpzUMB93NWP3JOXckPS9lTBlcE2Y1jgQ5EPlLI67hqSRO/omdTDNbvMNGK3uC2vjdWHlg/ZOkf+VAXxaCX19FkM6dy7LsayN/WqaNDdVDk1AUCV+Plg5TheIOHfK1WU7CFrOs50t2y3O4zTBhKKB0yz1iewZY2H/+gP3gnnoQGtExfMYjdKchLh0cBnXrZ9xiEHYIGayuW5q6VFSwvF/5sgVLVUJ5oWl4QdHSZctXxvlxKn+6fyV2xmU+15shFSIFWIE84fNS0QW56TaZJcQhcMaoJMysKUKwre+LmQ1n6wnbKJz3w6U/Ue4WKPYYdJv+8bvsqnPOQGmW1BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(26005)(41300700001)(2906002)(186003)(83380400001)(478600001)(2616005)(6666004)(316002)(6512007)(6506007)(1076003)(9686003)(8936002)(8676002)(7416002)(86362001)(4326008)(5660300002)(38350700002)(36756003)(38100700002)(6486002)(66476007)(66556008)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8birocjzK8gEVJiN1OArqQVdYNnQZdlj8iCOHlprBRLakLzRYD+F4o3qA3Y?=
 =?us-ascii?Q?7h59uLNVCFZ4okuWMUObm0MW2NqZPAG1pm8p87TsIYSTo4R3teU5SyimQfSs?=
 =?us-ascii?Q?H6sKZjehRvmAQGCDPrqPPKWYZlveZL0BdVlY7R0CW9ONG3IFhbvfMrzTLC+d?=
 =?us-ascii?Q?HCCPMfP8WR0jfYP/C9lg9kVs0cr4VxBxrpBg5nES+AIHDGTH5alkBloiHFtz?=
 =?us-ascii?Q?brLS1gYnOG+ZZOjme7+ebYvgn4dr86WwmRZdN/ge5qH7bob5xrkBFQ54uisQ?=
 =?us-ascii?Q?R9awQMzFCSQl+6xAoeu97qahOAjW+CEW7CXsZqYyACvi/OsilH35Pe4MAqRU?=
 =?us-ascii?Q?zgEZfVVMwdBk3IM+6DXHCv4EOjHJywBAQfuZQ83GqX/iBvFfrOfkruv5/cx5?=
 =?us-ascii?Q?XUilE/x956S+ee5W3cEvMTOGU/1+XpZYf+y/ru9RyNqoYUNk/Kvtkw0xFFKu?=
 =?us-ascii?Q?7kvK/G648WI7CbazqJdXyZNowtnAjGlhH0XPQRu+LvYm0R1QJT/BdW3C9ApM?=
 =?us-ascii?Q?FUHcs/yR5hXeavaqLZvuj5K0Q7tz48GrWTlx1AzTMlSgFdjgIQwYYvUpe6X8?=
 =?us-ascii?Q?NcfsTbrWN6VhwZXfbc7WzH/RCxj1q++jW6jXigzhxM4g9N6NQShTTJhgxULL?=
 =?us-ascii?Q?MpFTTB1ic29/jhJoPEGco2Xr9/8MBOaYQzkjiSOLxrlN3gFVflLP1WWAycAF?=
 =?us-ascii?Q?vUTYXSAyT+KAKR4YmQfLwMLeBEyeX7NPik56BpoQ9mCikL+/WsiFdD9bfnZ+?=
 =?us-ascii?Q?ChymK330DnK/UNPHAhNO0t067eIh19ko46nV1IndZXyGW39oM3rtO6s0SeTL?=
 =?us-ascii?Q?z7ivyOkw0CasfdvHYdr6ktXmZNCf1dQhWSt4IeaKSXEy071uIZGq1Z0yx9dy?=
 =?us-ascii?Q?/nDcTxeB34b3hnLH4DoFzoQ0CEz113+PrJA2jfoo4y5cMc3kOf24G95asfPQ?=
 =?us-ascii?Q?NoBYJU73eBudi0sUUB+94ZEwlwiRcyPYtzuhSVhHvOeGFz+ms24n43Em9dea?=
 =?us-ascii?Q?ucXcGfzmxdgmCS6OkDpqcQRNlK9vnh+DT8xZ22YkZZPRlRnDkuAR6bJxFsTu?=
 =?us-ascii?Q?FtL5jqbtRqCx15MHE6PHrHWoXveTeupNzyLWZ8bR8LrBm6TTiIj7E2eLUTOn?=
 =?us-ascii?Q?F0xAPs5rJJ0M2cHsnfX+3L7UT5nMb0Sie9Gz7slXmRrx41SeibzrcJ0QD0nq?=
 =?us-ascii?Q?6HLMIKqobj8n56wPcXIHaKn0wBOXsiukZc0CLY99oVGALuy3/ucCLbTcdThE?=
 =?us-ascii?Q?XYhLspcqK6dykW5DL9Wx1IMPRa9w81wY6H2Rzc+UNIkizKNMwk4/6xQ0imBY?=
 =?us-ascii?Q?OHkqE3cHO0Qiij3thjJ4wTCow5SBCQcCdMKGiuBxY1582LoO9JeR6ZB5ImaM?=
 =?us-ascii?Q?3wi/9EOm2NWm4zeHk6lt35jS3w6K3weagL0oPNiF5OQnUDre1HCHMlbPLT7c?=
 =?us-ascii?Q?fo1Wi5egwLq0iLD1NxPjir74gN6OePnDwYZZvbnl3Dj1Wy2ex6ZNKVowtxDe?=
 =?us-ascii?Q?QKJv8c3a5oTLMX4DZYkbcIZYRsa8vM7cRLFx6JKwI2+yp4S/w4tRm5uee8fB?=
 =?us-ascii?Q?qXzk/Foha9jJeP78FWdLJZ/HeGawbxw7kLm3IuSI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75172cc-cc6f-4a46-aec7-08db4e04defb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:38:23.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7x7ZKEa4f+fzp+V6v4yE/NfHc8wO2aLAlZFk1DTm1FVSCKbR1ypL0t5pcROh4oa/3VTelR/yWHLPiOvN7PPftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Now i.MX USDHC driver convert to a DT-only platform driver, the legency
code for non-DT is reduncant, like the cd_types and wp_types. So clean
it up here.

V2:
-PATCH 3, fix the dt-binding-check error issue.
-no changes for other PATCH.

Haibo Chen (4):
  mmc: sdhci-esdhc-imx: remove unused enum cd_types
  mmc: sdhci-esdhc-imx: remove redundant write protect code
  dt-bindings: mmc: fsl-imx-esdhc: remove property "fsl,wp-controller"
  arm: dts: imx: remove "fsl,wp-controller" since it is dropped

 .../bindings/mmc/fsl-imx-esdhc.yaml           |  6 --
 arch/arm/boot/dts/imx53-sk-imx53.dts          |  1 -
 arch/arm/boot/dts/imx53-tx53.dtsi             |  2 -
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts        |  1 -
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts        |  1 -
 arch/arm/boot/dts/imx6q-bosch-acc.dts         |  2 -
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts  |  1 -
 arch/arm/boot/dts/imx6q-tx6q-1020.dts         |  1 -
 arch/arm/boot/dts/imx6q-tx6q-1036.dts         |  1 -
 arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi      |  1 -
 arch/arm/boot/dts/imx6qdl-emcon.dtsi          |  2 -
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi         |  1 -
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi         |  1 -
 arch/arm/boot/dts/imx6qdl-tx6.dtsi            |  2 -
 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts       |  1 -
 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts       |  1 -
 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts       |  1 -
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi           |  1 -
 arch/arm/boot/dts/imxrt1050.dtsi              |  1 -
 drivers/mmc/host/sdhci-esdhc-imx.c            | 56 +------------------
 20 files changed, 1 insertion(+), 83 deletions(-)

-- 
2.34.1

