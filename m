From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Correct TX DMA channel allocation
Date: Wed, 10 Feb 2016 15:33:34 +0100
Message-ID: <CAPDyKFoNGH2e5qJ=YBZOOzxT_qbv0nK+Aok=hPRw8O892tus8g@mail.gmail.com>
References: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36753 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcBJOdf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 09:33:35 -0500
Received: by mail-yk0-f181.google.com with SMTP id z7so8103756yka.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2016 06:33:35 -0800 (PST)
In-Reply-To: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kouichi Tomita <kouichi.tomita.yn@renesas.com>, takeshi.kihara.df@renesas.com, koji.matsuoka.xm@renesas.com

On 10 February 2016 at 15:07, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> Commit 27cbd7e815a8 ("mmc: sh_mmcif: rework dma channel handling")
> introduced a typo causing the TX DMA channel allocation to be overwritten
> by the requested RX DMA channel.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Thanks, applied for fixes and I also added a corresponding fixes tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mmcif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index e0c076a..8d870ce 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -445,7 +445,7 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host)
>                                                         pdata->slave_id_rx);
>         } else {
>                 host->chan_tx = dma_request_slave_channel(dev, "tx");
> -               host->chan_tx = dma_request_slave_channel(dev, "rx");
> +               host->chan_rx = dma_request_slave_channel(dev, "rx");
>         }
>         dev_dbg(dev, "%s: got channel TX %p RX %p\n", __func__, host->chan_tx,
>                 host->chan_rx);
> --
> 1.9.1
>
