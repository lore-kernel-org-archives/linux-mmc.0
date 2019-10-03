From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cavium-octeon: Use devm_platform_ioremap_resource()
 in octeon_mmc_probe()
Date: Thu, 3 Oct 2019 12:01:47 +0200
Message-ID: <CAPDyKFpHdOGqSTDd95m=NjcE+vkW_p=61UFFegJ9QX8j3UdB0g@mail.gmail.com>
References: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 18 Sep 2019 at 14:28, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 14:20:34 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-octeon.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 22aded1065ae..916746c6c2c7 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -148,7 +148,6 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *cn, *node = pdev->dev.of_node;
>         struct cvm_mmc_host *host;
> -       struct resource *res;
>         void __iomem *base;
>         int mmc_irq[9];
>         int i, ret = 0;
> @@ -205,23 +204,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>
>         host->last_slot = -1;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[0] is missing\n");
> -               return -ENXIO;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->base = (void __iomem *)base;
>         host->reg_off = 0;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[1] is missing\n");
> -               return -EINVAL;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->dma_base = (void __iomem *)base;
> --
> 2.23.0
>
