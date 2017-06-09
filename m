From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/5] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Fri, 9 Jun 2017 09:39:49 +0200
Message-ID: <CAMuHMdU8fqoi-zh4OKC_40xH3pZy+w_qDjtxm2pRLUsJieFmgw@mail.gmail.com>
References: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au> <1496927595-19521-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496927595-19521-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Thu, Jun 8, 2017 at 3:13 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> R-Car Gen3 has a dedicated DMA controller for SDHI module. Since
> the DMAC is in a part of SDHI module and is not suitable as dmaengine,

the DMAC is part of the SDHI module?

> this patch adds a different code as tmio_mmc_dma_gen3.c.

adds different code?

> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -575,10 +575,27 @@ config MMC_SDHI
>         depends on SUPERH || ARM || ARM64
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         select MMC_TMIO_CORE
> +       select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
> +       select MMC_SDHI_INTERNAL_DMAC if ARM64
>         help
>           This provides support for the SDHI SD/SDIO controller found in
>           Renesas SuperH, ARM and ARM64 based SoCs
>
> +config MMC_SDHI_SYS_DMAC
> +       tristate "DMA support use of SYS DMAC with SDHI SD/SDIO controller"

DMA support for SYS_DMAC?


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
