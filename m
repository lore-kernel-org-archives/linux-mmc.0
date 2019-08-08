From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 29/57] mmc: Remove dev_err() usage after platform_get_irq()
Date: Thu, 8 Aug 2019 09:58:49 +0200
Message-ID: <CAMuHMdVMTAQ7oiRd443qLfY42cwd21x1nJM0yhKLtoqKjHDLQg@mail.gmail.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-30-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730181557.90391-30-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Tue, Jul 30, 2019 at 10:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/mmc/host/bcm2835.c       | 1 -
>  drivers/mmc/host/jz4740_mmc.c    | 1 -
>  drivers/mmc/host/meson-gx-mmc.c  | 1 -
>  drivers/mmc/host/mxcmmc.c        | 4 +---
>  drivers/mmc/host/s3cmci.c        | 1 -
>  drivers/mmc/host/sdhci-msm.c     | 2 --
>  drivers/mmc/host/sdhci-pltfm.c   | 1 -
>  drivers/mmc/host/sdhci-s3c.c     | 4 +---
>  drivers/mmc/host/sdhci_f_sdh30.c | 4 +---
>  drivers/mmc/host/uniphier-sd.c   | 4 +---
>  10 files changed, 4 insertions(+), 19 deletions(-)

Failed to catch:

drivers/mmc/host/sh_mmcif.c:    irq[0] = platform_get_irq(pdev, 0);
drivers/mmc/host/sh_mmcif.c:    irq[1] = platform_get_irq(pdev, 1);
drivers/mmc/host/sh_mmcif.c-    if (irq[0] < 0) {
drivers/mmc/host/sh_mmcif.c-            dev_err(dev, "Get irq error\n");
drivers/mmc/host/sh_mmcif.c-            return -ENXIO;
drivers/mmc/host/sh_mmcif.c-    }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
