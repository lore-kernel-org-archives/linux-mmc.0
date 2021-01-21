Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5BC433E9
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFEA238EC
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbhAUDxq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:53:46 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:35302
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731553AbhAUDV2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 22:21:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8x59aWAAPEgHqAkn6o4eEaOXend9GBDUQRy7/jrVaCzauvASkHQoTCQnk7MpwAlqLrbRPVp/4qtQgbc4H69oBLolvxEilDqiEQvUfq9hm3RPPJHGEBZ7dzRDoITD6A++PPkSEAJgQMMaRCfAo/BJoWzevbjD4Ge56VDikoYXKuRiENrd8s7y0qhM3b/Q3qt9djxplw8eXnZ+eOi2VXeLmDpRHrzCpYY/WtIg5JMq34ETqYl8iUWzYlsbXBOTH3zM9ijQm1noliP/DexU6jPv1K35PWDMK7YxnT797u75xb+bdVGZ+xlTnL48pWDkmB9OpfRjkKNM3Vy9wmu7mWN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAAIPKJbSEtADFFLlSVi/BaMTbhTcAAhRRXIR31n108=;
 b=dA8tyGc1ZtcvdYtluzs13UQjL2LmzfBJGklCQqBjn2B7y9FDG5om6wSpv9e1fcvX3/aPM1qhKfAKPAfYEyZrguhJzafIn927VvQC9X/xfYgNX+SmW6q1Nil5hyflAPNHq2qfQwZDJNW4861HnnkSmEKVy8nAjY6vnDRnX66JFXzaruvC4u3hQvVEg+fAs65PMEt1lMK4tEm2ddO5bQzUPqnSLFBKBvTl6mC5Yvayg9PUuyIki+nIciy4J9N8shsDTwL+sn14WUmLUd5Int/TNPloVIMweryHIzMHrpLBuliIRRV7nJJ0TixR2ExAdGbbG7g90x0axtiJtr6UUtdyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAAIPKJbSEtADFFLlSVi/BaMTbhTcAAhRRXIR31n108=;
 b=svB9iy7paqTERkpd252yTnfgrorZOBhi6iXF1vomvMMqCRcl7w7ezABQfowhfFXLvpwSBlA4eMfrFYS+veRc87Hw7uPCgkRhKBGKEUwAMyJlEVZwEFfeeXmxMLub6teHIDWoyQD0fTc3/93GETlU82Ens0Ml1Y8Xwrf9oW7H4AQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 03:20:15 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Thu, 21 Jan 2021
 03:20:15 +0000
