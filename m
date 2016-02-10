From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Correct TX DMA channel allocation
Date: Wed, 10 Feb 2016 16:36:29 +0200
Message-ID: <1505202.4RaxZJ1VUz@avalon>
References: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:50760 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcBJOgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 09:36:07 -0500
In-Reply-To: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, ykaneko0929@gmail.com, arnd@arndb.de, geert+renesas@glider.be, kouichi.tomita.yn@renesas.com, takeshi.kihara.df@renesas.com, koji.matsuoka.xm@renesas.com

Hi Chris,

Thank you for the patch.

On Wednesday 10 February 2016 14:07:01 Chris Paterson wrote:
> Commit 27cbd7e815a8 ("mmc: sh_mmcif: rework dma channel handling")
> introduced a typo causing the TX DMA channel allocation to be overwritten
> by the requested RX DMA channel.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mmc/host/sh_mmcif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index e0c076a..8d870ce 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -445,7 +445,7 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host
> *host) pdata->slave_id_rx);
>  	} else {
>  		host->chan_tx = dma_request_slave_channel(dev, "tx");
> -		host->chan_tx = dma_request_slave_channel(dev, "rx");
> +		host->chan_rx = dma_request_slave_channel(dev, "rx");
>  	}
>  	dev_dbg(dev, "%s: got channel TX %p RX %p\n", __func__, host->chan_tx,
>  		host->chan_rx);

-- 
Regards,

Laurent Pinchart

