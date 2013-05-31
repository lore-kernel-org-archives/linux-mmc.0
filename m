From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] dmaengine: shdma: fix a build failure on platforms with no DMA support
Date: Fri, 31 May 2013 16:51:52 +0200
Message-ID: <3410825.gK3KBC8v80@wuerfel>
References: <Pine.LNX.4.64.1305310423360.1470@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1305310423360.1470@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 31 May 2013 05:01:31 Guennadi Liakhovetski wrote:
> On platforms with no support for the shdma dmaengine driver build is
> currently failing with
> 
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
> 
> Fix the breakage by defining shdma_chan_filter to NULL in such
> configurations.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Sorry, I saw your patch too late and already spent some time doing a different one.

> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index b64d6be..1fd8a20 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -99,6 +99,10 @@ struct sh_dmae_pdata {
>  #define CHCR_TE        0x00000002
>  #define CHCR_IE        0x00000004
>  
> +#if IS_ENABLED(CONFIG_SH_DMAE_BASE)
>  bool shdma_chan_filter(struct dma_chan *chan, void *arg);
> +#else
> +#define shdma_chan_filter NULL
> +#endif

I still think that this is not the right solution, or at least not
complete: No slave driver should care about which dma-engine it is
connected to. You have already done most of the necessary conversion,
so it would be straightforward to also pass the filter function
pointer to the sdhi driver along with the data that gets passed into
it.

	Arnd