From:   peng.fan@nxp.com
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        adrian.hunter@intel.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] imx esdhc dt/driver update
Date:   Thu, 21 Jan 2021 11:09:49 +0800
Message-Id: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 03:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f61199a-0a6f-4229-f9a6-08d8bdbb7839
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68583F395126D856221411F688A10@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4TyBOU7DU1qNozgBmTcyuy1yQIeepi2AoRBqJTh4D+Id+qGRVD86wfajPp5oUGpX6np67cNa8x8D8v70RJtOe8NmCg3txb3kJWuECjetqtvtaXC6YapQ3eu7Ep5pfNlI4mTDOcWFbPFPMGsODmZpRsdtJo5TaVNksDheJfc1E8ZigpEYltmw7qBOcPhjq4iZAuV7JZZhGLaGw6FAWNfKS7UcEfDWpWNlH16BErS5JhLBiR91PEm09BikldNBmyJupxoE/x9/+/BIqSCUFaJlyAIa6AsYTS/fERg9CRySNzlnhrijlsSpXU98b+270WbXCq5Hh0/sNzzlCU4rUl57qSfFy6ctJg9tfJ/LZgSfk8KOT0Ya/FhEnYRxg6mZI/NOjsVQ9zvYOvnBcB9/fwYhs85wzVRXhzXP6vK030oGkixKPSX2Im0CUsbKK9QM8NS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(4744005)(36756003)(6486002)(8936002)(186003)(16526019)(15650500001)(6666004)(66476007)(7416002)(316002)(6512007)(8676002)(5660300002)(66556008)(52116002)(83380400001)(478600001)(66946007)(2906002)(4326008)(6506007)(26005)(956004)(9686003)(2616005)(69590400011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HT00WrN1ftHm6CDgfHRcABtL5em49E+HxSZ07xox7yLefIcSLDDTBp6+Np2i?=
 =?us-ascii?Q?BUjwx52MKwUGcBhUbM1BTX7QynndLqyZJqQ9TqCnT4hEWparD5QwkdsuQx+4?=
 =?us-ascii?Q?fUthSaxDOrvOxNz4A9Scu850KZS5vVW60AWIcJlTzB8oWJ4EbZXW+npOTSfB?=
 =?us-ascii?Q?y/pue8oOZQq2Q1BGwS7VtrSIbkJP3+04J9f+9haRWGgXMDvuwFOty84quf1m?=
 =?us-ascii?Q?F30BHJN0MU67WbFnYJpa6sjBzxmURWGsdOaZv9XrmLJHjyYYQAS0oEXffA7F?=
 =?us-ascii?Q?n9FQgLN3dkmJojDGcsXGdoBb6z9w51VZ6W6mLg0SalZPeuLllu8+inPkfpnh?=
 =?us-ascii?Q?QKWxNbgh4H9bj+0wOiUbXJ7StQM5t1yqLFy8jO4DeparAmASGxgNgD6uROoz?=
 =?us-ascii?Q?bJdEutPCdoI3LzlzBBvObidczDJwXbQ1+nCW2z0gNGbxAHERPwF9nuRQ5tfd?=
 =?us-ascii?Q?KXsCLpHc1sd9HBVu8ZaKYqnnzU0ZGuamQ0LtC8eCQsl4G/MTJqmOV60WdfAp?=
 =?us-ascii?Q?693sD5bzcSe54gfOeaGWRsVJe9HZRJOcwXV3mr3L/0uxQCL7bf2Dzz1cXEJo?=
 =?us-ascii?Q?hIipzlqpKPBzsW1yLjJd8NjeN3TwUynTgQ96SXxGYDYNyCeZQOLhpfVaDX4Z?=
 =?us-ascii?Q?+c86lAJNCYZTA28d6xBqDBxXwL7cXKH44wnrJYflPMITCcxRwTUdW/P48Fei?=
 =?us-ascii?Q?7VHemhbQ3bfFqDWiVWiIFs77V+Hct71DJBbDyoPUkDOmRiLELPIDxUIt49jy?=
 =?us-ascii?Q?i5aUepx2jx0XjoHgLfhdDVkEnUIIE6MLif5sXli1xqCRPtPvx3EzuhSCS9Hq?=
 =?us-ascii?Q?ocPjX9f4ng1y3wYtqqkHYTCK47vxsSzngZnZwcxdzNm8FtxLbaWYkgKVu1ca?=
 =?us-ascii?Q?usQ7svl8AkRw+iWLKf7zV7/cMIh8bIWg1PtpLcpBSFLiOwhWG5fnKUuH4Gsm?=
 =?us-ascii?Q?/NznryEQ/FUswyDFRguqtvYFSw8Inn66veTGyV2yzho6IjnrhPdg5BjCy8Iy?=
 =?us-ascii?Q?AerN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f61199a-0a6f-4229-f9a6-08d8bdbb7839
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 03:20:15.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ4HnPTjxwBI6XHpo6DQcJvWfNmSrtsLiKgybDkvqMqTqh6N6J1CdhK5swzRdBbStP1650UHA7hY7JmO5m3i4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patch V2:
 patch 1, 2, 3 is new
 patch 4 is not changed

Peng Fan (4):
  dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
  dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
  arm64: dts: imx8qxp: correct usdhc clock-names sequence
  mmc: sdhci-esdhc-imx: validate pinctrl before use it

 .../bindings/mmc/fsl-imx-esdhc.yaml           | 36 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 +++++-----
 drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
 3 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.28.0

