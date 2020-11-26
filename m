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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3BC63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BC221D7E
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n6kv38KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbgKZLQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:58 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:12768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388928AbgKZLQ5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdLB65Oqk9pi46W1wO+MroV3/o7IlwKn7I0qs7U0zHj8JlgQpmZuCpLOl5g8upiPCQ46S2klNPJ9dV3HFXnIcXAX2LP6KyigwZacSC+Y9XGrYXhUZtUTCK8yUYC/yI0r7N+aONpdQkbhGZ8aqNZhjg92kHJaV1tuMqp6VC7T46OM7Zo1gjA7vrhrmRcTWXZPWHTHDn/B18iCuEHkSi2gIVtIT63pDPtlQcNpUVGtEMBWroqB6ggpKpZNreK1wQ4uTSqPk+xeBEjdOsM0hJ87CEQ3+AZ5yprKFUygIxM7J4A0/U/vDEX+ATz7Svt/T63y6fiORtTxJDWx8ukETDdtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONx5wn6x0u8tpu4gVV4d5pw+v84cjQwPsCFOz89Ozgw=;
 b=Bez5C9jgVFKIWDNoXyzoudIDlLbNqwSk5XdQDrVDMy5zECBsvmd0d4lcAlnHw98BPI/tH0NanajPqklOjJhPZaVgiCBASEosV7mI1yb5vZm4iYJYZKQ7txCd66BPTuD01NqmSqTM4l/csRrudI3/8zHBe8/98vGPfknSxJCYf02Bm/bNGUX814aw8E1cvgA/G22BqLol/XvtBiCKthdmJ7be/uxUquchUlYBYQiSLHQADWNybnBN+K1EpVhtB46Woj2XYr/66a51iAsLGIQiali+hm5gZgO35M56tEpxKFKfL9iJtjlrfrY5I5+QAZIZYzbQJ6q6A8Y+pbxpBXqQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONx5wn6x0u8tpu4gVV4d5pw+v84cjQwPsCFOz89Ozgw=;
 b=n6kv38KNqylwLQ6D7GPTF+urCdot2aF70x4GPAbWx2EKrpCJgxfc/gGbAWbriAQ87P3HaC8G8r9jwxnuyGntcGQ6cDyK88AUGujmhTGIo7LVGvuAQtiCHEYnDxjPZyQkKjHKssA4K3kpInmVS1hrupm0vX33Xn6VWmIE3dyJuhI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:53 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:53 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 12/18] arm64: dts: imx8qm: add lsio ss support
Date:   Thu, 26 Nov 2020 18:58:54 +0800
Message-Id: <20201126105900.26658-13-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3239f9d6-c9db-43dc-bf73-08d891fcc707
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB68692B30B2E3D8FDA248042C80F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVns91qFKOjxBANegcbvF6M2N2LPlKXS4oqFHZaoFT+Akh6LZQuuAmkYMSlMFz6/ypzqOlENfyErBcUrpIK0yi3n+KDPnrQ6We6ga5tMAOoljkHGcoHxDoC6F4h502rrJ15r5ELmbu4+eFufXtHyXv8Tvgrj4TzcF9bj9vQX7JKCcIvijIznmTgC5r1ODOGbYxksrnGAFsXbEc5V+oQZC3VjArEynIYG1nRRK8IB6XXmeBcO5sb5dsW7SUygJdp0kHsiglzqRgGUOyOxkwauypuhs1fCuSl8LFrk06Egf9DTg9hdxwk/uY2TqoT/D/LdqhP7uBLSllJGmk09J6VNMEVA0ViadzfBtl2nZ57LBNU8oXft2RXI/if2Q+ln/Q+g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(83380400001)(186003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(54906003)(52116002)(5660300002)(26005)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hoLNleAeHBonQifEJ5jqRvXGiw4sAD7gFOXqlZDBj1408PejgJdeFfr0K1XiPgOLLIZHTLTzjPdJBiX4XfwnhgGpv6T7Esvjrh3zND+GAT9Ze1ZbioGaIWq8D0XaCJ2OMJW0Da4OeAehpGmibEK9gjMKEI8H7J93el7dF4u3ipWWV+lq8K1KhxFi+5vS1QdIlyQcj5inHfELePyoMpOMVz3c77s/oDjketLVNvrs5s6VgGSvfkzSzvFvjTGaS+mi8sPTbXqe0RAdrtg2dRNxIDCo9a8ChbGHpMpVh0wgwu6/8gfMMRZPXTPZk/KmCLbA+2PUs1FWHN3MNFseSWEUB6PMLKG9ELeZpNFKb2Q6bll9wnyP4iOPAuKVRc/VAAVw478exjHqWY1AoYl5qeAByqrpffYtVqGuc2XHxGmm2IM6c2Eyq1cqP+u7AFpgAU6SUmKVaqRapVlp1oDwVU64O3ycsle8Qot7c6QwYMAwiSIyiFHHEQlS/qbkFO1e8uo6IRNS/87rxpTEcJzil0HIxivLpjJTDHGNicUAMeQcc0YJh+XGbz/4IQv9UyNnOopc754s6DV4tySEg1C5QJoBJgRFEFvg9GbrwPkM2IAERRdj8mHD08MuywKOHYNXL2Il+DjbMN7x5iHVgOFL4LAkFLM1cBXzq4asL3t6KcVGhR4tnjanA91YiKKEG1ahzh5amMHhdjQqsgH37yFE9ohRgUKxTV1zEEVfQ3T79QpooDz0u7SCEN2TIRlou3MLDJHlJLrAysFS/qpo+IwJIMYV0bZO9U3SrYWmXPQYim8VA9eLtNrdul1x81ZvM+C4Zl01qeYfr8QdR2vfkMqBmeYWB154okkuWSrL1JAQnjj/ec4AcKaFTLAN9sCrwG24x/70qdyDCq4SxaBiZxzGwIQ0bA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3239f9d6-c9db-43dc-bf73-08d891fcc707
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:53.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz4T8kUXx3bpc8TEQYAjL11263+lSqoCD/4oHgbGF+H6iLKIblvNQDlYFFSXVncV5N4SjJlMNpy4nzBVNWJt6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The LSIO SS of MX8QM is exactly the same as MX8QXP. So we can fully
reuse the exist LSIO SS dtsi. Add <soc>-ss-lsio.dtsi with compatible
string updated according to imx8-ss-lsio.dtsi.

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
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
new file mode 100644
index 000000000000..30896610c654
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019-2020 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&lsio_gpio0 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio1 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio2 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio3 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio4 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio5 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio6 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio7 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_mu0 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu1 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu2 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu3 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu4 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu13 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
-- 
2.23.0

