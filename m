From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH] mmc: mmc_spi: Export OF module alias information
Date: Thu, 17 Sep 2015 10:49:01 +0200
Message-ID: <CAPDyKFohZGTq-gRsuyooCOZ0x4J-Z3LN=pScAY3+XVcxUjvPXQ@mail.gmail.com>
References: <1442394727-13963-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442394727-13963-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabian Frederick <fabf@skynet.be>, linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On 16 September 2015 at 11:12, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Drivers needs to export the OF id table and this be built into
> the module or udev won't have the necessary information to autoload
> the driver module when the device is registered via OF.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/host/mmc_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index ae19d83bb9de..8ee11f4120fc 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1511,6 +1511,7 @@ static const struct of_device_id mmc_spi_of_match_table[] = {
>         { .compatible = "mmc-spi-slot", },
>         {},
>  };
> +MODULE_DEVICE_TABLE(of, mmc_spi_of_match_table);
>
>  static struct spi_driver mmc_spi_driver = {
>         .driver = {
> --
> 2.4.3
>
