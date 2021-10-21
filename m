Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F51C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2978960F5D
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUHQV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:16:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43043 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhJUHQK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 03:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634800434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wksfpm52dAveuiyLfO8LTvLEvuEZWuiIqu5BlEFARjI=;
        b=cyFsuIU0YLErCoWGxIpLIvyABRgbzoirOqezPL68MufdwKcqzX1uDYHn4QgPO4yihrcPoH
        fft+fLh5tXHK9ly/QnJH3V2zwyiiGEUjj67B4j1Zsj7o3mIgygHFIW6bznZ7qriVKDzbKJ
        au59plyfBCcD5iSsz1+U9ugTdD4hn8E=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-9-eJ7NYi0zO2KJaog3nx9eUA-1; Thu, 21 Oct 2021 09:13:53 +0200
X-MC-Unique: eJ7NYi0zO2KJaog3nx9eUA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npBXjDVAHyShRP9DvENxXtTiXZoCliTToiumQtOod/WqHHPK7HqdALA0+9zGvr0IN9WuaztEbvEIuwPl60uMKumcvpMLFo0XmY8ISFQvyOprv21+JY38aDpHmulZKFoL6wag1jf2H+LfXpzIAQCFZqgKjoKTCQ+4k3jysNVZvv5S7paRDSeSmcmsuyAOZc0xGlRjucIOPMOwyotbEo624fTcwY3cDZ1nEs5rZRl2+9bIwMWeq1gslquTfhqzxDWVM0feHqGAmJLgvyAL3ekJgBvZZ61iH1N/8k5BW7hGcAjExVGRQ39Cu3UsGFnAsCBu9Bagqk/lLkhuBiWxeO1Gxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFjPsUq8E6pZ1iX1SK/rfQcPfE+qy1bi9OzQishpEXg=;
 b=KmshSyBgRXbozV0QhmBSYFDZvCMQKH5TwachCb+uiYPyIe7DXhsI6shBoWBHLn0npKXzqqJPWsmqaC46VSVCk+OF7CTdepIPH/qg5ENdQ3U+p7P5esPcB0LdWVyzHieozEUFb+M2mVNs+52FFSiIHtzGhi9scoVqmfStILWDXWOi9FfgjDdO8pVrSoWd8VMRFgwdSv6MYmwHSVKrDJj7ihMMLegRrE0EApXyHo/TpRAb7ZPGPkvEfu3N8komIM/FRc+wfAA3abpPXfWIUuUMCJTElxLOV9AWV4XdEXKcJRd5y4OEqaG/V0dJZVQ5gIEzzmjB+po56ystgs8YP7pTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4271.eurprd04.prod.outlook.com (2603:10a6:803:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 07:13:52 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:13:52 +0000
From:   Chester Lin <clin@suse.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 1/3] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G2 support
Date:   Thu, 21 Oct 2021 15:13:31 +0800
Message-ID: <20211021071333.32485-2-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211021071333.32485-1-clin@suse.com>
References: <20211021071333.32485-1-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::9) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from localhost (118.166.56.207) by AS8PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:20b:311::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 07:13:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26c39c59-c2e2-4a22-9004-08d994625601
X-MS-TrafficTypeDiagnostic: VI1PR04MB4271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4271374FBD8EEA01F673037CADBF9@VI1PR04MB4271.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnH0Mu4e/kQrRH3bKfp9RwdrIIAd4mdX5z+mzO6aw7NT8795qbg2lDmrfzN/6dyQTT3MoyVN1RYSns6K9kKt3B0uL4QctwubvfKE+RAV9Q9qCOyYabz1Y+CapUF5PHfLPwypICnRXHbfioqDCLjoHnw8x20tRjvG27JR1INa2Wj67IfSYhRnj5pM2n0Huj1DTfv+vAi/1ElThtQEV+t9JFD/w/jOoPDS+toaLu4fx6KjR7l9JOunOHMA/XZeKgy+aGi1yU77LVS/W/EN/qeJziq29ecHVvludA7HY+3XVx0feRKHxlkyJlTeqbxiMQmZOfBQlD5CfEBTQP1oos7B9fVkxn9B2BcKmEW2jlplqlDp/MS1JVH3Tbd976W/n3FRfj2afZiU7nWKXnUfw9cVCVtKlYD7vVPdpEfbnohCaS2OnaIXdwYeKlm1FOS6eh9UaJVkkFuXxIR972l28273zmquN0BKvJJwB99ic26LZ4liYKxLEJMfsl+e9G+z6OgpJFOYoX8OKyvv2M/Yx8I/MZ8ZGPsCk07SbaP5IiLCmLcqmHhOYkRa/nNbf1ZJNGq3LsJjQN7xLphRaid83ngfH65JZiilMce1BmyseUDvVrBLhQZWO3mML0ZcxIsjlI2oVjhRkMeYT/nzHBMoaYKgzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(186003)(54906003)(4744005)(66556008)(8936002)(2906002)(107886003)(5660300002)(86362001)(110136005)(7416002)(4326008)(1076003)(316002)(55236004)(66476007)(6666004)(66946007)(26005)(36756003)(6486002)(6496006)(508600001)(38100700002)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3O84RvK5cTj++dEIkXQq3IKBsNXJHh6xRYRds/0fk1OYUS5Y2erEUtxaUEV?=
 =?us-ascii?Q?K/jjOTWkTIvuwxS2xolYGvxULT9Y2WYVitShwEcrUCqcNE8BcEkcvRac6V5g?=
 =?us-ascii?Q?+TljOX1xGT2Os1QBIgbRmUhASfXJ/Tq/f5IYW8cYMs9BQ0X6eCHo2ytfYNWC?=
 =?us-ascii?Q?RGez9QbQSRqttFU5XhRy5bisvwPLEQXMKqlGfdLYIKyYfN3vdU5/0dCH/syG?=
 =?us-ascii?Q?63jm6kuBJHK1quaLn1MISRqW3qb+6wkIyyvMFljYUwjeB8VNSSCzm+qhVJ5v?=
 =?us-ascii?Q?2iBgYBWm72oqY+jjCu6pmJppjyEZZsUJWyC6mBhrQCpXCaUDbPXvC5BsKkyh?=
 =?us-ascii?Q?kgJffzqQhHP+R2PseoSRhbEB62JtNTh4IE3I/Wq5vgNSt4i0BuU7PitArK4C?=
 =?us-ascii?Q?+Uv7Wo6Ro9cPbkD4k3TCbIgd2lofJcQnPLMR9ginTE41kroENk8ZNFUtMqd+?=
 =?us-ascii?Q?WdySW/Uh+u9vE2SE1GcSrK/tugDnjncheWKJ9QPZ2dkXIdP8Q7bKis8eYPoL?=
 =?us-ascii?Q?QUv7vZIEox2hhqqN+MdIDQ2S4hvQmy/0Ly381HbWCVBXq3UwJb8dTkART3BY?=
 =?us-ascii?Q?gwewOAFbmRub5/al/7CIwAX3LWegJs8JO84BGJywZnontMUxPJhSYs+tLz2u?=
 =?us-ascii?Q?dddjqqVxpsCcXHkIX1r0weIiS1aiPmh7I65EBEjOjduYGMEGCWksakdBC8jJ?=
 =?us-ascii?Q?AvU27XfQMGjtUcpb0+mh2YRDZ9stbx/GVoKaS6i4hnuiVY0WPaJYYI1+AQHg?=
 =?us-ascii?Q?AXgmho7Y1M7leYzL9XoA7vrevRIwsLDJP8VPFq29WTyOgAjOxOHd5cD+E1hr?=
 =?us-ascii?Q?QyVHj3qCdOx9olYlTedkfjyCineSDUqVED6V6HfJ94A0DB3/hN+jX9sCIEnO?=
 =?us-ascii?Q?EstQag458RwkYkVN+UbuIJDSkZKnjC/y1bVZpoDBIQDO+IS2l7SZZaNkwVVh?=
 =?us-ascii?Q?rqmkmE4lVeNTaw441Pna0g9ZpVWJHxtfib8so0afeaZEFDOvMPXLZ1eiXPL5?=
 =?us-ascii?Q?UYTgcDc/HNLbiwywif+oy//T19ls37yCNamkRUxRP9EOs7gEYxiuRlImxxUJ?=
 =?us-ascii?Q?wmBCrwVP1pDdLhB44TKjTaRwuREsvTeQoB/X40DN+Br/B1Jq/sDcba4CTEHi?=
 =?us-ascii?Q?1psdd0YjP4GT3vOPjElRorAD+zIwMtSJKunXwhq94txaPtXLS279V7anodxU?=
 =?us-ascii?Q?kelvfEbPL7hWuu5FeHfXE40lc0n6HSsfWZA9DN6ZH2Vi4jlqZquLOTpnBgsY?=
 =?us-ascii?Q?Iq23t2GzFufggBh0e3IqJ3bczlkTkKhsUk4BVhbzMRxk4Pnv5pnb6XeiG1Gd?=
 =?us-ascii?Q?9KwG1OtZhe+cNBFdp76xtTqb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c39c59-c2e2-4a22-9004-08d994625601
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:13:52.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4271
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for the SDHC binding of S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Doc=
umentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index a3412f221104..19621a2f8beb 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,6 +34,7 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - nxp,s32g2-usdhc
       - items:
           - enum:
               - fsl,imx8mm-usdhc
--=20
2.30.0

