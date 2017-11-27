From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon, 27 Nov 2017 11:16:37 +0100
Message-ID: <CAMuHMdWZuGUvK5FvwO4kkhNeir_j+13VWB-y3SSUO3s5Z6w+bA@mail.gmail.com>
References: <20171120213236.53266-1-jc@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120213236.53266-1-jc@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Chan <jc@linux.com>, Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jesse,

On Mon, Nov 20, 2017 at 10:32 PM, Jesse Chan <jc@linux.com> wrote:
> This change resolves a new compile-time warning
> when built as a loadable module:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/renesas_sdhi_core.o
> see include/linux/module.h for more information
>
> This adds the license as "GPL v2", which matches the header of the file.
>
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.
>
> Signed-off-by: Jesse Chan <jc@linux.com>
> ---
>  drivers/mmc/host/renesas_sdhi.h               | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c          | 5 +++++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 -
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 -
>  4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index b9dfea5d8193..090cf86d7cd3 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -13,6 +13,7 @@
>  #define RENESAS_SDHI_H
>
>  #include <linux/platform_device.h>
> +#include <linux/module.h>
>  #include "tmio_mmc.h"
>
>  struct renesas_sdhi_scc {
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fcf7235d5742..0a0daa7a342f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -667,3 +667,8 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
> +
> +MODULE_DESCRIPTION("Renesas SDHI driver");
> +MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> +MODULE_AUTHOR("Samuel Ortiz <sameo@openedhand.com>");
> +MODULE_LICENSE("GPL v2");

This doesn't look right to me. Before commit 9d08428afb722fed ("mmc:
renesas-sdhi: make renesas_sdhi_sys_dmac main module file"), the file had:

     MODULE_AUTHOR("Magnus Damm");
     MODULE_LICENSE("GPL v2");

> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 41cbe84c1d18..a9b452b42fac 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -15,7 +15,6 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sys_soc.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 9ab10436e4b8..fe6a09f14682 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -17,7 +17,6 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> --
> 2.14.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
