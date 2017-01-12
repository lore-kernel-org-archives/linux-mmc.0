From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: tmio: drop superfluous exit path
Date: Thu, 12 Jan 2017 13:00:53 +0100
Message-ID: <CAPDyKFrU6Ws2QoP=E55Fn8ksScwKv0wQf=XT0aN8Af8Yy7GGAQ@mail.gmail.com>
References: <20170106083833.22137-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170106083833.22137-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 January 2017 at 09:38, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The probe exit path on error does nothing since commit 94b110aff8679b
> ("mmc: tmio: add tmio_mmc_host_alloc/free()"), so we can bail out
> immediately.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index d0d1743b1c002b..2e2df63ce92658 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1151,7 +1151,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>
>         ret = mmc_of_parse(mmc);
>         if (ret < 0)
> -               goto host_free;
> +               return ret;
>
>         _host->pdata = pdata;
>         platform_set_drvdata(pdev, mmc);
> @@ -1161,14 +1161,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>
>         ret = tmio_mmc_init_ocr(_host);
>         if (ret < 0)
> -               goto host_free;
> +               return ret;
>
>         _host->ctl = devm_ioremap(&pdev->dev,
>                                   res_ctl->start, resource_size(res_ctl));
> -       if (!_host->ctl) {
> -               ret = -ENOMEM;
> -               goto host_free;
> -       }
> +       if (!_host->ctl)
> +               return -ENOMEM;
>
>         tmio_mmc_ops.card_busy = _host->card_busy;
>         tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
> @@ -1206,10 +1204,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>          * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
>          * looping forever...
>          */
> -       if (mmc->f_min == 0) {
> -               ret = -EINVAL;
> -               goto host_free;
> -       }
> +       if (mmc->f_min == 0)
> +               return -EINVAL;
>
>         /*
>          * While using internal tmio hardware logic for card detection, we need
> @@ -1274,10 +1270,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>         }
>
>         return 0;
> -
> -host_free:
> -
> -       return ret;
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_probe);
>
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
