Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DCC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282CA60F5D
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhJUHQf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:16:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:59916 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhJUHQR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634800439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCpSqxE8PFlgIC4hvQFTF3vTqdLx5mVUT/kr/moCM2I=;
        b=R2mW13Uf4NYjcBbHWpykHnYgxbryipeHQyJuc6Vq+BM+M0+Xl3SWbZDTx6THhq+HFrwHqm
        hyUdeums6+ZwkpVHCeMPxe43v8BRwAjhXAqvz8bNl98/5ffT1kNGCQZHB5Gjatl0vEoUm4
        ctxw/ETNLu6zdV6e95DBpKRcPogtHHo=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-BNp4m4lzOF62jTTaje4O0w-1; Thu, 21 Oct 2021 09:13:58 +0200
X-MC-Unique: BNp4m4lzOF62jTTaje4O0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMqEGme1Bytu90yGnCPpo5qiZtQxn8Xoe2ox/piSvmQf9/vuRy86ryaJJkkWpkocF0cZq3mStqRLbYk/E5o5NUl1JIEXUaHP4djr9bgopRYJCgOf+zbwDeJkxpZ5H9ZFW38S8wqHhKBb32estcMdbWY5RSLE1lbATwX6HWU1HovHZx4K7k+5jafReZrEb/XuOp/zh9r2dou38JzZ9H0Cty8YZv4HmgU4F6qPJf5ttl7HWlz9BRPFdgye443jLEAkilbr5xT++BWI2TdG5yNk1yhqnk9Bh0m4Mde4Y4IAULRTOwmyOZXYJnjt5hZ0+3+a6w3Z84Nl0GwDNLEEafow3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRR9QQqyyJqEODYW4ZNtz0+kT6NirDlSQFWTK9NesWI=;
 b=d9gbKBGrQ+5eieyQeyyQUgCqBhO71QRgsHOoKea1CpGs3ho3HxVfkUdsQY9EHHN7UeqfTWjqBgvTaBJlMwmYaHuI76pMTGVVyVbhNqwUkyIwx1hPqKC0oR7vVvi+ufov0w8MIO0btbmbqmPR9RWgLA0hMyVfWmErIfvZXxLGtvWCBZe03UdhANQRyNEt0zkDkCAhPKo5Petz8cNGxTzLSFpSncWrP2ntf998Bnfuj8yMv5g5Vw8TzJjI5BnBTBtzEkqsb0Tbt9tx9FON69YUMvQwa+leBkkUzxfqZVxXWDnYOPyvWZ8cE+wuKSr4F7WJ5svkJizVoLSCwU2/cCm/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 07:13:56 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:13:56 +0000
