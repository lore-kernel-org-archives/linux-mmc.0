Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF960C63777
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Nov 2020 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B603322470
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Nov 2020 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgK1Vun (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:43 -0500
Received: from foss.arm.com ([217.140.110.172]:37426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387620AbgK1T5h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 28 Nov 2020 14:57:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43EFD30E;
        Sat, 28 Nov 2020 11:56:51 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0F3A3F23F;
        Sat, 28 Nov 2020 11:56:49 -0800 (PST)
Subject: Re: [RESEND PATCH 17/19] mmc: sunxi: add support for A100 mmc
 controller
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1604988979.git.frank@allwinnertech.com>
 <de4c37ee3a0f1734c4ae035c37b8a2c34b9641ca.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <65401815-cb2e-58ec-7653-f09d6a25804c@arm.com>
Date:   Sat, 28 Nov 2020 19:56:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <de4c37ee3a0f1734c4ae035c37b8a2c34b9641ca.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/11/2020 06:46, Frank Lee wrote:

Hi,

> From: Yangtao Li <frank@allwinnertech.com>
> 
> This patch adds support for A100 MMC controller, which use word address
> for internal dma.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fc62773602ec..1518b64112b7 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -244,6 +244,7 @@ struct sunxi_idma_des {
>  
>  struct sunxi_mmc_cfg {
>  	u32 idma_des_size_bits;
> +	u32 idma_des_shift;
>  	const struct sunxi_mmc_clk_delay *clk_delays;
>  
>  	/* does the IP block support autocalibration? */
> @@ -343,7 +344,7 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
>  	/* Enable CEATA support */
>  	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
>  	/* Set DMA descriptor list base address */
> -	mmc_writel(host, REG_DLBA, host->sg_dma);
> +	mmc_writel(host, REG_DLBA, host->sg_dma >> host->cfg->idma_des_shift);
>  
>  	rval = mmc_readl(host, REG_GCTRL);
>  	rval |= SDXC_INTERRUPT_ENABLE_BIT;
> @@ -373,8 +374,10 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>  
>  		next_desc += sizeof(struct sunxi_idma_des);
>  		pdes[i].buf_addr_ptr1 =
> -			cpu_to_le32(sg_dma_address(&data->sg[i]));
> -		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
> +			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
> +				    host->cfg->idma_des_shift);
> +		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
> +						    host->cfg->idma_des_shift);

I think you should cast after the shift, otherwise you lose the ability
to run above 4 GB. This won't be a problem at the moment, since we still
use the default 32-bit DMA mask, but might bite us later.

Otherwise this patch looks fine, and works on the H616 as well.

Cheers,
Andre

>  	}
>  
>  	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> @@ -1178,6 +1181,23 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
>  	.needs_new_timings = true,
>  };
>  
> +static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
> +	.idma_des_size_bits = 16,
> +	.idma_des_shift = 2,
> +	.clk_delays = NULL,
> +	.can_calibrate = true,
> +	.mask_data0 = true,
> +	.needs_new_timings = true,
> +};
> +
> +static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
> +	.idma_des_size_bits = 13,
> +	.idma_des_shift = 2,
> +	.clk_delays = NULL,
> +	.can_calibrate = true,
> +	.needs_new_timings = true,
> +};
> +
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
>  	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
> @@ -1186,6 +1206,8 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
> +	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
> +	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> 

