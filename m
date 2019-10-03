From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Thu, 3 Oct 2019 12:01:37 +0200
Message-ID: <CAPDyKFo3_QmWHSwmKAXsvfr8F=UviP+vSGOuDMoJppYjv1_aNA@mail.gmail.com>
References: <20191001180834.1158-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180834.1158-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 1 Oct 2019 at 20:08, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> As platform_get_irq() now prints an error when the interrupt does not
> exist, a scary warning may be printed for an optional interrupt:
>
>     sh_mmcif ee200000.mmc: IRQ index 1 not found
>
> Fix this by calling platform_get_irq_optional() instead for the second
> interrupt, which is optional.
>
> Remove the now superfluous error printing for the first interrupt, which
> is mandatory.
>
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> This is a fix for v5.4-rc1.
> ---
>  drivers/mmc/host/sh_mmcif.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 81bd9afb0980525e..98c575de43c755ed 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1393,11 +1393,9 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         const char *name;
>
>         irq[0] = platform_get_irq(pdev, 0);
> -       irq[1] = platform_get_irq(pdev, 1);
> -       if (irq[0] < 0) {
> -               dev_err(dev, "Get irq error\n");
> +       irq[1] = platform_get_irq_optional(pdev, 1);
> +       if (irq[0] < 0)
>                 return -ENXIO;
> -       }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         reg = devm_ioremap_resource(dev, res);
> --
> 2.17.1
>
