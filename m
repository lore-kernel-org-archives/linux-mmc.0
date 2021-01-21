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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E3C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBFD238E5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbhAUDyk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:54:40 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:28976
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732039AbhAUDWt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 22:22:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx2xEf3YyznqDFLD5jX3A7XAPiyNRDXr8uDPNo09lJg48hOE/6Qz0K1vRccuHzLd0vKDXLhjPmysl1oh4Jluyt5s3O0TSs1AP486yqEbvbGkZg1oaeUvuBhixW04sASyPpnZyF9Dk3xY4CbvP07WhFMQX3M9JGHFEYXU3H8VEYFXChezkNOQ7oL0/O59mK0qnaV9Z4a1ocxM/GMTo5XK1iBsLb7AN7PXMlCeX4XQZua1Ty5IjCc4hyxRc5QX9N9L/98pZgNC4/1xSMQnCus2C5xsOFIox20Kl+BKoR9V+VHsNuvb8gggPMvMgySH3WGdEpoE8UevIAsAbEYVBCBKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDw0tsx8K+Btrx73PfUj0hSlKS3l8KQdV8eUXMyigKI=;
 b=W+fS8DdcQSCTo/5BmenYy0rQU5K97rs+ROtvRv98nYYygAhMYh0OY5CVuDANHDRHwAhst/CUBcR45+blr2gUzJ47z7Si3q8LCiV82b0OK2BaAaOdns5JgWlNvjvbOir68Ad+Yor1HO7ANQyz56NKhA5FMocbntUosNftJLvtyH6sbHmfxsBYyoUL7i6qh4ZfbHeOjvBUv+4K7Qv7zdU82qy4XfOiYndrNRsTupujV/Gf/oX1UmzvacoAR9td6taBNEfnyYUAN1GHHU6M1FikI5Am/nRZwcp6tTX/vc9EQnElKy5tESAjc22wJ1qD22ABYRF9O/73trxKe3J1d3RWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDw0tsx8K+Btrx73PfUj0hSlKS3l8KQdV8eUXMyigKI=;
 b=V8vkEPvz8GG74muNsRSiRWIPrER4wWy1A+eXFXKyiCImFTGxBllUK5o5OcFtnFCjpCiftrjpY6v9Q6nqbh0jcbFa6/KigeCuVq5nWPqdmc52QQ2+ifWme8bMTe3zfeZtZOIXq48Cd2eiCMV/9hdgIfMMnsNFcgdHeUun0svAopg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 03:20:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Thu, 21 Jan 2021
 03:20:35 +0000
