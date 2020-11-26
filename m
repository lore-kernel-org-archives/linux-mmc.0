Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62298C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E24920DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mq9l3jXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKZLQc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:32 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:39744
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388868AbgKZLQb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyHWyuh8K28k3p7KISnc3usDvEXmDwbCdx847CVYQW4383rJni8P9vVQ2m7VhXHLlcjl4J+8WtKrNfaaeOJNwoieDRU1gtQwivyJAOSoHiszydtbLROKbLWLPmXEZaY/oRR/nDwS3DYNhMhhY2XS1ujMVFTNxIT8Wf4/y1Lw8d1Ri9qoQkGXWeqBI8XAiYMihUBCKkZqU44eU1BcJmMDIpbQSO+BVmHiTThd49FnuOlIzRXoWLlUD1S6UtJsjfuH9R1DymiUrV+gwt6aj2nHeqeTOeZxBv4YY1cHZ5wd+DRt8zdwnPc6b4n1BNg9M2SGykFr6W8xHTj7Zq4AoKNzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFz2gKVOMCD+dEbYvX7tmCKFz2wdsXgTq7btW7cO4DQ=;
 b=nUr+0VthrP9sxnRnUpu5tQCKX6Bj0GHLVZrx5z/YDYp9Hw7GfdP5WWY52Ba8bWTXN6tzZPWAnH/yxXnzgJYZ6OlASv17I2qw79CmZ6KQZYgD7IGpIwvZB4Cvc4YvPTuvr2NRO/eNs6p1OYCpyCH7/FP+nBGJKtSm9n27gEtOKrOxsqx0PiUSw22L1pza+HzqEm8kSomFsZTcoOdyYlBDxz8Ub1Wzp3EM3qa5cIndfbj0YjZp2wE1VrF5iFHhAs/y2kA2MpubRVrkSv1Qgc5lkloWK/kM6yisVeh9kYsqhPf1UBdK2JTgZG+x+B6n60lRJkEwRZMvbBb+E9hGyXm/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFz2gKVOMCD+dEbYvX7tmCKFz2wdsXgTq7btW7cO4DQ=;
 b=mq9l3jXOESmTaM83wbv1aPWRTQnRchWia1UrNklBE6T0HJUIaRNc0OY1H/wWcqtyXArT1mJIJsYFvFwK5Su9PeYv4E4xXaNYF9kMNXJzEqvgU6f3csDHDHczMekyg3GzuG3xmP0NcCL/x2yL9Q7An3ix1J0aG1IazWoMo+MGAic=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:28 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:28 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH RESEND v4 04/18] arm64: dts: imx8qxp: add fallback compatible string for scu pd
Date:   Thu, 26 Nov 2020 18:58:46 +0800
Message-Id: <20201126105900.26658-5-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a38aabb-967a-400e-d8a1-08d891fcb7ef
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5206E4B78420A5B992A1052580F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9e3KIE9fhdjl6BW2hU6MaSOgLTSdv+4XzWy5YiGJYgQMjYLytTp2hhN/lDfJKDhPmmIDqzhdk8+XgVnCQjvXZH5ASBhc6TIiP2yfxq/udUzO+qr1k8TcFzWpk2eUJkfTW+ZwHDuzTRPiBuDQymsLzDjtXg1X2WNi6Uv/4okBIhJXzZQ4gTRNld3DVse0RSBa6KV9Wk7qYmNVdj8qH3GxmQYrji6ph941Kj9jEEy0aoeogAhugSO0Vel7jbtsZGtauMM2aUtYN2ke2YVFt+VMXu2g4Zbp2Yni6qV373qE9oaU9sUh28DSYf1jEVyVSsMD7bQtATozthV/vMoWMkXd1f3V6hrYunqSBM1eDHOmGoddveB2TavGOPZQkT4/VGc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(4744005)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hfw/bCBZK4cRTHFIPIR8PB/EZfYNOo2Eh87uqx+PmbNIA84OW+r8W3+kPeKtai73xillCM4Dj424AKb4j2RoDe/xlkmiPhImBtbANFrwViyhdQJbDunxoBZ0DLoKUwd+LYiNW9ekBduHn8/0abQzmnLr+oZTEg8vO8C0VBtlFYhvqMXGCjZQxBNgyPXSkDJ7mFXKaiWEiLfVsx/mlhPresvDuquv6dGK6hBXjd8dFXeRRLnmMdeoInvLb6SYWCPNVsnKswU0WmICAzG2134DheULpLw2q0b8j6NsZSaioCs1vMqV/J/Ezbmod7KJ2ivktyqGZeXYbOgESbY16Z9H2mRNQkrjcl5KR3GX3ys7y+2eBNtlUVqj2m/UMzaYHOnzWUJASKjGwRzKsdIND4c4RR4Ctxc2DytxbKxl1UMiN3JnnlsSSdEL4sHA3F6oKHhBummnIBuf0GlqIC9idxu6NJHfNdS/mf+7ewIMSLGV2JnUKVntV/XITfuhnTlzjfK31AtG8t0OR4uZggBosyNV3Hl0DqhRZj1kK931bKiGVni7hn4WEZdH4HRZX93R3rek/d5qtlB/3gcbG3m8vKmo6IXGhVEjyi6VbF8LteMIX2Isr4RoclgurHGmuGjrT7WKnXNa8/om/AMzEjqdEr99nN7ADY1R8onhazmdXL6oQMbcowfrAoSwKxMO0VYE7S3ZqA0lp/GuylnBoZ1XaXfReiJ4FbBfs5aALr8LGiWEKQFU04G/xwtMfW/ld/KfeUxaDptX6MP8tptT0/BzLvH4uLjXqm4CTzI0mPPFzW17wOq93dtb+6lR/rXAehmnaBPq5NLeT7ZegfvT84wekH5sKpFkrDCM3ERVDH6gEVjUTVgnKdFl3DzLG9lOdPQmRBjzcus7Xyve924PzmoD5M5iOg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a38aabb-967a-400e-d8a1-08d891fcb7ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:27.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGWG7ubyLKKVszxzUB1t0QVHdvxIjEANYDq+NsxW1hwBkYdtDx4Kz4QvBbsgTEwOUAr3WMsRcGBhwwaaWSZn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to binding doc, add the fallback compatible string for
scu pd.

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
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index e46faac1fe71..56da25b12950 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -176,7 +176,7 @@
 		};
 
 		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd";
+			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
 
-- 
2.23.0

