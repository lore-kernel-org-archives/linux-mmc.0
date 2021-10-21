Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E6C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D3F6109F
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJUHdd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:33:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:37210 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhJUHdb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 03:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634801475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1C1ANJrhmvuRwyNH8s5matQgRAguQSduMA1IRtatQA=;
        b=nDvopNYJmsd1eCJAsoPCN49V3VtGhC0R8JOYW9s+Afiy2Q1MbYICNFN6dBJt0jhSrv86st
        2bYUZJk72mbaKn8t3yEwj8SdwMt3fA9x5MIuhrnuULfnpoI6yjxc+5FGhhPtG7xlnTQMi9
        lbIjSSlrwa6WOIVX0VartpAPn/oBJ7s=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-IBZpTob2P_u1PL0KNBxKWg-1; Thu, 21 Oct 2021 09:31:13 +0200
X-MC-Unique: IBZpTob2P_u1PL0KNBxKWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqAty8n8ckf70PjK93FEoAhlpUw74hFakq4ZeHZo6Z0o9bSiV1i8LKbszAbtJb9o8xZFAK53FpHm3XPca2trxEsIdTqgF8g2561CeCaXnBkUNPAQjubVz+DhF7tPdVF8SXX6GjWoie7YxIUU5xTHWyXCtRe36ScTj6evhc4QsiG8mAxvMNuaiG6e9hsuAkGGs287dw/wis99EaymMliWPBLx9aTrg3HnFne/vIP2JTxwn575PICJLTnCotDfXVWrU6jAibYDh6wm9N0Yrvbjl8ee4LGqqAu8NtPN7nP/Cz8CcToCPBIoznDft4g1b6DtgMQXkzyrkVwr4TfGyzPpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1C1ANJrhmvuRwyNH8s5matQgRAguQSduMA1IRtatQA=;
 b=fbohtKC9jBRRa8nl2WUkgziFJKfC5NAXe7+nCsIX/Vci/vApvmbTWODT8sYGLX2Y1+2Mq+MOIvJPELTNaNBLQItGB/gGgC+J4D0Ii17R6qcUztDnNNrejdBHX3JyPQhHoE/FqDtEyIFFjtLoVBbuoMt8wQvnOoM4grRXVd+y02nVICHzxRyaXgIuBujbTAFJ6pK4yXuaQex7h1i+VHXrbUjI4NP15y/PDBNc+rjScmQ8ykvBRjAgBpaocb+dDuLiZ79Pgtlm8jO5C/SRp6p/tnXg4qzyPzyk/tPJ8y2q5zjtOkJoq3KKUetMZjG8uPkMO9cXoo1Izv9F3rXaJNrWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB3247.eurprd04.prod.outlook.com (2603:10a6:802:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 21 Oct
 2021 07:31:11 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:31:11 +0000
Date:   Thu, 21 Oct 2021 15:30:56 +0800
From:   Chester Lin <clin@suse.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, s32@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [RFC PATCH 2/3] mmc: sdhci-esdhc-imx: add NXP S32G2 support
Message-ID: <YXEXMGGiVOiLZ0H9@linux-8mug>
References: <20211021071333.32485-1-clin@suse.com>
 <20211021071333.32485-3-clin@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021071333.32485-3-clin@suse.com>
X-ClientProxiedBy: AM5PR1001CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::35) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from linux-8mug (118.166.56.207) by AM5PR1001CA0058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 07:31:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ab3c34-d751-4114-dd0b-08d99464c17e
X-MS-TrafficTypeDiagnostic: VI1PR04MB3247:
X-Microsoft-Antispam-PRVS: <VI1PR04MB32479925B30BEE0173B1BAF1ADBF9@VI1PR04MB3247.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+yB+Uq0TuT1NEvKiUkkARU73zY1xPqm/6rTTyuYzdq5edV+tNTqPDU1uE3gdOKKhCDL4Tqx5sbJyJdzvtT2BKvcibxedMJB8oQzKxLccn1NQCn4wAwRNRsgPsswJ96Yh1sbtT7dJDk/CQdaedUatGPCLU4ZO3A26he0r8Vp6IDtWPSdEuvBL+ar4o3nd4DsR04D+HxSV/RRSdwLkEGeACqZ7nFfHJaT6vs0luZbcGzWLmYMaSdm3rYhjEqbmE3/Dgt5JEW2sHyASwbqXVZVIANy/DmrCrbDzgM7HTfKR2Dp2CGOiqFi2v099K14RomfEUYUk5N78NPgfetR3BrlaAsjL31XBEzsCehe4LDeKrS+chDbFakIUwRmYsihvqXuYyPQkCs8sGI5Oz9r/PTKcyFMJ3ayPnPZDbUs2m0L3CcwV0mUSYBOG64uw4KnJwlXaHqCua0xxdz6FMdhas4kOW0sRM602aONMFeO/npGTDAU5gfrVlq4Ivql2P2JZxhSc/9EmKwOVA2oTLQC/O8FtLgoykCxFoq7RWybqRNCv4pFJDCgxz5yvYrMXQHlJYyInS84P9eUpczgc5ZMraj4840jgJxyesK2jtPD7mIhEVYAdPbQtRBxuYiaIwSw3/TC/jbdLy8Zm7oHnvK1N/ZOpZGoK70ZdXS8LjQH4n4oUpeUlapWZzQ8B9s1dg0t2ErxZulwGZAz3LAIVTms0MrigBKjMVR1xXHk7d09ofZyG7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(2906002)(956004)(8936002)(6496006)(5660300002)(33716001)(66476007)(66556008)(38100700002)(8676002)(83380400001)(54906003)(4326008)(26005)(55016002)(9686003)(66946007)(107886003)(186003)(86362001)(55236004)(316002)(110136005)(508600001)(966005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdGO59uh74nCv+X3wMxwE5dHN78Vm8zVpWClitev8cg4q+9N47qrxzinf2yM?=
 =?us-ascii?Q?4A3zYxmKxxv8bQYs0K+v60nWJM05LWt+D4mCz8E2jBJqS9GIp9hVBLVBp3SK?=
 =?us-ascii?Q?R7HzSAvE4h8uRSVr3KxdlPYpHzjXoiEaxrJOup1/8VFry4iduhnGyFd3FNB7?=
 =?us-ascii?Q?p5DC8yuQVNw8vWQOzB3JdCoq8HZFkj15ykPkzuo8P68Nxd/Fm/FpyhAzX6TJ?=
 =?us-ascii?Q?lyQu9Zl4oDICbZuZEQdtGxZCvZJIeDPBsbmLVFxz9+ulo/jgapFAhmVq/aFc?=
 =?us-ascii?Q?0SHgGkqD1hGUYLS/TSqmBuVlv1UqdUwqyk6d3xY37bBBkmwnoqajLlHQf2OE?=
 =?us-ascii?Q?pROqOO8odABv3S70ckGwW28ZZ+LqQ3tjka+a+0iZTKRcVstIJ1RcMZBOF+FB?=
 =?us-ascii?Q?i7DTlbywde9YMFZFRtlOKfhQbz2A+JcokRAIeYP3dKvinF8bXAxdgzNqoLlz?=
 =?us-ascii?Q?518FGSS5rM8HF9ckWufZ5X9H91kuVUtBugReEb9VHaPv8pyv3cnF+FBhyAmW?=
 =?us-ascii?Q?jbK5egThTW3VfF2w1DepXjB0Mu9mbWIgEqFCrOuNLoN1qkdQ50sbljdyIwr2?=
 =?us-ascii?Q?SSbq8Egv5h2iLXHbGYInFa9VmW4d9k/MVhOCCESh5z1yeh+YqjJ/UlYYa/d+?=
 =?us-ascii?Q?BUG3pxZ5yAfwfGY64n196/vciz6HdgAj6CIqRut5Q+qrDohAWb1BE4kr5mZe?=
 =?us-ascii?Q?5q1izHyIcvcY5hHHIGTzIsH+LfRQBN0ZrspA2TCSnwI75ZPdGZvoMXP6rSXu?=
 =?us-ascii?Q?vJeBp5KFQOyTH7bSxHI5eHpb+Fc68HBQbHNn0CPKy5SDrln9BkatQIcFwWmC?=
 =?us-ascii?Q?uLa2H6tSNxr8w0xC7EXJDnius+LhYZa5mVqobkHeek9mSovdCyDCZkJw7egn?=
 =?us-ascii?Q?6LSM/inMxcz/dNGfhLldyQqqqSN5qw/7ioK4rhTrhCD1XU9z8KgPO8u5Lomw?=
 =?us-ascii?Q?6A7/KzoiVNNKEtA6GiaFO6pb4dbROHh0b4iRKhiszDuSiftIMyUc4tC6QvJs?=
 =?us-ascii?Q?mG5/7YBVF2RnUJkczn1YA3o4Y9gLuFLGsDsDNtsQppYZzz3qpqAyKnFR7gbV?=
 =?us-ascii?Q?KDB91j9pDsLYv/1weZAPKX6wH/htzpvUdsvHUW+iyo9mdFMi4P5OLwDaoptb?=
 =?us-ascii?Q?Futu17IT4/ectsZfQ/bNiB75F+0V0pH+Np2qO3uEmBaVVGTAfyxyUckDoEDw?=
 =?us-ascii?Q?Mpdjudzgkv9xg71m1xBZU9jXDAquohYSK99wQNW7xBsb62tYCi86Jsb87TKG?=
 =?us-ascii?Q?gOYWfBqU0UNhwU2kup8ev597HhVCofJxxydb/W0PaVFBoRNMHj9YtmI/7tIk?=
 =?us-ascii?Q?wa61sZwEGfk3LGb61xTgQa3d?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ab3c34-d751-4114-dd0b-08d99464c17e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:31:11.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3247
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi NXP S32 and i.MX Linux teams,

On Thu, Oct 21, 2021 at 03:13:32PM +0800, Chester Lin wrote:
> Support the SDHCI controller found on NXP S32G2 platform. The new flag
> ESDHC_FLAG_SKIP_ERR004536 is used because the hardware erratum bit is not
> applicable for S32G2.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f18d169bc8ff..d0f7d46a0354 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -196,6 +196,9 @@
>   */
>  #define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
>  
> +/* ERR004536 is not applicable for the IP  */
> +#define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
> +
>  enum wp_types {
>  	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
>  	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
> @@ -289,6 +292,13 @@ static const struct esdhc_soc_data usdhc_imx7d_data = {
>  			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
> +static struct esdhc_soc_data usdhc_s32g2_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> +			| ESDHC_FLAG_SKIP_ERR004536,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -347,6 +357,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
>  	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
>  	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
> +	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
> @@ -1359,8 +1370,10 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
>  		 * TO1.1, it's harmless for MX6SL
>  		 */
> -		writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> -			host->ioaddr + 0x6c);
> +		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_ERR004536)) {
> +			writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
> +				host->ioaddr + 0x6c);
> +		}

Hope you don't might that I raise this question here. Is it really necessary
to unconditionally apply the erratum bit even if some SoCs might not need this
workaround? From the S32 implementation in CodeAurora[1], I noticed that this
bit is not required by S32V/S32G so I wonder if there's any better way to
refine this part?

Thanks,
Chester

[1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/mmc/host/sdhci-esdhc-imx.c?h=release/bsp30.0-5.4-rt#n1268

>  
>  		/* disable DLL_CTRL delay line settings */
>  		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> -- 
> 2.30.0
> 

