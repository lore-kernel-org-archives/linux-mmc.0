From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Wed, 12 Aug 2015 16:50:39 +0200
Message-ID: <1539991.LpcThZV47z@wuerfel>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 11 August 2015 14:48:34 Geert Uytterhoeven wrote:
>         dma_cap_mask_t mask;
> @@ -413,12 +413,11 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
>         dma_cap_set(DMA_SLAVE, mask);
>  
>         if (pdata)
> -               slave_data = direction == DMA_MEM_TO_DEV ?
> -                       (void *)pdata->slave_id_tx :
> -                       (void *)pdata->slave_id_rx;
> +               slave_id = direction == DMA_MEM_TO_DEV ?
> +                       pdata->slave_id_tx : pdata->slave_id_rx;
>  
>         chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> -                               slave_data, dev,
> +                               (void *)(uintptr_t)slave_id, dev,
>                                 direction == DMA_MEM_TO_DEV ? "tx" : "rx");
>  
>         dev_dbg(dev, "%s: %s: got channel %p\n", __func__,

How about changing the type of the slave_id_rx/slave_id_tx fields 
to void*? That way, the hack can be moved to arch/sh/boards/board-sh7757lcr.c,
which is now the only file passing data this way. Ideally, we'd also
pass the shdma_chan_filter function pointer in pdata to avoid the link
time dependency on a particular dmaengine driver.

	Arnd
