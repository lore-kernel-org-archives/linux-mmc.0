Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95620C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D5A238E2
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbhAUDxv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:53:51 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:38471
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730981AbhAUDWP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 22:22:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUtTt6sJksbhdpBkhBxtlRv/Q8f2U01yh5T6riyhEqFGoYKarh3DN7f8QIGBZ9LKGDUkiW/CCrfEXAd438qSV1KZM+XsLSR8yNsjRoNh14c44VnUXHcwz0nXMaZLIIToAqMc53uGuMACuSj6M1gVa6Fam+ViFmpSx3soH2/QFt91jqLUCCv8SLtwNzMZHeKyi8m5lfLQLpy7I01RsfoEqhbXcA2zFfDhSkz2HvPhzBaODDPUa0XO4t+TLrQTCZwH0zetlXelP0RhKnmttYpiX4O1sO4RJGD3RxQoln+RDHy8PyCtpbxo+KGUm2ozEsBQy40Zicuuo/T5hHR3UiDrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9eSdbBa/yJO+BxygacUBwnJfLmFQnCUiiZQo3oC7g=;
 b=AtAiBxrf1159DRRZTo6Bp3pCa80owiuNJnSm9ehRK9FhAsaH4WskJiw9WOhJMB9IMF7O59U1lyF+Sa16uWXNcrk6YSSrbdkcfwO4pndHq4+JYL38WUGwYxk3pRfHkPGu6nqH4aU12EZl2YvmpJWXHQStNqdsWq3dtxy4GBp7MnCdS2DaguNuLoLGHxNkZNJrQLFuQEFEX1RfSIR+gU+dKFE+DisZ+la5gC4EqVhkGXISkvYD9xbQEUZcXmgruOKqYpjL5i6IVEMmWCeCNRmw1LVI9joIBJvwvIVYSHQD766AfzTJn8ZcQelX95ftKkPXoZC/gAh7mp/qrTETTfDtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9eSdbBa/yJO+BxygacUBwnJfLmFQnCUiiZQo3oC7g=;
 b=TZdI2voJ+jeaiijAWdRNQaVs4E47TqXhcGRZJgMYoCAfcF8dHETnukr7WiaPshjGsL2H1JuAUKm62ztIWQBdepwvK1s4CiynySP1spVIOebhJIB+ZtnUIcsjAWg1fjWM5JbK1CIqOFSHfEGZJkANdw8qs1a85X+xOT/Xit21Sv4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 03:20:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Thu, 21 Jan 2021
 03:20:24 +0000
