From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: tmio: remove SDIO from TODO list
Date: Fri, 18 Nov 2016 15:29:40 +0100
Message-ID: <CAPDyKFoCKHZ39oFanQeYRzob6RhWDfw45PpfsasGuQVBo6bC+w@mail.gmail.com>
References: <20161113142912.4041-1-wsa+renesas@sang-engineering.com> <20161113142912.4041-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161113142912.4041-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 13 November 2016 at 15:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We surely have SDIO support by now :)
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 2b04e6e87192c7..87fea67a743674 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -22,7 +22,6 @@
>   * TODO:
>   *   Investigate using a workqueue for PIO transfers
>   *   Eliminate FIXMEs
> - *   SDIO support
>   *   Better Power management
>   *   Handle MMC errors better
>   *   double buffer support
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
