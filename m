From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/16] gpio: rcar: use postcore_init()
Date: Thu, 14 Nov 2013 14:42:35 +0100
Message-ID: <2397666.YV2gHto7Bb@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87k3gbz3pe.wl%kuninori.morimoto.gx@renesas.com> <87iovvz3nd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87iovvz3nd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:19:54 Kuninori Morimoto wrote:
> Renesas GPIO is being interlocked with PFC, and GPIO is
> very basic system for R-Car.
> GPIO should be initialised in same timing as PFC.
> The GPIO based system doesn't work correctly without this patch.

Could you please describe the failure in a bit more details ?

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/gpio/gpio-rcar.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 6038966..0a10325 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -454,7 +454,17 @@ static struct platform_driver gpio_rcar_device_driver =
> { }
>  };
> 
> -module_platform_driver(gpio_rcar_device_driver);
> +static int __init gpio_rcar_init(void)
> +{
> +	return platform_driver_register(&gpio_rcar_device_driver);
> +}
> +postcore_initcall(gpio_rcar_init);
> +
> +static void __exit gpio_rcar_exit(void)
> +{
> +	platform_driver_unregister(&gpio_rcar_device_driver);
> +}
> +module_exit(gpio_rcar_exit);
> 
>  MODULE_AUTHOR("Magnus Damm");
>  MODULE_DESCRIPTION("Renesas R-Car GPIO Driver");
-- 
Regards,

Laurent Pinchart