From:   peng.fan@nxp.com
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        adrian.hunter@intel.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
Date:   Thu, 21 Jan 2021 11:09:51 +0800
Message-Id: <1611198593-16287-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 03:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99b753d4-1ca6-4442-730b-08d8bdbb7e04
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68585AD7D42A995990162B6788A10@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/h5pdbV8h1LSTx5gM/HaaWObk70MZ5d/w1Ct86K1ZSRGviBfTXE/zPWKxnvwxQnXnCxAh/gz179xlwIK/bK2l+8k8OZD4e/o3F/ay0r4qJzDeJAwdyGv4z2PPbPsyEntL30OPU3pxV8JhFEGtBFG4AdFpfcMK1Ul20NcweMX+k+nM3j0pM1FHwFVkG5WQ7vBXk1EaU/lMx97TDI1iaZQGnmk107yNOhaxXijDfwv1doEZ1veD8WUvpGN4y2lH6Y0twe7a1DUDR+fE24SvUBYTLGrlcNE9HRyhIC4UJK1pxcf0lIHU5O52qD1GoM1Do7t1NRjxc6f6UfAvtYWnGwvub5RyuIlixUK3SR++kBXWw+hKv7ShPbWX7/ZrX83zjF42J28hSfyYxbu8mbl6m0rCx7a/gcNkgd67yGg8I2buG0+7D5E5fLPr62uuStEmBV3VyrKQw8trSThEZWfce40A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(4744005)(36756003)(6486002)(8936002)(186003)(16526019)(6666004)(66476007)(7416002)(316002)(6512007)(8676002)(5660300002)(66556008)(52116002)(83380400001)(478600001)(66946007)(2906002)(4326008)(6506007)(26005)(956004)(9686003)(2616005)(69590400011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Rff042teFIPJ3ml8XViOfAU+Lxc6biDFnmtf66tLlBujYmTQTjwZuC3UDv7F?=
 =?us-ascii?Q?rj+e7Q0n0MDtDDthDnEk0Xqsi2GtozHVxV6nGtkiP3TjmRon6Jb9nVHSmbG3?=
 =?us-ascii?Q?Od+41+V82kqPDojr4XmtbUMIuNbAo/TxD+j/wxfkGYZmTk05qjy/Dfv5Yd+s?=
 =?us-ascii?Q?bHzYn/LkMEllJBh+WaSoOGlAzLtN/47b+VSs1Gbfso/37oTeI5XTa7EHVc3T?=
 =?us-ascii?Q?IIivBrtCfpFZN/WaygJatQRKnTIaH2tI2BVozeFizWr9FbviuNAhTSnd/vUK?=
 =?us-ascii?Q?G5bw5XyfceNCuSxDFzvXuAw5lBqNRfmR9tMDdV3jfP9doBFaJILLUGDfUC2f?=
 =?us-ascii?Q?x2QvfWCERq8gurklMZN0hJzmbaA7zquWY+PSeKPLN6GrcWVYQj5bibz3CTFt?=
 =?us-ascii?Q?OJt1KHOxYhHopUAgFY1em66se8ff5nsFZ2YccAzEehdo8TW42cYGm+XFgd4V?=
 =?us-ascii?Q?+uc19bwlqJbT/5bF6NNR49zCLfANCVimluPjH9qsz/lsOQ3NdBvddgUhFvZ8?=
 =?us-ascii?Q?PkIv+gz6nWgccVC4RYRCZxZAcYO7J2fOTmaQtKq43XOQ3oGguxNX0W794RNo?=
 =?us-ascii?Q?T6ooU/MT4hY2MoDjDISiSdJ2ZcBIDjg0V1L1O9AFfQEWS0nH6g+2M9w1gydR?=
 =?us-ascii?Q?nmQnTnrQdAbox90uZWZj1DOh/fu4USXbrXi8QI4AO/k1EB4x83TFlVD9arrd?=
 =?us-ascii?Q?qw/G/1HOxGq+q+KESTqfbbDbmzUj++m6t+IMj6njVdxzNa9sM7aMrcRUxZ+d?=
 =?us-ascii?Q?GHL1W0kJgMR386TYb/NjoIpR09FQ6OOybRbf8HwX/HXbyY5aKDPix38K9BSm?=
 =?us-ascii?Q?+Gc/TOwZy4R/bhvEAiySX8Bsaox0Qaq0WWf2jdKjJb+bG00qDISCO3Tu6ZM/?=
 =?us-ascii?Q?3+rxWq7LgcalvTXsWfaCIjx2NkjUsFZsddMJoj9gA9oVSIw8y33JgdSLto33?=
 =?us-ascii?Q?+4mU2J7eiBSBX2jjaHAk/40s+b9KPRT2ga39dTHEuBg0JjHBcYIy26vdGuwI?=
 =?us-ascii?Q?8EfX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b753d4-1ca6-4442-730b-08d8bdbb7e04
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 03:20:24.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ0hvrWQLeP46sBm9L4cW+PJF7dkcCKnwh3DTgTihQ0R/aW1VvVxNuUGhx4ZRDpDuaPgGSIV1hYvUNuh5SEUzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
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
index f91e97cd7d4e..c42a3880abf0 100644
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
   pinctrl-0:
     minItems: 1
     maxItems: 2
-- 
2.28.0

