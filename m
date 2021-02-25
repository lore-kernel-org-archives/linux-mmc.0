Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45900C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016DD64EC4
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhBYDXm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:23:42 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:43061
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232723AbhBYDXl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Feb 2021 22:23:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH04lAxva28sDiO51dZCNoJKNtq2FgDi71AZE9M1+qlO8CsAWWbBZowmsnADpRNX7Fp9WEs1LrARugqCivRZLBBydxktF/QumdiC0g7NOZPWLxpswG0A5kHwK/gf6Het5nmejqqRuE9Yw6XrH0AThcE6LsRKHE+LZBMKmvC5ktMTcPCcZxe81mzZTLlkoBJjHMfZK+EV7Yj5jTr/ARJjGzHoGcmlbHj4oDuy2ZBReOrdrxQVNDCAvxt/lm6VtjMDGQIiIDc+Rd5apfZ3yEBZUzf0Gv0mpGqdBs3KE2cSg83uWjIqhUYq+in3eLAqxCMHLWRXD8jVkewhlaW6ADUnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI5e+rFJBLpAzVtuBVlng/SwYRFZMCR58hfFtaTRJTs=;
 b=h4S8rwz381oLP2djzU02w5mPcI/nl0P1WDxRS2Lew0sUOmaprFylukdkrNUO3vGFrc67+EYO+C7QJkFlPEnG1VqfrrohPzb9mrSnN+cpSO5rfn6L1q5vgUDITyKd0uGY1uasnPEwJ3A0k20ISY6FC5svstIl0k/dBu0WrS+eJZznf0vuj8iX62SrYpNlmJC+Y1n58wOQXFO+Lf7egEh4KVaWiMrCY/3ct1uhi+Sab3V1VOAJgGj1u2/uNoH12aFOqWAFv44NUIleIvfVYsOLwBZ7KACeitSbburT4Iu9F3RUVog08Lk4VgeMaFzP9dGKt1A/yok+JrUvpzE1YUdV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI5e+rFJBLpAzVtuBVlng/SwYRFZMCR58hfFtaTRJTs=;
 b=L+jvEBXW7WMYJ19Jkb+thj24fbvzZWqVZRoXovR+y7ZhXLCCCrZm23ltq9by+1fBSvVY84D03z+MKNAE819vKvRzkNsmR5zaljhxnZUEyBmoncq6K84Hpw3/ph2yQTTimj1hzyb1tiMs27y1s+XG2oGZqSLzave7tOfZnDno7dI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:22:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:29 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/5] imx esdhc dt/driver update 
