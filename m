Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E4EC64E75
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C024420DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHo1wufc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbgKZLRA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:17:00 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:12768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388936AbgKZLQ7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IafMVhInNoe2YRTulNdjQCY4hC89ti7R7Jsybq8lsbGYp4GmcIgru11EAkgk/5higYiSx/WcUR+hlTDBenQeOHS5C/vgeg+GHXYsIUP1qkhucem+VB8vPCpw+0X4AxIH+4yIHmofaZySWcqGX+B9V7qtcYqGnRiDZWcPi0By+QZLMxGygo0IW/Vr3CI1hbRBcgyMcO5yYFfmme47gG4MYCezj2MX5RzOAY9jbnqmztxXY2NFoYeq4Es0ae34JlF96a2a6Up4h7ElDyw+jfWqk2BxwLa/IgyGJ8GCTn/wreLO5sZTmWC60bdC5b8FjQI4KkoaUSM0U4iSWDXHfVfE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxX8Qw9CbePVxHtgOH8i2GgkUkfBvrOcRM8gNDngs/Q=;
 b=Vs/XBfOMhDkHUV3ztC+7drz8PvOxAp/RmRq3RaLXg5+GS8GCZ/LU8McYuQKHMSkn4XlWuZ6+6/ti2in/cEvC1N0d0wxV7zSfCIqTAqjMfA2gWZi2CE9SVmeggb9tx830IPSk1tpliNmx6JREBVRE829ERK6VKv4G22TXnYR/Z/+Dwy0bNgT1D3SAHXPnWAp/D2NgPEP8N6JA7m7K23Uf5ZkLBLRKxPMdhQRqYIMTj66LDKqrIGQFHqOxz/GAU7jYQPY/HJG+5/5xXrzheNNQAbmXuaYhVGAiBkouYdpq78K7YpgGtHQ+D6Zr/PUHE0IgFxq5wG18NdqEv7i/Q5i2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxX8Qw9CbePVxHtgOH8i2GgkUkfBvrOcRM8gNDngs/Q=;
 b=SHo1wufcB7bSQ4y8K+FGqB3L8wb0Q56pfadCsRoq/DMLQr/4TYDrZag3M9zCXen3OhLriCnQFEIwJChgRc5XqWv/lfrIPUsJR4UxtWbo0PASMLUS0wyBotWrO5RNLFbtuv5+Jania4lvv8xHQiGHxF4t7855luRtS+g4EVBwJSw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:56 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:56 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 13/18] arm64: dts: imx8qm: add conn ss support
Date:   Thu, 26 Nov 2020 18:58:55 +0800
Message-Id: <20201126105900.26658-14-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201126105900.26658-1-aisheng.dong@nxp.com>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0160.apcprd03.prod.outlook.com
 (2603:1096:4:c9::15) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dc94ddd-59b5-4dfa-8300-08d891fcc92d
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6869A7D008A18516FF9F487780F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTs9PyCXQyhObVousEQhC72fahkUCgIyPmVq/LR7+Wi1G+UrT3UI+r2JQA8n2VLfQ+BEYNiY2asyc1rxyP4rFSsfRYLsWGNNpN1TjqoM1XdHqWdkwc207ku5YLEST0MBx7K1OYVXo9xajclYoWHChP6wWVlyud/BOCbbjWLmYHQr0ZkHOIEsuRN+Z/WJewiAv6wbQqRh0q5z85BnK0u2zuN4mfIBDDdt5fH0Emw/7Vv/CT/dAMW009Tdvcoj9EAQJU5sPGTv+KbRcdBrom/fgG9vCthZPF7EO4b+rGsuAWayCBaiAWJBqaGXlHpJDoNp6hqyAx5bKTT/ANSCGbdW6ytJ2R2VP7vfXzBZWBdCpc1/uVqUCtHcoD0tYzrcnp1R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(83380400001)(186003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(54906003)(52116002)(5660300002)(26005)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HZ4wOlbumDBJOSW2w+w1FYaF26WBZJYNu3x2tx1DW4BXxJulMhmrkBY7A3DfzilR1HGazYVHaHpHDMM5us+KYn9RLgdDtWa57A360xy0+CV56hMx0SHVOLklinRG6M3vV0+WE+chZ/YVqP3Hr9FeFy7B9VU88V3qLgAyCj9xDTETsUy4tvMHoXteWhjg1lHkabYnvO1evundYiCOhZ9BNkhrcp8ySRMOCXzDQq17YMiEFrQhEQB9QoBQ1EjLpHzUb1Xv8O7n+JlcDYAv+++Go6dnkq9kVs1w3vx45Y0Z51JKuV7i37hY9RWTAhPJCwTagpl36vg6U4o98EDk40mpJOJsCTOBS4oYeRYVObWcIwIJ4ICJzzJ4r8MVWQ2s7mppqZF2rCVzhbVL0kANPC/rsSP16spuZulvHcc2WOBx5doHwwRpkC9Vv7cv0rXS04OsoQq+mJdc/s0H0N3449U+9iVLGpYORdiuZKja09bkaSSOynmR//JCX2YMebUS8YuEulDvGS3wIlnorK+2adQlr+kqtkFkS8xanBgjRvy5zG/RVptWQXUXlLDiKzI34ZkA88ufLwoCssUHe+8jSKgUgXNYMr/TqM4rOV1gV2AHDOZp9WiMj/opmNPkxYnfZobGmvwZ8bhnXAPteZXqNQYO0pmXcthDaV2p9id+hS7mCLf4MYdznrAvQOx9YjJhsfVQllwqseGdoy2NPtI8qDRKg36KGEYUa4a4iv3OtFG0X1D/5jRc2bI2ZbQ3ukN6rnUz1S3tYxK7aczkgPS20bohHCgJmr/OuP9+mKnTcby7iBLsy60GXnAaJhHTIm2aT+iA6aIt+WMda3oqu70KqhztJoS1OFMTdU0JVT5r+oaMbScgWtEIsA6YZ5Oi2mYuK16dTA5nWUuiTevB/2b/rhq+RQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc94ddd-59b5-4dfa-8300-08d891fcc92d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:56.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGa7IrR27vAUXweQTFuxP7Dps0NEt7DTsq2oG1ohwZj5Z40XaUaFWYgJFtVDzFpl6kyhuXxBhyd3HQ3320Dt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The CONN SS of MX8QM is mostly the same as MX8QXP except it has one more
USB HSIC module support. So we can fully reuse the exist CONN SS dtsi.
Add <soc>-ss-conn.dtsi with compatible string updated according to
imx8-ss-conn.dtsi.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * change to the new two cell scu clk binding
---
 .../boot/dts/freescale/imx8qm-ss-conn.dtsi    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
new file mode 100644
index 000000000000..dc47c5c80eae
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&fec1 {
+	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+};
+
+&fec2 {
+	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+};
+
+&usdhc1 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
-- 
2.23.0