From:   Chester Lin <clin@suse.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, s32@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
Date:   Thu, 21 Oct 2021 15:13:32 +0800
Message-ID: <20211021071333.32485-3-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211021071333.32485-1-clin@suse.com>
References: <20211021071333.32485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::30) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from localhost (118.166.56.207) by AS8PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:20b:311::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 07:13:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 292fbb00-10f6-4102-68c0-08d994625897
X-MS-TrafficTypeDiagnostic: VE1PR04MB7248:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7248A342FA7AE26F9B723D80ADBF9@VE1PR04MB7248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKi3lFP6P1dHqxXSe2lQUuC+fRz5lC5eFT2a5Tot9HhAmjPdL1qSLAL91ajzLTtM2YqlC29jpP/mgroIgvn8YsOk5EOgMDIA59nPxTVD362vFmb4wWcltMQaeYC8p2T0IpS4Ve3Z16RDcwFfd9eu/ffesuenfMA+bBlUG5JIyMRuS6TIXJqJvsrpWzwA9TY8eTe2gA2w/21J1BVuIHUCbuCTA5oSy8fElO5vUnpYddoUqBuz4+8UpsJYyFGMHZ8BzhQbvIqMOyhrUhjhtW+ONsMVpfRkuLN9TA76J91m9A9eV/NR4A/FVWyvQcKr0lp3N9ytCmdwvRRjAChAPy/j50f0GoqxtDLSaRvkb84AhGe9JFBnd6Xm7r0azS3WN+k5qd/dX1zZBlP2VM91QO6D0c8cibDyGFzk10z0mbAOzNZmihTTPB6XZxQ5ZOA7ytWGAieNpIsbrVpEN4XSx7gaxFA3Tm5QASpc/hLUdkhLVPvl1s4FBgnlUjcnz+O9Qnfu8cSKn6QWjlGt+6Vdvo92f3L6VBJdboD1EnEDaOMefvESHQi2GreS4WGqV9J0Ufykz7elueRiecMJ04Bw4yDZcrBIxntN0MnSCEzhqzhcU/HvFA9AldHQRD8yS4JaCUJmvY5OKDtDIcDiPQucuhIA+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(2616005)(55236004)(2906002)(956004)(8676002)(7416002)(38100700002)(6486002)(66946007)(36756003)(5660300002)(4326008)(508600001)(83380400001)(8936002)(1076003)(186003)(107886003)(26005)(110136005)(54906003)(6666004)(316002)(6496006)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epJK+CBnyVapOgXVGtWkCqAddcqa7G8I1tzj6suJn+NtIh0uF3/Mr6Jy64tX?=
 =?us-ascii?Q?eIp/Rv6CMqGNESB2im19Y1g5Ztts6iXxMmlbUkjUuGqhlCXBBaHdoVHIDb5R?=
 =?us-ascii?Q?WALu1QCCYzaPyC28q4SoYemDh+21oN1kdvfarAFMd0QvMT50kIPFtFw/ZpwD?=
 =?us-ascii?Q?fr5C8gm74Whk6e+XmY9kR25l3RvcVg0wiQGTPB+AbYraadRHZ5qk8gZvRKiI?=
 =?us-ascii?Q?tXNGL5ZIFh+UpmAJUgRau3lHRkc2945VFslmjGFhfcBeia3gu2wPPGbedfHb?=
 =?us-ascii?Q?QcL/Q9bbqzBEvV/JZNjOMCzNEqnDboSeikf4KubGW34eUuR0+pXx7oorpqx5?=
 =?us-ascii?Q?dZ651+gJkHaDiIk47PuZ2NQCbzjQWjd6XQxlYk/8hKVtrnHzQPAtU7RqH/u6?=
 =?us-ascii?Q?PHaV4ns+ujztoAsEKLPVXVBNUrB7c7NCOS8VqYBkKyp0BJbrpPcxVDhsASOT?=
 =?us-ascii?Q?M3EajRamFmyiMExAShpDVdf5TfAWDvJbyxr/YJS6t7O19ZK7WWYRWJ/3fStP?=
 =?us-ascii?Q?nrXbse9hcQPlfdE4/8Gj/qZdkkE32OjnLDlOfSheUZADjjAGzYGKdtTFktN6?=
 =?us-ascii?Q?FcIYZcr+0Oog7OlOmCovXxY73uhm+EzhWpnB9gYqPETGTSiwY6URU+g+I56n?=
 =?us-ascii?Q?FwXsfO8OVxCnNzX6IZ2gLQELplPe+7CbXD3A6lTONUE971HD8KmbAj0I24A7?=
 =?us-ascii?Q?7QGzSRd8iMlCU4IuPIGEbgULkkCxwi69o5+0zMcZc7suux5mtclFoexjPd/S?=
 =?us-ascii?Q?WWytgjLxct7spVtCPqubQcx4OOdwhusBnQ85eP4vFFxTOjO1QhDIVyxA1Bye?=
 =?us-ascii?Q?mUbpJ0NDMFwj+PdSVl8o17n4405u9Ai53AvoO1ybTto6dt9o4+BwrslLUfwL?=
 =?us-ascii?Q?JVoir17vAnULY63wtEBXvF7Ai2oPdLilSgBtBChVicaA8E7VkTx+zKqaR9jX?=
 =?us-ascii?Q?/ume2nQ0kfTpnIG480o2yVMOG8c6OQLQffRdIC74Gce7XYcemyWSKERq33lA?=
 =?us-ascii?Q?F1YZOF7nJgxemxxtul71yUM6seUpH0GxqHXIGGEy/s6ncy9LKrJMRng86c4E?=
 =?us-ascii?Q?jVklfT/GBZ2U2qXOteTXpqxlXweU0EfO6OOejsnGIeqGBpZKwE/8nwCJMdlD?=
 =?us-ascii?Q?TRNXjh91Nlpn4noLnI16LjfFL18Sn2H6TPITyGO3DvodNr7STbf08IChiSEh?=
 =?us-ascii?Q?4cyS1FWyXqxNx+bF1G281WkqnGDH8CG+m0mc3xFHz3k8NhNBt5DPaB5ZQFbW?=
 =?us-ascii?Q?+183pekgraYqx0N+IyA2XMavYYVOmGfOpGHS8aDcywZ54jS6ADXGe7Urte5B?=
 =?us-ascii?Q?xUp0uYHlriGAd/4OwG7CyKSz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292fbb00-10f6-4102-68c0-08d994625897
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:13:56.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Support the SDHCI controller found on NXP S32G2 platform. The new flag
ESDHC_FLAG_SKIP_ERR004536 is used because the hardware erratum bit is not
applicable for S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-es=
dhc-imx.c
index f18d169bc8ff..d0f7d46a0354 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -196,6 +196,9 @@
  */
 #define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
=20
+/* ERR004536 is not applicable for the IP  */
+#define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -289,6 +292,13 @@ static const struct esdhc_soc_data usdhc_imx7d_data =
=3D {
 			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
=20
+static struct esdhc_soc_data usdhc_s32g2_data =3D {
+	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_SKIP_ERR004536,
+};
+
 static struct esdhc_soc_data usdhc_imx7ulp_data =3D {
 	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
@@ -347,6 +357,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] =3D=
 {
 	{ .compatible =3D "fsl,imx7ulp-usdhc", .data =3D &usdhc_imx7ulp_data, },
 	{ .compatible =3D "fsl,imx8qxp-usdhc", .data =3D &usdhc_imx8qxp_data, },
 	{ .compatible =3D "fsl,imx8mm-usdhc", .data =3D &usdhc_imx8mm_data, },
+	{ .compatible =3D "nxp,s32g2-usdhc", .data =3D &usdhc_s32g2_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -1359,8 +1370,10 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host=
 *host)
 		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
 		 * TO1.1, it's harmless for MX6SL
 		 */
-		writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
-			host->ioaddr + 0x6c);
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_ERR004536)) {
+			writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
+				host->ioaddr + 0x6c);
+		}
=20
 		/* disable DLL_CTRL delay line settings */
 		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
--=20
2.30.0

