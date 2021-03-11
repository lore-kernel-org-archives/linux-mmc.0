Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276FEC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CED64FBB
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 07:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCKG7t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 01:59:49 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:17376
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229731AbhCKG7g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 01:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAxR0M98FSvBoRn5fT+cK4HzRWFyT2+c+YYXl/3fiw0NfDPyb4mUqCwMh1IIHi1NhWPR42bA7pl8Z1serjAny+AZ8Y/zE85NmKDjjdtcd25YQt/TVtiR5XN2S/v5G7V9u4kMEUjrzGFh9aSgFFDYtOpIN+g/zH0O0vM0XQshjyFuT/CxAlseqT3dTSPPBk4UlNraETfTSRBMjGfj5dgTnpNZU3z5rjeW7gagRBKamGvfxesrfXGKZhFERzp1vmdeyrW8wJRrF2E1DQGWfYEVJlJ2l7Yd+2+Nuu6nfkKvI+kYhLO+BzSIbCr+aN0N5eAKtqpOhbUvf7kqjZTYix+vFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87ABeefLpuFTjpRVg1gJUFx5ObvM7vCh01v1Q2w8s7Y=;
 b=XwWYmtkyUKpLxrGLm19u9HeOnqgoJiqcJ53vT3k1dtG5tER/C42/K4onOBWTnqbIl3Svy7P2x1EbLFJJjPRyjzPQt8qYEHWe3hC/VZn/kfFbpb5GUEKMqNFIUreCu3IoTbOdIXK0bQAPWPaT8K7CDy6GVHXA24jsRa0aYO7KZEdv7QWMHlwD71xDsMonrtWAmMk54d1B/qTqtDF1Z70sthIrQSh+vMo1qadfnH3InsbD8UK/6+d5/hCfnzz/fpi4Dw2Avbis1yTEDP8+BsdpujdJv5NkPKJ8NkzC96blLkfY2Oi2UGZu9ME/XOdIGs9xNF23+ClnjNfg9kywepcY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87ABeefLpuFTjpRVg1gJUFx5ObvM7vCh01v1Q2w8s7Y=;
 b=GqzJKMkOYgZ3NqWb7sFzrXlc6j8zjOWzfPY9WndYPl8H4xPL+OV34/oU2RBgPSzNt2PyHmhoaLtnDwzCGadECUsHyjwwMPK9yPYVN1m6gfhqoJshb1YBCDi5gHUq1pRxFVjSRLySnR1MUnyESTdtuL8lc9Z/jqMK+oFfIQ8T5OY=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN6PR03MB2628.namprd03.prod.outlook.com
 (2603:10b6:404:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Thu, 11 Mar
 2021 06:59:34 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 06:59:34 +0000
Date:   Thu, 11 Mar 2021 14:59:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform
 support
Message-ID: <20210311145924.498c690a@xhacker.debian>
In-Reply-To: <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
References: <1615443684-198078-1-git-send-email-shawn.lin@rock-chips.com>
        <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 06:59:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb95880c-bdf2-453c-882c-08d8e45b39f7
X-MS-TrafficTypeDiagnostic: BN6PR03MB2628:
X-Microsoft-Antispam-PRVS: <BN6PR03MB262888BBA574E7572002CAC2ED909@BN6PR03MB2628.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xY56VZIfQuD5K11466i49GrtyuYb+In60qyTA9BRZJvw2DSGnxDsDysGwxGYFAQ6rO1Rn4lB1nU/IIKxKw/vkTjDXuqCmjmH42zVH8U16LkvAnCLTuf5aNORA4axBaLDXH4XyS8Kb/jr3CY7HUzNHrnYhKwR+X+hUr+ACsvN7/okp/wsgMPHibu9641omuXzXGEn7FqsJwJeC7QTfmXN6FqJCbv4hmxRRDIjnm7YDnJw9DyHEH5Q3Pte8lZY5x0GhOrXtT7z3qav9bfoFyeeCxZIqs4+TLQci2xg+3z3eNO92tC3pJBVOPXiPTd1LGFhrdFRRQlixYa9xxINOqXkA+w5jghv6dIGsRxFICehNVGnr9FpjqiXlp+xtbyovLPOiQ2B52G00QmzfIY0ZBZ7WCsvMgwP/Nb7KOQxYgGj9d3r8y5y4bhvX3QdE+acmCywIny8ZCsfSK5Ka+vkif9t75MZD/oiTsEmXlBEo/39dkNbZ8IXcSsPW8Yp72U5Hl8Akx/xCNEzN7sIyyPUP9mAgX0wo5wCHAS5Y8cFm5NXVulDJiaGUy7Er1nVaF55/S3FSg9pslvj/L39Nv0+69TNKalS+DxcnEuWSW6G0L+fRkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39850400004)(346002)(316002)(8936002)(16526019)(2906002)(6506007)(1076003)(478600001)(186003)(54906003)(86362001)(6666004)(956004)(26005)(6916009)(8676002)(5660300002)(7696005)(52116002)(9686003)(55016002)(83380400001)(30864003)(66946007)(4326008)(66556008)(66476007)(133343001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NUgm5BSuaolH+4Xt6rbSB4/PzX8AqJZQq+qzdYr/UUqY6swfDh9nwHcj3II2?=
 =?us-ascii?Q?IXAk4XLdP2jJVONX9X4UUTpwJpF2JUD3eTzsQsIE0aEY+Ary+bsw91y0px8G?=
 =?us-ascii?Q?rgCgwoJdIcT4az0MSYBafeUFgUVJX1DSo+rrEaDlVxKWAFTx4v7DkXSvqcHh?=
 =?us-ascii?Q?oexlo5m/uiarWafeKr6CsXseQdT4ijQGEIiiaDZ7WXrWXcPhhD6jplboY2LM?=
 =?us-ascii?Q?pAuQ1QBfCdONUJdfVqU7oV94uM3DoXIkAIye8yq5FvGRgUTyNSmnCJ54b9tB?=
 =?us-ascii?Q?RjQoXcBdzdjC2E7l4qLMC3CS3TI8jVsg4AoylyuIDj5eBojZ588GjWafzFd4?=
 =?us-ascii?Q?QCQMu1l8daMplY1wbY1+zSzsGZoA/wGBLN+elFo4uwI51pxVcsKNkWqwcJp4?=
 =?us-ascii?Q?rhzXMu5EY3igyWGMALaz74imPZatr+HFvEag1W+2eGyu6VVIIHUFrqJhtHIE?=
 =?us-ascii?Q?GrbTSZsPs7p6EgoG80Flx5x9lssk9Fqv1H7BhiHd+4POnoM8nnRR/gDXLE0x?=
 =?us-ascii?Q?6/Ajj83Wc1kLPDKHHQIHcc823Cn+h+KCYptXTJg5QyJdXoDaLxEMAKpmCV3o?=
 =?us-ascii?Q?HFA5OvdsgywQ6OpTQrQkr/qRf3oC7bVsbrlmx0ASfZtKElxyQ7F4j802PD3g?=
 =?us-ascii?Q?LiWEG0WwvvfvegQt8ZzPyXsJ3L/36tX9zsCtd1hzI9ESp8cHxjMHaziT7Y0J?=
 =?us-ascii?Q?HOI/VCrS4bWEpj1yadHI/s75AauOTq0Yul83qEhiLoLX727EpGi6kgd0WZmt?=
 =?us-ascii?Q?IB3ZeI1S0zBSb2yBrd+Tpt7hOPtoyBGTgp0Q6QAmj9LiektW84zYIyKzeteV?=
 =?us-ascii?Q?u6Zr5o8nHA9szllUOqzgM9jUnEQkTZabHmaUnEb9G6f7if0JGT/PoCFdSApj?=
 =?us-ascii?Q?6Q0+aUEWrXURvvpz35vBmnI7trNJuwhGJTAzojNP0CthhRa3uqqybmq8LLd0?=
 =?us-ascii?Q?Lxhc5Lz84B02z7yPu6fCWw4c9LN97D/k9mfYyPGQehELlwVtXxGa/z0e3hCq?=
 =?us-ascii?Q?5tg/vnA4L+imXDlNfsrI8ZgwN7+g9OSI/JSXCWeI9cokF4uBVBgBtMuaA2mx?=
 =?us-ascii?Q?pQPdAIqh+gfj0rvVc2ovBf1lONjWTTW9yZFcYl1He6Yc5R1+HomPg0NY5cKI?=
 =?us-ascii?Q?hCRaQ/tNZ4j/6ShH/5MIWo2cbpoKkYyV4DSMtq+nJ7uPl3iFA6NpOZhyIZnw?=
 =?us-ascii?Q?KpV4OZg7hX8RnMdiJqwWWwt6JjV7U/DfQdW0OYBcQL3eknpTF6QmlkKk+c8P?=
 =?us-ascii?Q?oLI+mA64Ocd6Zc2sWdIErcVAnkoH6p092dGVcohu1i609j2PLIqQk8sJ8N1H?=
 =?us-ascii?Q?urSNCO8YkyBNQ/9D5Ev2BOJW?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95880c-bdf2-453c-882c-08d8e45b39f7
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 06:59:34.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Q8kvtoBHX44joQGy6hNoO83cRvd1UDVn/CKnPQiAnmrU04g/duNRCa6w3ClSwx3LzQ2YKrnDf0YufAxDVLzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2628
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

On Thu, 11 Mar 2021 14:21:24 +0800 Shawn Lin <shawn.lin@rock-chips.com> wrote:

> 
> sdhci based synopsys MMC IP is also used on some rockchip platforms,
> so add a basic support here.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> Changes in v4:
> - add comments for disabling rx invert
> - add tag from Adrian
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 225 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 218 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 59d8d96..dabc1ec 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -9,9 +9,11 @@
> 
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/sizes.h>
> 
>  #include "sdhci-pltfm.h"
> @@ -21,11 +23,43 @@
>  /* DWCMSHC specific Mode Select value */
>  #define DWCMSHC_CTRL_HS400             0x7
> 
> +/* Rockchip specific Registers */
> +#define DWCMSHC_HOST_CTRL3             0x508

Maybe 0x500 can be read from VENDOR_PTR_R while 0x8 is the offset?

> +#define DWCMSHC_EMMC_CONTROL           0x52c
> +#define DWCMSHC_EMMC_ATCTRL            0x540
> +#define DWCMSHC_EMMC_DLL_CTRL          0x800

Maybe 0x800 is phy offset? while 0, 4, 8 etc. below are phy registers?

> +#define DWCMSHC_EMMC_DLL_RXCLK         0x804
> +#define DWCMSHC_EMMC_DLL_TXCLK         0x808
> +#define DWCMSHC_EMMC_DLL_STRBIN                0x80c
> +#define DWCMSHC_EMMC_DLL_STATUS0       0x840
> +#define DWCMSHC_EMMC_DLL_START         BIT(0)
> +#define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL  29
> +#define DWCMSHC_EMMC_DLL_START_POINT   16
> +#define DWCMSHC_EMMC_DLL_INC           8
> +#define DWCMSHC_EMMC_DLL_DLYENA                BIT(27)
> +#define DLL_TXCLK_TAPNUM_DEFAULT       0x8
> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
> +#define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
> +#define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
> +#define DWCMSHC_EMMC_DLL_LOCKED                BIT(8)
> +#define DWCMSHC_EMMC_DLL_TIMEOUT       BIT(9)
> +#define DLL_RXCLK_NO_INVERTER          1
> +#define DLL_RXCLK_INVERTER             0
> +#define DWCMSHC_ENHANCED_STROBE                BIT(8)

Is it better to let bits' definition grouped with register together, e.g this
definition could be moved to the corresponding CONTROL register MACRO

> +#define DLL_LOCK_WO_TMOUT(x) \
> +       ((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
> +       (((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> +#define ROCKCHIP_MAX_CLKS              3
> +
>  #define BOUNDARY_OK(addr, len) \
>         ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> 
>  struct dwcmshc_priv {
>         struct clk      *bus_clk;
> +
> +       /* Rockchip specified optional clocks */
> +       struct clk_bulk_data rockchip_clks[ROCKCHIP_MAX_CLKS];
> +       u8 txclk_tapnum;
>  };
> 
>  /*
> @@ -100,6 +134,102 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
> 
> +static void dwcmshc_rk_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
> +{
> +       u32 vendor;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       vendor = sdhci_readl(host, DWCMSHC_EMMC_CONTROL);
> +       if (ios->enhanced_strobe)
> +               vendor |= DWCMSHC_ENHANCED_STROBE;
> +       else
> +               vendor &= ~DWCMSHC_ENHANCED_STROBE;
> +
> +       sdhci_writel(host, vendor, DWCMSHC_EMMC_CONTROL);
> +}
> +
> +static void dwcmshc_rk_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +       u32 extra;
> +       int err;
> +
> +       host->mmc->actual_clock = 0;
> +
> +       /*
> +        * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
> +        * by default, but it shouldn't be enabled. We should anyway
> +        * disable it before issuing any cmds.
> +        */
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> +
> +       if (clock == 0)
> +               return;
> +
> +       /* Rockchip platform only support 375KHz for identify mode */
> +       if (clock <= 400000)
> +               clock = 375000;
> +
> +       err = clk_set_rate(pltfm_host->clk, clock);
> +       if (err)
> +               dev_err(mmc_dev(host->mmc), "fail to set clock %d", clock);
> +
> +       sdhci_set_clock(host, clock);
> +
> +       /* Disable cmd conflict check */
> +       extra = sdhci_readl(host, DWCMSHC_HOST_CTRL3);
> +       extra &= ~BIT(0);
> +       sdhci_writel(host, extra, DWCMSHC_HOST_CTRL3);
> +
> +       if (clock <= 400000) {
> +               /* Disable DLL to reset sample clock */
> +               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> +               return;
> +       }
> +
> +       /* Reset DLL */
> +       sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
> +       udelay(1);
> +       sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
> +
> +       /* Init DLL settings */
> +       extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
> +               0x2 << DWCMSHC_EMMC_DLL_INC |
> +               DWCMSHC_EMMC_DLL_START;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CTRL);
> +       err = readl_poll_timeout(host->ioaddr + DWCMSHC_EMMC_DLL_STATUS0,
> +                                extra, DLL_LOCK_WO_TMOUT(extra), 1,
> +                                500 * USEC_PER_MSEC);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> +               return;
> +       }
> +
> +       extra = 0x1 << 16 | /* tune clock stop en */
> +               0x2 << 17 | /* pre-change delay */
> +               0x3 << 19;  /* post-change delay */
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_ATCTRL);
> +
> +       if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
> +               txclk_tapnum = priv->txclk_tapnum;
> +
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_TXCLK_TAPNUM_FROM_SW |
> +               txclk_tapnum;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
> +
> +       extra = DWCMSHC_EMMC_DLL_DLYENA |
> +               DLL_STRBIN_TAPNUM_DEFAULT |
> +               DLL_STRBIN_TAPNUM_FROM_SW;
> +       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -109,21 +239,91 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
> 
> +static const struct sdhci_ops sdhci_dwcmshc_rk_ops = {
> +       .set_clock              = dwcmshc_rk_set_clock,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> +       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .reset                  = sdhci_reset,
> +       .adma_write_desc        = dwcmshc_adma_write_desc,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .ops = &sdhci_dwcmshc_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
> 
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk_pdata = {
> +       .ops = &sdhci_dwcmshc_rk_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +};
> +
> +static int rockchip_pltf_init(struct sdhci_host *host, struct dwcmshc_priv *priv)
> +{
> +       int err;
> +
> +       priv->rockchip_clks[0].id = "axi";
> +       priv->rockchip_clks[1].id = "block";
> +       priv->rockchip_clks[2].id = "timer";
> +       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), ROCKCHIP_MAX_CLKS,
> +                                        priv->rockchip_clks);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +               return err;
> +       }
> +
> +       err = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +               return err;
> +       }
> +
> +       if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> +                               &priv->txclk_tapnum))
> +               priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +
> +       /* Disable cmd conflict check */
> +       sdhci_writel(host, 0x0, DWCMSHC_HOST_CTRL3);
> +       /* Reset previous settings */
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +       {
> +               .compatible = "snps,dwcmshc-sdhci",
> +               .data = &sdhci_dwcmshc_pdata,
> +       },
> +       {
> +               .compatible = "rockchip,dwcmshc-sdhci",
> +               .data = &sdhci_dwcmshc_rk_pdata,
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
>  static int dwcmshc_probe(struct platform_device *pdev)
>  {
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
> +       const struct sdhci_pltfm_data *pltfm_data;
>         int err;
>         u32 extra;
> 
> -       host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +       pltfm_data = of_device_get_match_data(&pdev->dev);
> +       if (!pltfm_data) {
> +               dev_err(&pdev->dev, "Error: No device match data found\n");
> +               return -ENODEV;
> +       }
> +
> +       host = sdhci_pltfm_init(pdev, pltfm_data,
>                                 sizeof(struct dwcmshc_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
> @@ -161,6 +361,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
> 
>         host->mmc_host_ops.request = dwcmshc_request;
> 
> +       if (pltfm_data == &sdhci_dwcmshc_rk_pdata) {
> +               host->mmc_host_ops.hs400_enhanced_strobe =
> +                       dwcmshc_rk_hs400_enhanced_strobe;
> +
> +               err = rockchip_pltf_init(host, priv);
> +               if (err)
> +                       goto err_clk;
> +       }
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto err_clk;
> @@ -170,6 +379,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
>  free_pltfm:
>         sdhci_pltfm_free(pdev);
>         return err;
> @@ -185,6 +395,7 @@ static int dwcmshc_remove(struct platform_device *pdev)
> 
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> 
>         sdhci_pltfm_free(pdev);
> 
> @@ -207,6 +418,8 @@ static int dwcmshc_suspend(struct device *dev)
>         if (!IS_ERR(priv->bus_clk))
>                 clk_disable_unprepare(priv->bus_clk);
> 
> +       clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +
>         return ret;
>  }
> 
> @@ -227,18 +440,16 @@ static int dwcmshc_resume(struct device *dev)
>                         return ret;
>         }
> 
> +       ret = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +       if (ret)
> +               return ret;
> +
>         return sdhci_resume_host(host);
>  }
>  #endif
> 
>  static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> 
> -static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> -       { .compatible = "snps,dwcmshc-sdhci" },
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> -
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
>                 .name   = "sdhci-dwcmshc",
> --
> 2.7.4
> 
> 
> 

