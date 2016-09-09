From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: davinci: remove incorrect NO_IRQ use
Date: Fri, 9 Sep 2016 11:46:05 +0200
Message-ID: <CAPDyKFpSEpWssRJBYzhR3zW4hxKqsjX33dNh0WUpDwm7PcofZg@mail.gmail.com>
References: <20160906125633.1563621-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906125633.1563621-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Lechner <david@lechnology.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 September 2016 at 14:56, Arnd Bergmann <arnd@arndb.de> wrote:
> platform_get_irq() returns an error value on failure, not NO_IRQ,
> so the error handling here could never work.
>
> This changes the code to propagate the error value instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/davinci_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c521559412fc..67ef4810b3de 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1216,9 +1216,11 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>         }
>
>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       irq = platform_get_irq(pdev, 0);
> -       if (!r || irq == NO_IRQ)
> +       if (!r)
>                 return -ENODEV;
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
>
>         mem_size = resource_size(r);
>         mem = devm_request_mem_region(&pdev->dev, r->start, mem_size,
> --
> 2.9.0
>
