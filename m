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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81657C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2516120DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iBSHkwCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgKZLQf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:35 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:65422
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388885AbgKZLQe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbhMA3onC/k/HpLUOpqCXJ0XJIOyfEooZqMxkgYppujG0Gt25ddo0ADzxr7CiRKlMarc9smGmFq/DhWhy0U2+2PYFq2QgpyiKr8QsT4sG+CjYnuxRg5Maij9crqyYPz2rOVC27WKitQoxozSMeHQCG5Y2AWCCe4uBb5pz4jhqryUVXT2Hcznhw4eil6ChGeTdt99moeKd9M2hHBCGG7aM0MbjYif0J2+ECO8ZkTYevF3gkLoSU1iNFjks2QE7rdWirIyMMJLjEdXgx8ocU/753qEXOOeoMgEKUPmFac8MorZZcwrmJ8iltsxRZ1xdhAySEJfFlw6VkQOkg6Z1tjKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW5/y3tlproinv/TNrcbKgVDYp8sbYgWBwIuBvZTZuc=;
 b=nN2Tlc7PEnr2d+SG2aFFUZ1UyAixO21OZs3Ch6ayyvytJQeZ2FpcB8Wh8T4Ptf8FHhL7hD7AgHgKDEHbvzSIC5qV4CbBbAVS0vBMCzkuI+NeZyu3wKW+Nnd2ycuKK16VEb/Jh+1yXHawVv3jT5amAeP0Dg15dmN6Ey7S1hv0wc/DtgmeuQPt1HAQlczWaA8Tzx4Hx8YvVIkyW1ChhLIo4q0FKJUS8QQ+qM7ysSAbJyL7OnQhpYPpn+uDMCRMOcKo3dUALmjh6RwIc+kCM6XnZ2XOpHgBChe6b6d8wVw2BAiiSbZGjoDVS8pR0wBSJLJZ/0JEgJQzOOVWETF+zgzz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW5/y3tlproinv/TNrcbKgVDYp8sbYgWBwIuBvZTZuc=;
 b=iBSHkwCfNB6yKT4fpdr3m8HByfpG5vvmnfwVEg+KWg4XR+IsvhrqEbqhKgZix1H1DO3c6Aw/cJk19alqd3Ck6U6VWpldPZtHBP8EOIgnM7T/MOHvbG6JLuN4yWKWzYgh6jGbtAcadrHM3LdXSAbghPHy12i1O8SqYW+LrEJ7XCo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:31 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:31 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 05/18] arm64: dts: imx8qxp: move scu pd node before scu clock node
Date:   Thu, 26 Nov 2020 18:58:47 +0800
Message-Id: <20201126105900.26658-6-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca1ac882-68fe-40b3-a5ba-08d891fcba08
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB52060F11F66ACC6CD61D8FE480F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhYlWgui+1vo8yH6C9YDj0wDFoH7pC4h4+g7CszRAm6xCw8n0JH3LcIZS94q7/Jrm/FMtW6p8o84S0scs0EMEN8clNnrHJu201VVPjlulVavdkwiLzZXX2fEn+DuN9d1JKIjDNanZwN2cS7Whp+kbODXUEVNl1JlGrklStXwDnAXm5WGr0/fSjnZG6ZBwVnu0iE2+huzqZSSwHYUCaOmZXTrVW+fxJn208Dp6/I/bobaZ29D12mEHN5a6zyzByHiqst+fvz624GijvbKDAD8Rkb2Ts7fGVv5XWAG4WUKb7yf4KsruFPxAJtVhr1mXWLxQJq0poOzHp1M2yRYyuQyMiWTKck+mNmdrhD/oG52roffT0hPYuJNvCJ/utcAwexf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EpwsXuewwbbl3uPk325/0NMDslOr1VrACFlxntxjo/6ec50DPbcTMBknNuqvWF4YIyLkuBLVYxpnSojhdX3hHxtvwnMkUX/VRNyK1QoNYiv6Eq/v6ipfePWZ0EWv7gymonxBgMQPSTrL7HrjVgfm/uK6OaFPTk8Mw5MuMK0JqHnqYEK57q8cdEkYp618NghWwjbo53scdteIdvGUsOwAhC5V0/AapZ8CYT1o/65+hRiywGWa0ED1csogzi3y2TasoXGKDy+d1QRJedd2J3p/Onw25hWsPlQBDaUllslzYaZnk6T5aIJ9ZOoilhfheb1pFfbNsQLW/JwC1TysirjZia/5+rqqAnsNBMnThcIGg7zhkDlhBJlQGDBxHlrHjEXdybU1Lb/UR+bjb4A8Y24uuRgmDKkieNJmh/S8U1rEQiWWdfnaELDcR0Mo7Z0YIQgL5nsMP94eBXZfoGa3p+Jd2dWvaSFoeHL2MVzINj/jbVzW1eiD5gtRIQyUC5nv5QKFqts/5EBxAzB7wKmxyILePRo35halLnVW/DHlKixbzE6lTmVP8yfR1uJyccLSP0WQDs/2s6I8N34aLdX6NKWOgN639ylQpwwbAu+BZBSe9zC1TkMp7XMaQTWd0685wCXgggiw1yL6EaqOQfLplKQkk3tIj0+Hrg61TYWA+r1eclYMd+jxyYFCmuAqK54EhljORV0MqZElRRxCMfIJNFNhaJv90hAyB+hpqESJJFoUPUyXenbEv/hk4Vb755xqgIJVTEyW5nNMX43lBMHG/DD22DbWIMUdPsU7zEuvZ1P9IluaN4AcgLSHigzY+YD2anQAeDeS6yxxQEm9uHuo4lOOjXdToa5uOkhpN8A4zbnxLWs4en0pQNu8n8Ahf3QEHLCXTMOfcPIveuRwPw77PzzwaA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1ac882-68fe-40b3-a5ba-08d891fcba08
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:31.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iUkyGVSJfg7Nc4d2RBY8YzUjDgRdQmU087BQ89/lGGvrn4vNwWPrbUBC/KFIi9OgNe7/0RwR5jLJ7uvIwvWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SCU clock depends on SCU Power domain. Moving scu pd node before
scu clock can save a hundred of defer probes of all system devices
which depends on power domain and clocks.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v2: new patch
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 56da25b12950..f4a2a76ee894 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -158,6 +158,11 @@
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
+		pd: imx8qx-pd {
+			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+			#power-domain-cells = <1>;
+		};
+
 		clk: clock-controller {
 			compatible = "fsl,imx8qxp-clk";
 			#clock-cells = <1>;
@@ -175,11 +180,6 @@
 			#size-cells = <1>;
 		};
 
-		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
-			#power-domain-cells = <1>;
-		};
-
 		scu_key: scu-key {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
-- 
2.23.0