Date:   Thu, 25 Feb 2021 11:09:59 +0800
Message-Id: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f40012a-08ef-4d8c-efb6-08d8d93c946b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40891F4A780132D0BD63CCEBC99E9@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jd8KqBDGKiMmqEBrZ+7tQDiAXUkGWYvVYnVsAmfifnN2oRN96lOM4W5QJDXllsLrBCzYJbEp16vExecl2+vP+nNknBbjnFi6yXdh6Fk7skvgWfwW84am8y7HAa8jKwdo97yDe5yUTtiliwt6cK+setzE93Q4dLDW8ONBQohovnyZMr+V4m9T4TvyjmJHDSNImHu2bN6o4VHyFLRwx/feT2lHFD7T3Y5zsP70SaMw9s9k72Idor1GB+mZUgNJ87GZEAqVx7V3kifBPN7o6CJSwuta5QtbQ0J+Vc2NfTA+k4k8wluet7kiHMI70QefhkGBnkUV73BzZVIJUel6o73xqhRrQLP7C3hQp1AGvkGPLlKb3ZTfGnsz8c5IcEWys06s97j5C+yURIJSFRCuPx2ZloREmd+6x7wGhyExLm9wrByqShyMBpxhRotVW6/uLxL94/eDccyypJ9T4ysuq1t5WkrfzvrvEtXU0vzNb/C81Hl4+AxpXN3zB8TAmPFYrie8x4W/0u0ry1pyF3X0cAHXkRhaIAsYaPUlgtuq9uQOzTClnWR1irk9sy7y7s4sWbcVmftTz8lsW6W+9ghoDSxxK8u5c5KlW3rRptuGbs43vr59zq6Oz8DbeaC7EWYsWS/8ibWz1uVkCyaAqPzKhUlVtSFaoS8/KxDg5FFqwDvzKps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(15650500001)(6666004)(66946007)(316002)(8936002)(8676002)(66476007)(66556008)(966005)(2616005)(478600001)(52116002)(4743002)(186003)(4326008)(86362001)(69590400012)(956004)(83380400001)(26005)(6506007)(6486002)(2906002)(7416002)(4744005)(16526019)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WQZg6i75fwTZasupGOIe84/8DBVq179AaV0LJr5gWp5Iif2w1Aw7IUaScxUX?=
 =?us-ascii?Q?JgEcR4RH+jkL+WSHL4luWegHFWv+F8lXDA/gmYQLYw2PgUL3f89nbjXbwrzs?=
 =?us-ascii?Q?lXsHc0nTJOWH2Aw1GkaiDwFxcqAsuqsz6Dp9LpTSZFmo7Tj0JLa2os62BYjk?=
 =?us-ascii?Q?5e4EqQzmqRJzdAoP/vVy596kAyblW0rZfQy7ShQFwK8Pwn9FuY2M8rLUNZQ6?=
 =?us-ascii?Q?ynGGBWHQ4T2dgMBL7Z10mdmuA00dGVykwaaDWYMyjpK2OXKXMxygt4Fj2gsV?=
 =?us-ascii?Q?w54EAgC51fMm/eB6Mf2FyrxxUiUJ6UvrBdal+HPpOcprv+sCNiiSx4SlqbaX?=
 =?us-ascii?Q?ryRWeYbJQcjZ7UUfZh0ec4bbMFCfD7TrzODCTf3H3vDlz1ZAy09I2EFAjeSi?=
 =?us-ascii?Q?JItqKRckCTyW3LZClc3FV9ZxaC3gtkqVNhydv62iTj70lI/EspNdairLzf4U?=
 =?us-ascii?Q?4vZpFBM+m+I6HGFPn0CAxJulHGiCKiHcYBE/y6neF3Xw5jFQC5D04NT6SHBy?=
 =?us-ascii?Q?QL+WvzTENeeMRLaXk76QUh2PK99WLIMrps1Or2jS06gpdAPDstqrGri21hPz?=
 =?us-ascii?Q?CiUoR0d5UBWXVA4xx1YkJZ+biP9SxTuC3H+JIaJ7gjAErFvvS1B4Q2sWtsWi?=
 =?us-ascii?Q?7vCoJ8kYbAzsreMgwPnrfxpNTl0d2ymQoQkGbVGD8s61eX+VDKUZPxzQwFE1?=
 =?us-ascii?Q?SNKIxz0ijiKiUPbAh/GD7FnmGGfyDlSuzMAHY323rDfeNMNZARymgGVuW0yp?=
 =?us-ascii?Q?W7IR2+IKTlSqma4ArEwD3F5qxm7TDDcShen/Ew2KNzglbuerKH9Mm7oFQqgy?=
 =?us-ascii?Q?Os8eyKrlPTzzgI2kgGSW6qo3ghR1g2JLy+CXi+IUZFvSwrClfYYUj0z6bdGk?=
 =?us-ascii?Q?P+xWE5IDWWzBeA3jWGgsfXvlFy9zY4A5SiYU1DWiMnkTWiBlPaA9BLlAj9j2?=
 =?us-ascii?Q?jfqQV2Jaf6IFrqCPPzWPObaCJnvCmRq9t1A5Zi3CYhJjEC0RFL2Oj8/p4dD3?=
 =?us-ascii?Q?owR59khqID3b2uDmfm1OOe0f6pjU7CGcI9V/noBla7EiHioJd2/TWdakG4bN?=
 =?us-ascii?Q?613f60ccNbnyJsXPAF7VA6wjj94uXvPZc2YLqlmKfz34o3lJ4eEkMgJ+8Ic3?=
 =?us-ascii?Q?kd8kc53glg97070SQGEs1lD1oZSE5704QWGo+Y0gPqDm6JwElbPItPk39zKH?=
 =?us-ascii?Q?efVUEfTSbiWBAdRotJSvu9U7wYXA0wS/XYZ7ifo2w4T92DF090NR61Wj3rYK?=
 =?us-ascii?Q?6dPITM33voDzww/dMhJ+OgTFF5skc7BCcYH/7cbzsoEG2xZkmEQeuR+Ah6+C?=
 =?us-ascii?Q?EVtJvLCBErWVaPW6QQJ4LB7p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f40012a-08ef-4d8c-efb6-08d8d93c946b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:29.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmebUqAKHalFHiRZKPtCkj77zkVtFhEnyQoRJGUFAyatZmU7FmX01CqlgRgOG4RN3vzfnINl+AgRVBm0y/+N5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Patch 1, drop unneeded pinctrl-0/1/2
 Patch 2 is new to avoid break dt bindings check
V2:
 patch 1, 2, 3 is new
 patch 4 is not changed
 https://patchwork.kernel.org/project/linux-arm-kernel/cover/1611198593-16287-1-git-send-email-peng.fan@nxp.com/

Peng Fan (5):
  dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
  dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
  arm64: dts: imx8qxp: correct usdhc clock-names sequence
  dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
  mmc: sdhci-esdhc-imx: validate pinctrl before use it

 .../bindings/clock/imx8qxp-lpcg.yaml          |  6 +++---
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 20 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 ++++++++---------
 drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.30.0

