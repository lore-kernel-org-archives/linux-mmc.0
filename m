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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63393C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2101F238EB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 04:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbhAUDxt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:53:49 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:28976
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730293AbhAUDWI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 22:22:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff3lnm6n2rD2SE5BBLJvMsixHx1TTCyyq6k4GQVuYhDoBhvwde3kL8IKT9iX5nM7e2nWu5RQuRQEdVygFtLVd7dzufLbJeRxZyjuwIBpQNbqMQ8fZ87TmQLD2nMWV9TDHzSzFRUrymo2dvE3qGF5q3JznPZc82ZD0c5sfDB1Yk+guEbVwrmD40IGaff6FmmRZDmwvNEbV0May8Rt71U2LgE2w/auQB5a3tSf34o9mbC13eKW6ZQNnY5WMN2CjmivZ767lqtz1HTGA5ANc2qJFOf6gCP3Kq5KuJYRQEBxo3JVFb8xPVhXhP3dCyfAAmef28vjPv3VgbELU18+KEgicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0fiW4kqg+fXBAbX9P1q/wW5nakAbxyUMDhKkRcuVU=;
 b=ZXK1fwDXc/EONjQAEo7E+3Sqgldyf+qK6cjeIsi5zfORrVMAImKZGAaLAy+LrmV64vR6lthgp8H+cuAcZaByZhmU4TdKyPNjtu7+qZ6hzqF+7u0ICQxdxZgXmIDqLBI7VAT7hkWCIUhJHjaQuCvdbHn3TMiTRaYILEb+ugHy4Bye5gNZS9sKGfQjx2DzSFPRjWABiX7IanvPRoCt6A4cx6Tm9PzZh8zquL+g4QlEnB6bjt9VsTzUWX5a8C+06gY8XQIAQJ63NtEXBkw3JC7USRKJz3L7lDKUIxOPscqkAivqvT/fAdbD2k2tcIUXsxf+4gwCo3uj1MiuHGxSSVOsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0fiW4kqg+fXBAbX9P1q/wW5nakAbxyUMDhKkRcuVU=;
 b=n/dcQ81cOfhHwqjcmoFHGcYAi+PcWBWsWyFpkSHXx2VTTaMGQBYBRI+zyEtnn8bv1RXowSMgrYN+j469dqk2dpj011pWgUczHqyypHz1H1EuJaO1XRUE128uHSmzv/ickmCczS+w0CG+AN2Z71Dt2fzN7RVVMVEdOFB3AEzk5p0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 03:20:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Thu, 21 Jan 2021
 03:20:20 +0000
