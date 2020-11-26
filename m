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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F539C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1141A206B7
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7BqoP0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbgKZLQ0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:26 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388830AbgKZLQZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY2baKAI47iDA4Yhb4TamSRaLTnqGSHv7VUhBrVFLIBkoImZ8v5HlwPf2EJmwZSp1dvq+tMGlPl4uUP9T5I4FSDN2mgUii/XYkoeFxZtjUl3IMkB8M2RQLPo19eaZtHYYUnkjgh/ETXSD3xd66/KTkUvc5RHljJhmETOr7OdVisVeU+m/oCWjuBKY7tXYXf08TMHFG6Xmk8uKtyuk+7voKGPnu8TvCGBrqbvpndVVeisOaCa16d+EBVM3mMggCwNU3EVhFixaB7Kf2cI7QcGITLuavr/ej9beKUMvsPdSOS9SVxIMasB9Y1aoDui5CJqKj9m9DFeQw380rkYGOSQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7avBHb9y+2Utuc1ICinyFXG7FFJVc7j+RnSVQJZ/ezA=;
 b=I1RUFsVsfup25+y3Aj9zIvwV8lB4E5JTV035SaIXAiMwHI+X4V5T5b89gS7TFXG1odTkxZsYUu0oljx+syxX1jZ8tw3l7ihaXcbrwND+q18FmqstCkvCLar2OWJBVpyAE1Qmy9rrcJ/FtHjSSAbi/VqGgZzChZ0Hpu1U/n+eFzr8LoYWwNs7sYJP2gAf/YMWEENb2BpPvgDB7n7BYajQZ3e9pasQ25fYTX0nKIhW5T7rzG8x2qrb4WeZcGC0Eq3lp/bqThg/uBwwzQCttAvm53yPXkb34w5GGE8zXeb1qm1HRARkdJ5GdIGGlLFa1Nqx2lx6PMGDYkZfwbHTfD68RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7avBHb9y+2Utuc1ICinyFXG7FFJVc7j+RnSVQJZ/ezA=;
 b=g7BqoP0DZWX09L44tmQcXe9hj2qjVWxd/6gwT/Ynsg1YFrNA+789DNaTT0E5xkc0CmT4jbOmxIiPbXQArqa2F5FshWeGczMLN2IHEDwy6oooMUFmo9VtNFW3DFp2p+H/ptEy4iDRGOAyYhIm7NCCJf61O/+kfkEKG6PPzELSLCY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:21 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:21 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH RESEND v4 02/18] dt-bindings: arm: fsl: add imx8qm boards compatible string
Date:   Thu, 26 Nov 2020 18:58:44 +0800
Message-Id: <20201126105900.26658-3-aisheng.dong@nxp.com>
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
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f522a0c-2291-4b31-c0f6-08d891fcb432
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6869DCDB0B82FF40EFF5F9BE80F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8oK1o+zmwXZI6k7jVkTAOWWLz9lcu/npgq7vcdyP5/nE0mxcgaYI+fv0Iqx1sGnNGopZXTaikTmV93k6KmdeSDg4GJ01d2sZjvOHZj/Z+9K7kRBKy4bAG/3nk+2RgxFIr+u54bQbo71XJzqjj3IWPA+jVdh18ThP0mEcaXK3SyGeYb+VgLhadlDK+HiP3UYVmRMZgk/9vC0414GrPn7u4ex1TRKSM+NOYS8gR21U4Pxx91Z88IppVUGeAQE5DsJMIKp/pjTqZMPL1ynhLlNm+AGWWTWXApKRiYFGop/7wbxw3b17SU0UYeATKbD5Gs2c15HPCbbAm3B78zILyyqqdZPhFyYXlpVcX/uPmmfht7jXI33X3FYkqYd4cwG6h4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(4744005)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(186003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(54906003)(52116002)(5660300002)(6666004)(26005)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Fc2LF19T5c3vSvCJO0BHDPc3QJNeCZlNk7JXQD2sqRc3/SCGIz8yUzohWbU+eWyCfRisAOmSnFbXhVFG1YNFvYw7uZZQZ22VMUzKoEYW+QuwCzpe5n5L2sQtyFyj2tbj22yQdkH423mbfiUOM2lsEKyGaJm2vj/umwTkAHXBrLy4UZMypLe+q71VEnHRfVydpD3jt6UeEkctNeJ2ak4XLSFikAfPxvtCGlEnATdfcaG/UYavOBHgbi/8bbx24EpNAc6uDIjup3THfnHgeiUBHDDjJJpE0nfB9os6Pz8V+OnwoRfWukD+S/kmw4NFf+2dbKwLScGbZWl0e13f94r40u71OXleBAGyh7muS6158ID17IbXYVngbYqNdxMiYj1wjbSujnfGuq9T37FEizrVokyASRiEXxgyj83Ss1zoZEeBlPa2UUTG5srxKcrn41m7QA7V45JhYgpE9gWmxN3dYEEFsuY89eUqXRrxLH2buTCiAHoKadFOiiGC7fFaRm+naDR71U3F8C3X30iZK+7H4qieS3PE+SbTm5Huv5YmSLQbNXugnYypLlZBzw7XSJFt+7E5o24Ynj+OXmpNgvO07eoKsaAhJ0wj6wxUFDodgS+4rqiFh3DiRGdmiZPHH8sUyfRnSi5HPmLuuWQpJacEuM21AzwB0UBO6oTNjqweWtfcEKUuy5LhCPKBQnNpScJKVeJSvI6X3EbhttAckuXYaJe96j95qPw6zjDfDPHT6IFcmrNGklniCefUXPmBkyRGqa1R+oV1be2uEro22zp5kIgYFEe5/Se2QRNrZ0dU5QgCuWknjicSwXWFWBVAJ1qZ+ubjNIfhe11T+Q1x4bGgG/1P3jzCxwwfHJuVR75D6LNbf7E0bs5Hv4QEVjtlX+RxLNGz5V4sNaKPtzGT0GAZAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f522a0c-2291-4b31-c0f6-08d891fcb432
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:21.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzC0S+kyuW1BvQAeYrf5+Kpwn+LqrlA/JFlJCS6CIFbcAr+u2mM0men8+MuveJC8NoL1Yd0R7o2wsxwukjRoMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add imx8qm boards compatible string

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f793f90fe2e6..d69ac5c0554e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -726,6 +726,12 @@ properties:
           - const: zii,imx8mq-ultra
           - const: fsl,imx8mq
 
+      - description: i.MX8QM based Boards
+        items:
+          - enum:
+              - fsl,imx8qm-mek           # i.MX8QM MEK Board
+          - const: fsl,imx8qm
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
-- 
2.23.0

