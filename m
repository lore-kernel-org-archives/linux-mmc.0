Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA4C77B7D
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEEIrl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjEEIrj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 04:47:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54618DF7;
        Fri,  5 May 2023 01:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGkO+p/7QUHkRTXgiqoRubK/JuY0iYw3QbV1ddQVqEI2zTwnob3j98FwZJv1+/0j7N5IN9v0bZK0jU8zu2qiOW9H3AHkNGThPV1wqkK1WW4wPS2eZYK1svejm5pNL3nHXayhHJC0zN59GuUaq9s3tj2A5GBCtiBOcjrspRWgjs5ZZB7TkipLDEOi9539IRjUlOPzEn9lkOs6nloQRZVlNFhVkklfRZgsd7iyRa+XmfU/s5PLT181l//6UedUJ3fMU8bPRb7WN/QsRRDACSjKAU9L0ANdzdjFLG71i7zExY0Mn43365MBnSNz5efT1MmbgaJ1GJlaL67iyoROjuzz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhnxT6IK2GemQsKV3B2D6vviukv8DCJhDFY+sf5pThk=;
 b=AG/jtUuFbhu0wzYNGu3U0kNnsdGueKvqWCYpLSF6x3wIbABhlzu41zeoq877SZtBiJV7eVkeHM2A0zQ33lYI1ubrOULYG39DTWKiquqFuYD3IkxEqttyzdsIYaFoe4F3yUuCDs/YARP3T9wLJfeoVIKqBF/PjFsJAw2EWQAOH7mQKwV4H3V2xcOEPrMIcPG/Wubs2l9CiA0r+z6D7nvYcFtI6nIan/QvxeV6BFWHuY0oXw21Fii3lwTgfhAffsCRlzok4E+7VGqRQMEYu6dMtIUftj70PJO9v8wh7KGzQ7IqNCb1eek2t8fDH+LPMA3Mbm/65VRKnMS1umIez23UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhnxT6IK2GemQsKV3B2D6vviukv8DCJhDFY+sf5pThk=;
 b=a7JKMXCwBXdVb+WYQEh1BpdqTs5HWPF9u7ygXJ/9yPMGP9kGS5AZ63IxrBOQ1ctKi9vNLOFVjGWvZTDwjAonA6LrT+E6iGJHDmHRItwkLUhvJKtAgTzlpGhch16e23ru3MdqMYUbZK6XodS2/CYqlAAOQMCUcjF9FoDQ0hbNqBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7024.eurprd04.prod.outlook.com (2603:10a6:800:124::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 08:47:28 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 08:47:28 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property "fsl,wp-controller"
Date:   Fri,  5 May 2023 16:49:54 +0800
Message-Id: <20230505084955.238940-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505084955.238940-1-haibo.chen@nxp.com>
References: <20230505084955.238940-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa46607-6741-4a89-1db9-08db4d455b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI8O0t1oPcnEJRchJKTCf5kw/e6jYDmo0s/UOKTDZYPamVgG8lS2r9xVqYtKeXOFYL6KsrDQAcp5+yVUlLp7v6MvYiJGu2ORZgxNl7wRZxV4ahOl/Zr9whEn+emXFgEjP4WxvWLH5BYBC7eJ5WqsOCJhCqxgq+dYfprnYQKaCIt1rVHyebvJfn2fiYushaHbZbkIsHYftj0Nd7m1wt7HvZUmlEyntAOTuLblAqNihRTKudLGHYiBKnCcSrg6JQRlnIiJH7VPYR7eZcLtgpAULi5PAHuZiOd6urdQn0b4spGApG585XKTqHBDBs2ECdFcQUjVE18v5PNtTeBc6/6yIPn7fXBe8S62+hwXv9Ip6nXRkJHJ4WdO4EabLaaUa45FZY6+ansFu2AI1vbkuGoks6r1s/OAcB/7ZoCzNlR8dKu/9MHeisvurDBT3TNqOgEF64b+2ZQtGRpAn7nhwIl9nr8TQXbUGFHPIuXJUIQ6lSK6fexZcDHhpivn8FfinEf5kI8ll+z3I7JMEXWpOklNi9bfe7DH+u5S0zpb5gPsDIFhnprXLSsOe8Yg34orB9Lk9qwEpdp6FDOqTHPUMmTq9gqHRwgAsee3o6HPqxAORefahYAyG+Ivgv0SDiI4+P5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(86362001)(36756003)(6666004)(52116002)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(41300700001)(7416002)(5660300002)(8676002)(8936002)(4744005)(2906002)(38350700002)(38100700002)(186003)(2616005)(6506007)(9686003)(1076003)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbsnhp3v4NL4g1jr0LYadinaIILJ7prf22TddkzVhlzGW2c03TKh13lg3UQf?=
 =?us-ascii?Q?20AK/8p5+dHiPkpeOTOIVXH9gsxcDS3NvPpZcCgb6uA3y1m1PcRNYi+IW7tQ?=
 =?us-ascii?Q?jHiBJBjF6EAP7X6ybdgwrMpz7cGOGmH2iDON2SMR1ZravGxR9z/Kh0Isb6hF?=
 =?us-ascii?Q?q61QAGNHypOMh0SOQ1Vfs4Z/wQ+4dIV1lgUBH5ed3aFG1V7ZcDyLN1vNVDnn?=
 =?us-ascii?Q?pfWYy2dB+nDT3AWE7v2qD711SH20JRGFE9v8thcubPOmzN2DggqS3XtWpn9U?=
 =?us-ascii?Q?c9ZwUZ0Nz7Of95x7PE9WBHfcTKpUwDRW8KQjWiTFX8lBI5qrG/MNTIC4Io31?=
 =?us-ascii?Q?aGOzw5Y6Pv3rGaYhUsUg0wI6U2qjnvwrcl5L9SqxsXZjzkBW/2fgs70o0jyr?=
 =?us-ascii?Q?bEpQHvjjx2C5VcTVa49r9UU0lTZRrRWpXFMyWEPBqXJVxH9uznhJBb3SbpoK?=
 =?us-ascii?Q?TTA3w812QmhFJAAjNF6ivvXVAUcX/fS+5UIqM+IY95cYpeWt26ltpLE1FptH?=
 =?us-ascii?Q?iRrJIV15A6Cr0NVBb7lYinnINikdZR0P1p2kKLJI0idN9DbM2efaaK8+Useu?=
 =?us-ascii?Q?Qvvc8H2Z0SHblBAUvSA9jkLP6EkTJaPaSt5NuhwfW3IcpiHLnvYRwP3g5LZR?=
 =?us-ascii?Q?iGzIsOGql+fF0ZB5iNORvU+NSirfQi2pl48qJxGW24FC2HAcXbMMY36uF1TC?=
 =?us-ascii?Q?fjW0K6N5yT0d5LbYEN0sY86yn7Hz5EnyL/PpT5o7Vy7RFd2NVIbd8xjndbSO?=
 =?us-ascii?Q?YdmXQ/am2e3fNQ7KWXvuPyCOPSonyccqYYPSVXTaQnKhj2ak2gCAEXEBfE5d?=
 =?us-ascii?Q?Vb+uAmgmCycOr/sWKfvIPNNw41d+xZlSXVWS66eSjs6g0dYMZVhCN4YMmIDr?=
 =?us-ascii?Q?cKaiKashLRcBMSaZvoiYzA+si3d5q86+HrorI5bKXkWV+uTvZPBBZvj9+Wsu?=
 =?us-ascii?Q?FhTRugVeG/H747Hw1XV8lnyMTQkuceuDyvKMNipvbw6C+SJw8F8BnwWFn0wl?=
 =?us-ascii?Q?A+b2WB8OAscWGOKgypP0OV/2w3eFKaVgwMnmjprZrctnuX9X/aQyBrbh0T7O?=
 =?us-ascii?Q?cN3inzfabxM5Zg/A8zpIDTPrB1ObhyaMVb/rFlF8SzQkoHKpM04IEyKdPGVY?=
 =?us-ascii?Q?bT/XZw0/5EjM+x/kkzjiYCurIRM7x4SN1aX36AGKqRg51gn+HQwMPE6LPpWG?=
 =?us-ascii?Q?Ltz7cuhKTDHMAqAHwmR9mXBBHrjAmlv0DxgvAWXvjJ1KhkohH6kHn6AJ78TR?=
 =?us-ascii?Q?Muj8Mf+cSSsuTs63Vekufxrb/Nyg1ypXp+wTTy+WqkyxB1uOVZhJww6gtVDN?=
 =?us-ascii?Q?HPehLZLv0Q7klxis19XMQkUmRwYw4l3sebdUgVbHFsOdrIKAC97YMpbcy8sK?=
 =?us-ascii?Q?HAt5ESx7N2mpYOJqZvFOj1HHzIuxL9HoTlKCBSUrEfA9PPg8ilV8MVIVlszw?=
 =?us-ascii?Q?f18NF75Z6FYXnVfOzwCLSwZIAWKC64QGSZaKBE0gNvwaTbLETApGM3l14JfE?=
 =?us-ascii?Q?pVYEZ/z588V41pz5ixxsFa0DZFzhloKm20m3uDL4Ff/EymrNEnDbaGwN7EyU?=
 =?us-ascii?Q?Ql7eozdsVXEtBPTk9NrkWDimU8qp0qGZ+iCGoz1u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa46607-6741-4a89-1db9-08db4d455b64
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:47:28.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9WxF5AG9Js/wDrmOyaqurR3gLVRb8XU/emTF4L+z+xIDwp92NodBmXn/pLYyiw7r8CuF+Mtpzq7oO1Hszozbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7024
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Driver do not use this property, so remove it here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index fbfd822b9270..831eadecc7e4 100644
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
-- 
2.34.1