From:   peng.fan@nxp.com
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        adrian.hunter@intel.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] mmc: sdhci-esdhc-imx: validate pinctrl before use it
Date:   Thu, 21 Jan 2021 11:09:53 +0800
Message-Id: <1611198593-16287-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 03:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4d6dddf-ff62-4493-c9df-08d8bdbb83cc
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68588501E070B82A0477D43088A10@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcIo75BtfSJdJHl3ZbzNSWx9HD6q4+WYbaRq73LpfNFWiNgUvhyXDs+V92zUkPgECKgCdwmsbKFa7A6wpnk4QdfUpgFoNbp8fVwQfioDEfH4SHYECC+23q3o/F+xguxxonxrbLrzDQUZPnPF44oxcUKNGn1edqQNUDWnTmu3z1yn3r4qDsv3hql0PMdicWZberHKNTWWC6JtZPdig8xljPt7ZatGjWHIjmY2YehMn4PapBUZ5GVVAThHKbogeNDtBezXl3+cIXJHseqtd57TSY9blL5bGPb/vR2AuqY4BfKjFkNhScAmPvfP9KMOC1njl0dZwcorrYWZovGMdc8LtCode4efiqBdhBsHlHtO5G3S0JMWDFTHYCe7de3gdO3i+ODaqw2lhwLH27DFns4S8kgfZFbaMvdngKw5iEKplC+wP/RWqSPf/YXXmPr16KxZj6Q34fHY2xjgXOd6t2T1dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(36756003)(6486002)(8936002)(186003)(16526019)(6666004)(66476007)(7416002)(316002)(6512007)(8676002)(5660300002)(66556008)(52116002)(83380400001)(478600001)(66946007)(2906002)(4326008)(6506007)(26005)(956004)(9686003)(2616005)(69590400011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l4b3DZ41rF9ykMKyt/sTdY7i55gd9n8UjkEb/AMb8WSTz8jz0inV1c0kxNao?=
 =?us-ascii?Q?oioMFVfxjHiLdkDGzs6n+fwmSIv9wfjOKur7wmcla+asg4ypb+KdVj8GP7QW?=
 =?us-ascii?Q?vby9YNC9KC1Iw7jhNP9kGGzgks80GpNv1wHXmbS+9o53sGBuiERpokZmKieL?=
 =?us-ascii?Q?4wTquLtiFSRcgsi08u+ftv3tPfzsf60K8X1B0WReKOfiZ7+a25KYtU0fjfsR?=
 =?us-ascii?Q?otolv9Ee6tXDdPokbGEKBrumbax9awvWGhxIc4nS400iPC4y20Zmy4TlElnk?=
 =?us-ascii?Q?cdIYK8XQJ6SeUjkqMjc5sQ+zZNtgtegAhPze952BX9yotdI5e8R7rmHyRr9y?=
 =?us-ascii?Q?LL5ixDuYWddt76ORP/hszZKMkyoGz3WIAvZgl3tbF9YZMs4ZNekfrzN+QKSr?=
 =?us-ascii?Q?UKwzOzr0lnUCZSkGiKcVnmSKZ3Mf/Ti3fCP2Z7VFMKRv8+yD9altTi6f/qHB?=
 =?us-ascii?Q?+G1yuPGcXX+jU1cFcnwY1N+1Q8XJOzI4DU3nBorIBuAQEwwba4yYCzGxSq1a?=
 =?us-ascii?Q?ee4BJNx9xZOBAieaOAjUPFc7Ms9USabsUaICCaN9b2CrmRReGXdtiykJoaZW?=
 =?us-ascii?Q?7TNoTalZIbBmj6Y+QS36DWIrzsB47bOJ0pXdi5607r5koSaQvr5zzfWGfyUW?=
 =?us-ascii?Q?A08ioA7jntv8bLCQxEmk+Ut65SggAhr2M4XBN+Zfr4GkUm5b+SSmmaU+9xH2?=
 =?us-ascii?Q?pf3d2T9QJrRL84l4wOwa6Nd/cXUPK1F47a32WW2ghVcuaeDeKOYIx9V4odxJ?=
 =?us-ascii?Q?YKqP2XPWt9fVNqMw3NzkLnbymIRtLpnW88B+XpE3Rz+6UrF7YqFy8Y5hRFVf?=
 =?us-ascii?Q?Xdliv8LU1H0LhyeuZVyRTx40nl5Ef/9jibBd7VvtGcAsF6fmZWfFSuAuFax1?=
 =?us-ascii?Q?IRw6HQys6+5D6HTkjlQ51mSaC9KQGd4mTbNVPBRk3IYImfHAQpWNnynjxzkf?=
 =?us-ascii?Q?waQW28hhLQISkD+TqpcCDpl1clKZSwiPKdYOa2L072aP0ch5ewF7+pqilIS4?=
 =?us-ascii?Q?yF6k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6dddf-ff62-4493-c9df-08d8bdbb83cc
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 03:20:35.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjmlC6LuNPOBhYB5quPsCAwX/LLJQ4yda4cL0rhRQQbBMrTAc0gdwRfZkiaZ8/UMv+AlW71C52XNPcwvyGzZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When imx_data->pinctrl is not a valid pointer, pinctrl_lookup_state
will trigger kernel panic.

When we boot Dual OS on Jailhouse hypervisor, we let the 1st Linux to
configure pinmux ready for the 2nd OS, so the 2nd OS not have pinctrl
settings.

Similar to this commit b62eee9f804e ("mmc: sdhci-esdhc-imx: no fail when no pinctrl available").

Reviewed-by: Bough Chen <haobo.chen@nxp.com>
Reviewed-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 16ed19f47939..11d3a2244b36 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1488,7 +1488,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
-	if (esdhc_is_usdhc(imx_data)) {
+	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
2.28.0

