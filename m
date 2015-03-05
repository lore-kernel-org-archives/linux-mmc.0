From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: avoid invalid pointer calculation
Date: Thu, 5 Mar 2015 14:51:02 +0100
Message-ID: <CAPDyKFq-V4egasTCgu3O7am_ur2Z8taq4VJHgqaMjAYOR7upLQ@mail.gmail.com>
References: <27509084.spYfayGTeo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:40705 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbCENvD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:51:03 -0500
Received: by qcvs11 with SMTP id s11so8895648qcv.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 05:51:02 -0800 (PST)
In-Reply-To: <27509084.spYfayGTeo@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Lanzendoerfer <david.lanzendoerfer@o2s.ch>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On 24 February 2015 at 10:47, Arnd Bergmann <arnd@arndb.de> wrote:
> The sunxi mmc driver tries to calculate a dma address by using pointer
> arithmetic, which causes a warning when dma_addr_t is wider than a pointer:
>
> drivers/mmc/host/sunxi-mmc.c: In function 'sunxi_mmc_init_idma_des':
> drivers/mmc/host/sunxi-mmc.c:296:35: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   struct sunxi_idma_des *pdes_pa = (struct sunxi_idma_des *)host->sg_dma;
>                                    ^
>
> To avoid this warning and to simplify the logic, this changes
> the code to avoid the cast and calculate the correct address
> manually. The behavior should be unchanged.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e8a4218b5726..c326ac965806 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -293,7 +293,7 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                                     struct mmc_data *data)
>  {
>         struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
> -       struct sunxi_idma_des *pdes_pa = (struct sunxi_idma_des *)host->sg_dma;
> +       dma_addr_t next_desc = host->sg_dma;
>         int i, max_len = (1 << host->idma_des_size_bits);
>
>         for (i = 0; i < data->sg_len; i++) {
> @@ -305,8 +305,9 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                 else
>                         pdes[i].buf_size = data->sg[i].length;
>
> +               next_desc += sizeof(struct sunxi_idma_des);
>                 pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
> -               pdes[i].buf_addr_ptr2 = (u32)&pdes_pa[i + 1];
> +               pdes[i].buf_addr_ptr2 = (u32)next_desc;
>         }
>
>         pdes[0].config |= SDXC_IDMAC_DES0_FD;
>
