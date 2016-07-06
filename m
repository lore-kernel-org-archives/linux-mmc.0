From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC v3 5/6] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Wed, 06 Jul 2016 23:21:40 +0200
Message-ID: <4446440.WBAWGRgdkJ@wuerfel>
References: <1467836610-18539-1-git-send-email-horms+renesas@verge.net.au> <1467836610-18539-6-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467836610-18539-6-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, July 6, 2016 10:23:29 PM CEST Simon Horman wrote:
> @@ -117,6 +124,23 @@ void sdhi_sys_dmac_init_dma(void);
>  static void sdhi_sys_dmac_init_dma(void) { }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHI_INTERNAL_DMA)
> +void sdhi_internal_dmac_init_dma(void);
> +#else
> +static void sdhi_internal_dmac_init_dma(void) { }
> +#endif
> +
> +static void sh_mobile_sdhi_init_dma(enum tmio_mmc_dmac_type dmac_type)
> +{
> +       switch (dmac_type) {
> +       case TMIO_MMC_INTERNAL_DMAC:
> +               return sdhi_internal_dmac_init_dma();
> +
> +       case TMIO_MMC_SYSC_DMAC:
> +               return sdhi_sys_dmac_init_dma();
> +       }
> +}
> +
>  static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
>  {
>         u32 val;
> 

I've commented on this part for v2 already but got no reply. This
time I took a little more care to understand the structure of the
driver and how it gets modified.

The way I see it, we have the MMC_TMIO_CORE driver that consists of
tmio_mmc_pio.c and tmio_mmc_dma.c, which are tightly connected though the
second one is optional, and two front-ends named tmio_mmc.c and
sh_mobile_sdhi.c.

The first front-end never uses DMA, while the second one may or may
not use DMA but is always built with the DMA support linked into the
core driver.

I think abstracting the two DMA modes through a structure of
function pointers as you do is the right strategy, but to build on
top of that, we can change the link order:

- rename tmio_mmc_pio.c to tmio_mmc_core.c and make that the actual
  driver core (without DMA)
- tmio_mmc_dma.c becomes the main driver module for sh_mobile_sdhi
  and gets the sh_mobile_sdhi_driver structure, sh_mobile_sdhi_of_match
  table and module_platform_driver() statement
- the existing sh_mobile_sdhi.c is a library module that exports
  sh_mobile_sdhi_probe() and sh_mobile_sdhi_remove(), which now
  gain a 'struct tmio_mmc_dma_ops *' and a 'struct sh_mobile_sdhi_of_data *'
  argument and get called by the new probe function in what used to
  be tmio_mmc_dma.c.
- The new renesas_sdhi_internal_dmac.c becomes a third top-level
  module that also calls sh_mobile_sdhi_probe() but passes its
  own struct tmio_mmc_dma_ops and registers a different
  platform_driver that only matches the of_rcar_gen3_compatible.

	Arnd
