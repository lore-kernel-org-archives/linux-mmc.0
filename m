From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] mmc: sunxi-mmc: change idma descriptor to __le32
Date: Mon, 22 Aug 2016 15:38:42 +0200
Message-ID: <CAPDyKFrk4RGHHG-aHEJ5ZbQoL2W_tu=x1MPcxTjr2kpNvfH7KQ@mail.gmail.com>
References: <20160802193115.850-1-michael.weiser@gmx.de> <20160802193115.850-2-michael.weiser@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38728 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbcHVNio (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:38:44 -0400
Received: by mail-wm0-f48.google.com with SMTP id o80so144677326wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:38:44 -0700 (PDT)
In-Reply-To: <20160802193115.850-2-michael.weiser@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Weiser <michael.weiser@gmx.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 August 2016 at 21:31, Michael Weiser <michael.weiser@gmx.de> wrote:
> The sunxi-mmc driver does not take into account the processor may be big
> endian when writing the DMA descriptors. This causes cards not to be
> detected when running a big-endian kernel. Change the descriptors for
> IDMA to use __le32 and ensure they are suitably swapped before writing.
> Tested successfully on the Cubieboard2.
>
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This doesn't apply as I have queued some other sunxi changes. Could
you please re-spin a new version.

Kind regards
Uffe

> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sunxi-mmc.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ee4c21..1e6df8a 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -223,10 +223,10 @@ struct sunxi_mmc_clk_delay {
>  };
>
>  struct sunxi_idma_des {
> -       u32     config;
> -       u32     buf_size;
> -       u32     buf_addr_ptr1;
> -       u32     buf_addr_ptr2;
> +       __le32 config;
> +       __le32 buf_size;
> +       __le32 buf_addr_ptr1;
> +       __le32 buf_addr_ptr2;
>  };
>
>  struct sunxi_mmc_host {
> @@ -325,22 +325,25 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>         int i, max_len = (1 << host->idma_des_size_bits);
>
>         for (i = 0; i < data->sg_len; i++) {
> -               pdes[i].config = SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
> -                                SDXC_IDMAC_DES0_DIC;
> +               pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
> +                                            SDXC_IDMAC_DES0_OWN |
> +                                            SDXC_IDMAC_DES0_DIC);
>
>                 if (data->sg[i].length == max_len)
>                         pdes[i].buf_size = 0; /* 0 == max_len */
>                 else
> -                       pdes[i].buf_size = data->sg[i].length;
> +                       pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
>
>                 next_desc += sizeof(struct sunxi_idma_des);
> -               pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
> -               pdes[i].buf_addr_ptr2 = (u32)next_desc;
> +               pdes[i].buf_addr_ptr1 =
> +                       cpu_to_le32(sg_dma_address(&data->sg[i]));
> +               pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
>         }
>
> -       pdes[0].config |= SDXC_IDMAC_DES0_FD;
> -       pdes[i - 1].config |= SDXC_IDMAC_DES0_LD | SDXC_IDMAC_DES0_ER;
> -       pdes[i - 1].config &= ~SDXC_IDMAC_DES0_DIC;
> +       pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> +       pdes[i - 1].config |= cpu_to_le32(SDXC_IDMAC_DES0_LD |
> +                                         SDXC_IDMAC_DES0_ER);
> +       pdes[i - 1].config &= cpu_to_le32(~SDXC_IDMAC_DES0_DIC);
>         pdes[i - 1].buf_addr_ptr2 = 0;
>
>         /*
> --
> 2.9.2
>
