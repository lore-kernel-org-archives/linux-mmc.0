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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892FC8300F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B321C2222A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 13:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMA9Q+mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgKSNKS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:10:18 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:63815
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgKSNKR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 08:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5OiNTzbZPE7HNYfSyRoJwrj3il0mekUlHx+RAQ+Tfhnp14u25jLrLI1hrFHNH11MukO3WExJe3A49Dg2yKa0F0UBgsxhpRbuimYb+Zw46DoAyJ9cB0BIL7vnYAFS8G2JmJ7c0SY+p9/dVq8WBBLD2fnOD+nFSkgvobdat5n3icufTl9tmguUFsj+di3mWFYXk3uznYv3rQUxiYakbRNy/jnrZqETJBX8J162SUSf6LYVeL1mT7aT8eq4ypWyoHpsEkjoyHY+UNOrlTbXEwcBaAKkvyCNZPJt+xqEOilm7OqS2hCP7+pRSo3kxy89L5vHifyaXKFdnLIk4ID5Y0Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPjE1F0/hBRa7uoDuxFPhl7FCkcNNv3todKN6f4xeUU=;
 b=E0jldgYmptggT9m9/aw5qfoOxA755+RsX9y68OB728p2YnvOeiI1/wEAjp2GdlOW+CVI2zbCd7DAs/I5SnZQudqkjc5Erf0G2eeW0vDvuwEtrtaLRm1nsyANBP5QSxSdzEIsCu45J8Hx1SMTJCCcSOIM6JAK+GdVhsAKEs1qqmav9JE310sCi48b1I5YxNpKudUa6CUdixCohZPf3fihm6CLVYe2QdQEvEsS6bQoKJF16+GnbHVk7tmeDHYX7rLo/JU0OLoF8sZkh/crveoDVJYClvdrygJ7IgIEMyW54N7Ii1vz9qtmL+0Z4jxSN+qoQs95OkTwHXQ/ibl+GTdJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPjE1F0/hBRa7uoDuxFPhl7FCkcNNv3todKN6f4xeUU=;
 b=YMA9Q+moAXZlYr8nsdiQslymP89QzMTA8HOQ7PL3U9zb3EgvofsYW9k7WhaUU0lRHToHaqvqfMiIt0L3+wmwAmHgLCViA8xQbR+B17kdsD95HZMk2A6G2Pcdn2dbZy0RITM9dsqLlqlN9irjRBBUm33qcgjr4e9OR8QB4Xaf5mw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM5PR0401MB2450.eurprd04.prod.outlook.com (2603:10a6:203:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 13:10:12 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 13:10:12 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped imx8qm compatible string
Date:   Thu, 19 Nov 2020 20:53:02 +0800
Message-Id: <20201119125304.1279-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR02CA0093.apcprd02.prod.outlook.com (2603:1096:4:90::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 13:10:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 876819f0-540a-40d1-c315-08d88c8c72d2
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0401MB24500290DDEF50460E59213F80E00@AM5PR0401MB2450.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLs+yoRTvL9IGK2cv9MDKAbqjhjLYRyxBm/N3thP7P6o/f2lhbv7ubeUGLHVS+ybZvAUCoz0xQCNHXe902W89szjqMgHer/TCGMubNTj8LyXPFyRCtbkes/cIK46dLt2OK/aI097OIqDw39NhfBNZiRogJJPEB2ckdMDNo0BfYGXG72gjQeUeWCDu4CB6/kWVBhzAG4wxAB24h5ENCWOb34tv13ZeOXWaj89TrIq/PBY58G/H4APVSL+8a4ejt64sTLr4h/hfYhsshre7SLLs9sW7oNm/ODVOrK21KeBdlfXdotm/LN3CJK0m/EtGNqGfGh48Pdov/I2oJ2mc35pPrlHdILUQ7BJGfiGrfFAY28lYz19jt46pBN67vKcexbc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(5660300002)(1076003)(6512007)(6486002)(6666004)(4326008)(956004)(2906002)(8936002)(2616005)(316002)(36756003)(6916009)(186003)(16526019)(478600001)(54906003)(86362001)(26005)(8676002)(52116002)(66476007)(6506007)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: utq9w/4Q2CeuJ/N7rFtWkxoAepUfMb5Y5HML0ajAzTmQE0E8KYONY3d0poUGPANerQNilPHwBsgpAQT9y3C4JK/SpRgsR2fHNw9EGrEMIZLQabHzeV0MWDcJYLY5CcqDE9pI4MqutZ2ImnjZJtxyOz/+hZ/q7Sj2loEfd0OJXuLstdda9Ae4Kk4+sh1a9j5zZ/+DBeKIUPYH50ZiUxuoVZjy+KgCMx1cV+bhFiaDdenHpnYSLZP3Ex6MEZf6nMAzT2Lx9920jQENPhWh/tXb8CZxosUgsX24G7ZuWAtuyXj9EJNDhIU4ZXi5MqlVRFfj9FXrxyVy5J/Eh5Bd2qrDAn1sxQLb+GUv4kPv9BOSyG1Xdl8v5IV/dnUxxj+rso3pN34dXf0fAwY3NF3EhxmC4Z8ZmgdqA7ghTmUcX0P9Q8ayHPZQoUxws1FGy1cfvI+rRKXU80G+YtDRHpSbity3tU5THXawILsiGv8lqz+aFbUdV2T1xAKPUQgp21nUFxNpZxT0mDhZ7KETU7KlQHT5te0mF+9eCkN1qpJllazqjUlYD9zLy5+uWw+mlITWhsvUpD0w7HLgKxE4GCZrKdJ/ZE82UhY9cDZl0j03/XHapF15j5dY1cIzNfA9oei5BxWNMFCPB2wcA+ECbygGy5iZWA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876819f0-540a-40d1-c315-08d88c8c72d2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 13:10:12.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sbua7IiGB2QzSOboI2sxsgU/YdRh5qn8jIpHwEm48LJqrL/izU589Yg75BR+4iVDE42swO8KkE1JzICs0hriQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2450
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
Add it back.

Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
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

