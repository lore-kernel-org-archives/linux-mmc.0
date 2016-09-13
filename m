From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Tue, 13 Sep 2016 14:57:42 +0200
Message-ID: <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com> <20160912141507.6837-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33728 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755330AbcIMM5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2016 08:57:45 -0400
Received: by mail-wm0-f42.google.com with SMTP id b187so16743483wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Sep 2016 05:57:45 -0700 (PDT)
In-Reply-To: <20160912141507.6837-2-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 12 September 2016 at 16:15, Chris Brandt <chris.brandt@renesas.com> wrote:
> In moving platforms from board files to DT, there still needs to be a way
> to set the ocr_mask setting for the tmio driver during probe. Without this
> setting, the probe will fail because the supported voltages are not known.

Regarding the ocr_mask; How do these SoCs provides the power to the mmc/sd card?

Do note, I am *not* talking about the I/O voltage but the core power
to the card.

The reason for raising the question is that we have infrastructures in
the mmc core which can create the ocr_mask, by parsing a regulator's
voltage range. This is the recommended method to use, instead of using
hard coded ocr mask values.

Kind regards
Uffe

>
> This patch will also traditional platform registration platforms to
> migrate to DT.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 5334f24..b033500 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -59,6 +59,7 @@ enum tmio_mmc_dmac_type {
>
>  struct sh_mobile_sdhi_of_data {
>         unsigned long tmio_flags;
> +       u32           tmio_ocr_mask;
>         unsigned long capabilities;
>         unsigned long capabilities2;
>         enum dma_slave_buswidth dma_buswidth;
> @@ -630,6 +631,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
>
>                 mmc_data->flags |= of_data->tmio_flags;
> +               mmc_data->ocr_mask = of_data->tmio_ocr_mask;
>                 mmc_data->capabilities |= of_data->capabilities;
>                 mmc_data->capabilities2 |= of_data->capabilities2;
>                 mmc_data->dma_rx_offset = of_data->dma_rx_offset;
> --
> 2.9.2
>
>
