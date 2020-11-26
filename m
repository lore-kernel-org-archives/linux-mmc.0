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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F3C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B1621D46
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q2INHHwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbgKZLQ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:29 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:39744
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388830AbgKZLQ2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr/LdbU2RyHNGKi7pkBvG74PJHjaQPn7PO7K83osWvz2eiwEjfwJmc89y6kDgcZk+lLy7q840R3Nqn/xLAyY3i310vrzuLuPlz3LKl8mxeuIAEmApot+H+yoSFjb0rzcdD9G81Zf4EDwZB4UmFOcTJcf3bynz2Pr9mZ2du3FJeRylAE2Ee0OCHag3JRKQmHHoT1h66I1q7a1wULcF9QHdZP7BKYI1qmp/3mQqUYKrqsqvE2fQXd0ndzhj4ejWoPNcMkwsCzFeCM87FI1lWsG3+lD6DGwfA5yk49+47Hx9+g9gCIIRwfDGZy3HA7e8HdmRGd0dA9FAWewy4mCB2x/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrnqHKCjH7DZZhkXL1W/McT5VP8UG6FVTIHRT/oAlAc=;
 b=YVQbP1KJVvLIfjKp1jiGdAX6TGXqh0bOw1KkADPI2pT6Ft8TM7LeajsUepEATIBLEkQf3J2BFi8jKYeMBpbEWtVvT831QL9aBfT7dJy9lhuCE/E/29lrYEHabkTp3MRW4Mnaz5B78SQxuZFesl2sq+dsSvd0dyXHUXFHBW8E8OEy7PXBkO1u2EL6AaEvoovNxUQgwGWUV+rI/GXhmRQ6QS1FGXqDJBY/RmwfVlou7C8/+rA/veQgrffGbqB+OfXK36SbZ1IRNes9TV0vNTm0a7vYM4+NYCnO1ZgsHlh/B/MTXyZj90BmC2InI/X8WVJEFPiK8Qpul1SOluFWp2iQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrnqHKCjH7DZZhkXL1W/McT5VP8UG6FVTIHRT/oAlAc=;
 b=Q2INHHwVeAq+3olHEorlW25roEwrWVo/AgqnQEn+z/5+nUUBz1fatugANWuUEF+Rq8PjPRFWcokgx2qrr9JTLhZdzDxXqBCS5s8bAQCRPVPqmfKKGO2LW1LIWGFpPJco4FjS3IC0gWzrj0gsCFoCfj3CvX/9LNeHojWY0OVpEAY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5206.eurprd04.prod.outlook.com (2603:10a6:20b:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 11:16:24 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:24 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH RESEND v4 03/18] dt-bindings: mailbox: mu: add imx8qm support
Date:   Thu, 26 Nov 2020 18:58:45 +0800
Message-Id: <20201126105900.26658-4-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9410ab4f-51e4-4528-7c12-08d891fcb5d9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB52067E910FBAEA99D54E034380F90@AM6PR04MB5206.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZqHuJoky8Lshl001o5MsPAtz0joxLd3GN3VYX6mH0DUxX9LvdV0wjxvCcEvMKsf1j7pyvUmm69bJ7nKhG3tyDyCZd+YA7HduEGk1jMmk95t7hQ/o7jZUa16G9iI6cu4q48y142CBL8WCzQjKV/zwhEOm9Ruq5xHstYaxrhmLikF0o6rbBbereC2cgbYZzryMZN/H1B2ICwA1BxIGoFGfy2fQguIFkRtR1AB3IcgkmgSu2YoHjglhZwQNxeRKgHmPepgp83K+ZGrkI7FuIeUxZlWCrLGkbWMjWX3UTAYXJo30Wsy7gL+2nnCySh/qmLuF1fNPc+e6HDSVkeL+LPJ82Y1iJglweVNB8UTrwyKhHtkPfOFjl0iR7FrimaeA1TM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(6666004)(4326008)(8676002)(86362001)(6916009)(8936002)(1076003)(66476007)(4744005)(2616005)(478600001)(956004)(2906002)(66556008)(6506007)(36756003)(5660300002)(316002)(186003)(16526019)(66946007)(26005)(83380400001)(54906003)(15650500001)(6486002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FEFP8zbFX81EEEY0XwmSZih3Oiu5R/L+isMHzyfBXDJw2lmnM/2LDtmRPzwr4W05jDWtsycEyg313b2YqQBe8bvGydOUw0Qzd36v10iVrwXRNoh/Rtuy+iVUWdLupWmhwiJ3NArhKShovqD85w5H5v8y15KPkEwaMrwl7xXnKElA4NB8RPM/C5ehOXoCSaUXlfuKWwRL6LcKxvLJ3Z2CPGvtjesYP3CKnk4iwbBIN3KhsMmw1wXgznPkydbQGH+WJ++ZdJ62qh3B1+mi0n7ZJGCli7Ry34nVFFNKnhZwSxXeO6HSMQPjT6r2ZIWeFMncUvgALsLy83EGKnGizX7fiBabfjzkexNE2oAIWnTP9BaOACBmA43p0qzEXSVkhAk1b+EJ8O+jyL517+r+ndFho+fjdWHSyVsGXF3BcXjps60/IUDfkJiKcLHOctIvMU4sfkwqsajzdfn0UuFsfUK0f6kwmtmttBG73/RO2SbdjwiiwS5khe2gMtqU4hxfsZGy6rLw/NGkXKzdHkKZYaxTTwKISgqEHaoN+HZt45xWRp3th2R2qyhT+WPaTJuFVa4MxkzPPpIYDoj8e/RouQ0bsx45zpoOaqZGWzrMzLM1wn4BaiCQTuxbCW+xxQYZz9V9fCpDdNpt0MLkdpDOVIpyb85dyYB45rjVTOSjrz5caEwM7ekApzNodmWo7m/TxEx9nMi38kKqKruvA6nER3FfDB1IdJx9iZv2kHB4h9xBFh8oSIlvXzfO0AE1lsq/5TeFNZcBV+CRfLjlEtGElWwFOwIp82MochAqgj2vTFa0iUoBH/9Rtf0JnATrTTY6UYxcIz8BdqxoukI6bQfA7P7b/y8xgB+x7VqvrP5NSKxqi5223Poh+05At5qEdAH9MgMEkfjCXktGRabEuw4TiW7+mQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9410ab4f-51e4-4528-7c12-08d891fcb5d9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:24.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvXzYWbI0t5Ztld6LjOzViROr9cK4Qd/BaG9SiQ4uA9jleXOzwcbzJC9d+W+47DGrQhQv9FVmnOt5fDlUyWIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5206
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add imx8qm support

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 15cef82cd356..1a3dff277e2b 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -34,12 +34,15 @@ properties:
               - fsl,imx8mm-mu
               - fsl,imx8mn-mu
               - fsl,imx8mp-mu
+              - fsl,imx8qm-mu
               - fsl,imx8qxp-mu
           - const: fsl,imx6sx-mu
       - description: To communicate with i.MX8 SCU with fast IPC
         items:
           - const: fsl,imx8-mu-scu
-          - const: fsl,imx8qxp-mu
+          - enum:
+              - fsl,imx8qm-mu
+              - fsl,imx8qxp-mu
           - const: fsl,imx6sx-mu
 
   reg:
-- 
2.23.0

