From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 03/11] mmc: sh_mmcif: Configure DMA slave bus width
Date: Sat, 26 Jul 2014 11:40:40 +0200
Message-ID: <CAPDyKFoG+MjPTWQg2d96BDL45Bu6fRPRHJBHqUoQv88SC59Vzw@mail.gmail.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1405464321-4723-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:45680 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaGZJkk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jul 2014 05:40:40 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so6217532qge.32
        for <linux-mmc@vger.kernel.org>; Sat, 26 Jul 2014 02:40:40 -0700 (PDT)
In-Reply-To: <1405464321-4723-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

On 16 July 2014 00:45, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The data register is 4 bytes wide, hardcode the DMA transfer size to
> 4 bytes in both directions.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 436d663..cc8ae09 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -418,10 +418,13 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
>         cfg.slave_id = slave_id;
>         cfg.direction = direction;
>
> -       if (direction == DMA_DEV_TO_MEM)
> +       if (direction == DMA_DEV_TO_MEM) {
>                 cfg.src_addr = res->start + MMCIF_CE_DATA;
> -       else
> +               cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       } else {
>                 cfg.dst_addr = res->start + MMCIF_CE_DATA;
> +               cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       }
>
>         ret = dmaengine_slave_config(chan, &cfg);
>         if (ret < 0) {
> --
> 1.8.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