From:   peng.fan@nxp.com
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        adrian.hunter@intel.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
Date:   Thu, 21 Jan 2021 11:09:50 +0800
Message-Id: <1611198593-16287-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 03:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75b05bd5-abc3-4b1c-c605-08d8bdbb7b13
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858CDEA31D45519D9BBD60D88A10@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48M7GwN7dPLZOH97CKLcL/ajZ2HMtZYyaTXJW444PBuLXshic3SxE4+XxWzJOff9BFhmMUSNaAegGsWnaXXL+YV2WoOKTg+goXYHP6joMdUQW81X9tR4WKAMfeiQuMBiDZVjuU6gE+qAtIqAJrS6AL9zePlgCQtUxyl+2OiXcX+uNOpL5kuO7HxPJzTgl0EglyitovCxiix6LlAzNBkNTKfLhaq7wNTlQmKgBTkUqTY5H0YjJvq9AoQ360tAsDgYNCJRWK6zdlUDb89DEbXiK/SYNcr229HmR/wMb4LpX6tWJDhhgBCQnAeWbHCLRRkJTJH8z1LiNBJALsPH+5pCBZsK9jhYb/0UKyQy8IKFdeVowzU/cOCkjlpDUY8fCXRSdnjVkLQzyefGOEkFHTnMYJXcACVFAnfbYbxf5G6CNoxwcWvFPL/M154HYevG40BEG6T07tH6iueVWB/9qQaT2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(4744005)(36756003)(6486002)(8936002)(186003)(16526019)(6666004)(66476007)(7416002)(316002)(6512007)(8676002)(5660300002)(66556008)(52116002)(478600001)(66946007)(2906002)(4326008)(6506007)(26005)(956004)(9686003)(2616005)(69590400011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BKDbHHcpaEdoPDbxHEuWqLIYg3fwF52ahTHOYNyznX+tm96SSvFMs3Rg8cnP?=
 =?us-ascii?Q?6V9SbtqFFj1xwac+mGwbp5JRBZY7mRXurrYKms0lId337ZYTWqmX9Z/nrw+v?=
 =?us-ascii?Q?LVRp0AYblrCjq+hJwjfh/A5YjNSVN7MlD/ZDWUrLsy5PQL6X/EPgZiLe4T/L?=
 =?us-ascii?Q?RtVzwi3e/Otw/aQXB2alPjfR1AO6q8TPuCxqZQyi7IsywM4hgHT+VUMlAg9g?=
 =?us-ascii?Q?m2xdvvDj5T5TjOd65g8FYq5P6Fb4o3xz4wKs5Xo7NqRZg4p7Imrd4pR/crBx?=
 =?us-ascii?Q?CwIRjN8/duIn+oGfjIWmE7E95rl3cQhXNa9BE7Tw4omv1IoPJeFNUu7bzm1n?=
 =?us-ascii?Q?UQVKTl3iqb7utt5I9G1Wk4TXk63bG7Zcs/Q1qbzpgqLcePc89CSsG74JbLH1?=
 =?us-ascii?Q?dSONsVLnTfKCMGu7T9LkEyTE1p5QXAEZxyfWc12A2/Ew0vQtM+x1ccJ3+8Fd?=
 =?us-ascii?Q?PdetcV+a2vc049riHHirxhG4lYVsHJ/Y4bW09sKk669Hu183siSx1jHIcPEr?=
 =?us-ascii?Q?S0pBpQKCoxvrFVpurlPZ/L9YG1WVtyeSQk3J5+yeKrRfmygUfGfm5XEvLtuC?=
 =?us-ascii?Q?MABCwcxAnu4iPznYfEkFs90C4929ZjIotMlAOixrq4dK21g1DRDEQL+7qXMG?=
 =?us-ascii?Q?C8RAXCP25vQ7IEMsd3U2u1SpJdOqef0MMKTfH3CqROJsgdkargkdALga+TlF?=
 =?us-ascii?Q?HcVDajP4j3fOsrTCo2FMF5J95nHHntAxX54RRaAS35K7S3pOhRmsA7nCye6d?=
 =?us-ascii?Q?Uo4SveiE5ZfZDzFbzyQ6M+JSB52AEsF17hwZVZa4TONXXySQR/FrLSC9mZDM?=
 =?us-ascii?Q?YfFm1hvMjFAut9Jo9A1kmtMaFYxEQemNb4Vso/dFMMLjra0sPVXor1/B1sJ+?=
 =?us-ascii?Q?sPHZoOEpYLDdExxNBF1DnIR+LDNaZFdiKcZ7RWmIgIHbV4c9+ioCq7138rTf?=
 =?us-ascii?Q?TQrG1uSpqNz5Jt4QhLhKkdAIvHYhFEkfxq2O4AkQcaFCwhohyjoC0/Wp69+I?=
 =?us-ascii?Q?TDEy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b05bd5-abc3-4b1c-c605-08d8bdbb7b13
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 03:20:20.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqVbUQtrhPv4mln0qjtpR0mOvinrE3KT0K8rJKMkDUXFEOUOfw4DvZwwBo/3blbnArDbgrx6nPPsdKy7C6hFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add pinctrl bindings for fsl-imx-esdhc yaml

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 802c9df23752..f91e97cd7d4e 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -103,6 +103,31 @@ properties:
       Only eMMC HS400 mode need to take care of this property.
     default: 0
 
+  pinctrl-0:
+    minItems: 1
+    maxItems: 2
+
+  pinctrl-1:
+    minItems: 1
+    maxItems: 2
+
+  pinctrl-2:
+    minItems: 1
+    maxItems: 2
+
+  pinctrl-3:
+    minItems: 1
+    maxItems: 2
+
+  pinctrl-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      - const: default
+      - const: state_100mhz
+      - const: state_200mhz
+      - const: sleep
+
 required:
   - compatible
   - reg
-- 
2.28.0

