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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A836C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88CF21D46
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NrPqTqgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgKZLQX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:23 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388815AbgKZLQW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTwlwf7bHnXAUnFa3UbnPHjR+QpJMuxPOHqlsdbnn42V1/NYH0+WXNLKLXQHMgBljpOcLAFnrmfkTBF5TDeKTV4r9c/d3ScjbcKV8tl3Ct2EVWcSeR9Q/xY08xu4vzTWiC8j6/peYHVn08WudfAGQM7URijMcoOoffO8rtdddyxKuRJoBMAvF8bMoyhmdwmDU8ubr3yFVOuXO0AKJcFnwSpxuc4ZsT93cuz1LvcooQFFMu+OvVyPFr8JZb3XMCsVNzw9b5PfeLM9CxwWm3bMMzD4PTnkUb7eyY/d8ZiWKzC1yVHndbP0xX0mnjW1M9crBwto9s/5JSpup8t1Jj73Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH6U0CSrM9oSSzYl89y7D1qrxmXiJDhwPXvEr4j0ABg=;
 b=ZDFHytDnxDELd+wqIqCpFMbL7jIBDMIwJ7EH9fKL434G9OGM5G1WChE7g6bEmqv4UV73IziCdROV+OY254rn4XLkkhudlMTUX/5DZqzQ2ddDYRV1WL5rcCGcgd1vvT8OQmrQ65ndjs4ThnCOoRQqaeoihDYISenK+jiddwPNK3nQK4wG5mgt1AcvZu/7JAid90/P6wyAd4gy023l3I71mM6Y6ZuKWkrpc4UkIgGYPqYHLuTf3THpfn9j75ypwvUdg1bTpoe+LWbrXHrwYLiu7islNOcTAbyZnor0DW2DKmidWNqG7TK7LKW5TvuowqbombIjfRfwIjJx1kaxb+enXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH6U0CSrM9oSSzYl89y7D1qrxmXiJDhwPXvEr4j0ABg=;
 b=NrPqTqgw//4+r7FJGbOVZeLwTTgbpHt2RnECBs+b2Q9C8OAIPEDsYf1wymRjXaKKhblnIKRypesCCJw+q+fwK7LhQOcQiPolE4efPQiU+28IYjNsf42HL14cN6Uyrd7rLEoxRcWLne9JMfKSMvhyMKng5cRvRXAeiHCZ/Utdyb8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:19 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:19 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH RESEND v4 01/18] dt-bindings: mmc: imx: fix the wrongly dropped imx8qm compatible string
Date:   Thu, 26 Nov 2020 18:58:43 +0800
Message-Id: <20201126105900.26658-2-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3823001f-0e9b-4a30-429e-08d891fcb28b
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6869D26CFC815CA71D022B6380F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2iWV5VD0KCqpCv0j29z42cZYZ+KzzXtYUmvenS0EuOnTMx1Qwpr+L9//FvbxS8wO5wcBS7YGO3I4wuiohtj8slS9JkW1rIjbkETYCLtyIez2OXK+WLTE+zPbinC7n54G3K1sLI3+23wvx0shw/1+UXi4YudObgHPJPhz3UkS7vN/1h1vHMXJ9OFaxZJak/+SFoGoZhKZRO745vHnThPuvW+lekGVdXoYzaTs7BNIRj6PdLCM3MxMwtvi08Js6jdkpaiq1Xu1oT3KC1gHjbYSHzQNmoIcU3USERL8NaStzzX7hxqdaaMctuqPSS5tMiGbzi9WlZJtO/TKx6oQZPCvtf7+eX9qLMuN4mUKspR8zIuIGh5JXu3i+VnPwxFDTOp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(4744005)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(186003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(54906003)(52116002)(5660300002)(6666004)(26005)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zWYwE+mTase/FMmTFEHCXTgOpX5XIwaDdtaQ68K0np4kWAXM07g7D08/eAzF/93Cu3rTW+ri7jE/Zr4LH5XQsKT8VLQMv0q8e1/KMxnev2XO1/UOgvI4cI+SrlaFdH84IK4U2eGF6qyvd2/kZ883SkBVVAdS8wRiYUWYSIXVlnKZNZ65Ukc58MW6v5u/aRcgTgd9KmK7+mIzdM5J0DSQuJswCTWX6jlPQQkKcFdwyNtl/rKYWlc+PKjzwSoO+/+Jf4qz4uppwfACIKfwxiqdzgM9EZeURkTcRKQid2WcNFlBqQ8SMHFyReBqo1t3e8Su0tN42TZ0gr8g+tQrmFaljqcunEWkVoroFZ6tDzZ4flCSROw5pQlPs6YFQzt4838eHerWryhzE+YY1qFSKkmIFBRVEv2sB5i3t8fUWKX1PiEp35ZrfisZPfsokJv1AKyYvEAjbTvrdAJ5cr3mQL7b5pwrpF6rO9JdCxk2ADu3dAn8fSDUvOjYa+XRfdJC2z1TCJE8An5J6WJrph6poNoautzF56LtJs5HkN+45x3wbJt968hB1cj35FwY88TkJbBSt1k9v2ZhDH0dqQJVf+l7mQEoLsl+MZ9hv8QcVxCPB7o0GgtT21qL5wmwuEnQdDIXbiVgPPsqriCGXDuKr1J3BbuYShdeIfo0hVHb7Z1CbkfUY16aj9mrjW5vIr+ds+S60xjeVtO6c443CKXvZ69ui5h1qs85oOmxZeUFKOOOMh612LCyvTjnsvjf0MGbz7X5hwuyehQjIGPyPgzFutO+GnRd4oroQZyyFx5oe65XuCCMBu5VLgod4ffiuLNOWJRuUuLZ8DcIRRYUuJpnGKFHCc/XztlKQr8ha0/yvQ6E6M/7CnCah5oKyGMy/0C5I8a3yL51ilVliJ05srETpHxmNg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3823001f-0e9b-4a30-429e-08d891fcb28b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:18.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHK38uuVWZbgvGnK4bK8Xd4cartGZoeVPB8UkTfSesJJGyqa+PFScmqMnrNJRfF4sRA6qR73kA2cJpA1eNiEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
commit 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
Add it back.

Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index e71d13c2d109..802c9df23752 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -39,6 +39,7 @@ properties:
               - fsl,imx8mn-usdhc
               - fsl,imx8mp-usdhc
               - fsl,imx8mq-usdhc
+              - fsl,imx8qm-usdhc
               - fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
 
-- 
2.23.0

