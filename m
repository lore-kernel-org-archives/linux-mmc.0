Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78EEC43332
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A558764ED9
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 03:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhBYDYa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbhBYDYT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2021 22:24:19 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16193C061788;
        Wed, 24 Feb 2021 19:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LndRDWEnTS3iC+SuXxAHTGbMIfJuRAbfshnm/UeGSUPVrmyL5z6UPe24SgzcYD3d+WtvqypeMP1sVuDg14ZH1BITDjnr349hyg/gNr6DqSKI0NOW8C8twku3mnp2B+OdWdrqKe+uzJHv/zkGYlxHR9PeeYQnjg17Yam1R5Vk0xWD3B5fqEkBcnHoQrf6e6K8AaS/62Mi+znGhQamgQSI6XKrPKnTPO5zaYpRZVVgnU8rSo9iujbVbasrYgX/uNnXsk6J1MNHqwtdjpKK5CmS8lg7y2hWq6ZgPRZ5Ny7mHX6hCDKnO15hVsc4MWOnjh5+WVxO4mCSMhfwkb0UudHLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBuJc8UxcXpW6ZqGYUCPs/BykKRPfVROjX0KyVi+wQQ=;
 b=nBQuFlvW5JZ13g6b47RSezSysMsQXdpYBn4WJHz0KpsICnDSz7wXvL/oLAPjpi6fBRG/ow0KcC9RhmqAXnt/cLJ8jSUPzYRpkb+2nkDhpWlBweoojqjWTUV+siOZ3j8Aov0hlH333uRg/0iTIVlhgpEKgw9ByZIJ8pNUOVifUhKBJFn7ePFDpxdYjWFfo2GbfgCINMED7GWyIagskSSQVD0ublxR3pqLSG72lgmQjpUzQ6tGnEn5QV2ivbxW4peUSQkhr/lpBz4cewxNkvLqcyStgTVx7FyAg9JmwNUimBcBHHyGWD8872xyf6bWVowp1qWyHxUt6M2fLXxvsZMl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBuJc8UxcXpW6ZqGYUCPs/BykKRPfVROjX0KyVi+wQQ=;
 b=c5MiQMGWmgQ8drBHWVsG4JWogmiMZFWWqOMp6c3nWqY6nkHHVvTbGfK3IyXno3KfCWmtHrWkvQLUJ1JQ1ttbnd7w2Uua7E/O83tZQ+CJYKaZF8kRVqlhK1f0mo0UuB1aCymZK7JWiPiESOO8QOgIK6/bH1MGbjlgagVGSf4y1Es=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:22:54 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.043; Thu, 25 Feb 2021
 03:22:54 +0000
From:   peng.fan@oss.nxp.com
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
Date:   Thu, 25 Feb 2021 11:10:03 +0800
Message-Id: <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 03:22:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f936417-de28-4462-fd8f-08d8d93ca395
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4089169BFD9CF46739769FACC99E9@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSSZDfiHEVNjRSGCr+6kKsDc9ji56WfBRNNBJOnGmON2mloKnIdjxuPIsSVsR1mLaIauN6hFkHzAlwwo3cRRhXX0gQctTdMSVKNO6ImM5qrMeWiSpc9rLQBvNOlP+QtPVkUJSF0tC35EoDpqBNswXN9QkjOmAwCN+0TF4O2h763BssP3NWQEe9HPef0OXTlm6ZeaJVpYKSoAz8FvamRoocSsx9fCgIuEP7p3iVUVSOaui4utPtTnu+sXrsFX99zZdgIFN9lpUXBR7+Mok9OYeBKlGvLEt0nSLpn8eZ7zhd+9kUobAbkOC3TS9Q9cvdRV/+1bXRmlZZCQ6tQQgxPtZFS2qqxzAcGG3NRESR2S9eSDtk/RLVOzm01PriVSC/o+8fUFITJneBCgehDGPQk10mHyVMzofeIqYHpyRORtX+hDwpfQ8EKo9KhIUc9k/NSf78U6Y4nM7WQ9bqIP5QQ4jdwj005avAGA4ByiZIM1bvLpSOgOFZTT/SFaNiGA8ClMIDzLszyWBoS7EnTS3Rd+fWuB0lD78yNLmYo95ATbl8/2rGB2bjuAToHk7hWCjV4Mcd9RJBU2o/IpBS8gqH+jCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6666004)(66946007)(316002)(8936002)(8676002)(66476007)(66556008)(2616005)(478600001)(52116002)(186003)(4326008)(86362001)(69590400012)(956004)(83380400001)(26005)(6506007)(6486002)(2906002)(7416002)(4744005)(16526019)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2Ku0s/4p7o0eC6uchB+XI0XNqwOVWk4sKqpLKkDUopesgfNv0jyBdT2co6Aq?=
 =?us-ascii?Q?lbPnTdDLORANnzIWPeSgFeBmKUVIlB3xlm0LA3dIOFPNpHgFb9g2CPayCtBf?=
 =?us-ascii?Q?JJ72MrEZC8a+pFLx+ZlYkGy3kAOEO9fqXN1juMr5C7xJiLOrCr+6R8YDZt3U?=
 =?us-ascii?Q?RtHOaSCOq2Yt2twyqIHSU1EQ2xkxf5VnVTyrABv9uXlIZxVdFb+RYDKhpysU?=
 =?us-ascii?Q?k1DRmQ8fbink/xXuVyPlzlBZv+MFGAC1AXdRRAHKFEJgAh0aRWStVW8D9B05?=
 =?us-ascii?Q?J3yIVdSQRfSfXh2cuiY6a2E2YRvnLXeicYJEhsyiUfJha2sywSDzNe4yRTav?=
 =?us-ascii?Q?HldqTfBy2TF8jUuADcVerfsvFljMsFhm+dpRKy0UO+8feEYu6bMSwfr5Mxkz?=
 =?us-ascii?Q?f2jOfo+w72G63LX1v8waIcMZNXuIY+0afEPyhExnF9KsD34TKloVw1YxEy6S?=
 =?us-ascii?Q?KxcbL2qt2qOCXDX7mntMEZDq0zUv6J9jL1Cmj8jmQrP0xKdRVONv1lWcmD1B?=
 =?us-ascii?Q?f9Z3dJDFTPRpnM3cTm+lKiyaSzBQbnCaEVhu5dyc1v+HwDdgn/uR0063ck5E?=
 =?us-ascii?Q?4LVbKOMTz/Rs2hfFii/lLmJpW1MFifd2h7b0sm36jDZoLNg6+PIN2QWdGDvJ?=
 =?us-ascii?Q?YZO7IK0J5LMuhWzaFwO071nTFZyWrN/QbiB9tWqGx9mrH3T1A0vP0a8yp4J+?=
 =?us-ascii?Q?9yc+mfgJ8bVUL0yXV1/goQBx4+zyM7a4/7acxb/dR94+7SBy4gCO3TaVnHG8?=
 =?us-ascii?Q?DPsiJKiED5AAjJzk+Q6JroIOXEv6G9LE5KlY7aFJjiN9XwxD+EVNo+dnjxNJ?=
 =?us-ascii?Q?OVNSJmp3HAaKq9V2omnZJb7P5qI97OPdQlFRlr5guyQpSpaNOYc/EauGGQP9?=
 =?us-ascii?Q?gumk5ua2OsWpJ0vnscjDuVPCLNdRuBt/AnbrGs+NQhxi3RrjJ0qPGdEFMLUL?=
 =?us-ascii?Q?MXGE6PNf8nbYuN1vxJqd2qwbSrGnOkabexMmgCA70DnwywYcVviMqBmJdIfK?=
 =?us-ascii?Q?4Eg5ho5zgSI0qSbM+eI3H7sOoGN+8NT2j7AS772Gue9aXTCjEx98m7uPeRS8?=
 =?us-ascii?Q?3SW0ZSFc2ERP/+VnIQ90s0oX/hB/kmEwKF4Ud+zIu6kNJicDDLN3b03oKvbg?=
 =?us-ascii?Q?PPZjYKDRZEnIjaB37UnN8+Px5GlVbogKhQTe+GEF/kNuXzMG5LfMClsRPVcR?=
 =?us-ascii?Q?JvCbfe2Z8EEbX/2AUPuwc0u4lTxXyDj6YrEgN+qhLUlsXKgOFudbXGFOwheL?=
 =?us-ascii?Q?SsClewLFK/SBLiYhtadfzj1HgAJVHMmlVWKhb05QcvNamtWrmR4gV78mmYj2?=
 =?us-ascii?Q?AjWWSkooWljEd9sM+e9shi26?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f936417-de28-4462-fd8f-08d8d93ca395
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:54.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq0JLgOmd7Lk8ASAid+MhL3rt1hOPTP+gJWVa6w9w/FI1wRH00zYHsfe+9OA2kKYFTUJUjCcr0CxKZSTGAwBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add clock bindings for fsl-imx-esdhc yaml

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index a7fbd8cc1e38..369471814496 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -103,6 +103,17 @@ properties:
       Only eMMC HS400 mode need to take care of this property.
     default: 0
 
+  clocks:
+    maxItems: 3
+    description:
+      Handle clocks for the sdhc controller.
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+      - const: per
+
   pinctrl-names:
     minItems: 1
     maxItems: 4
-- 
2.30.0

