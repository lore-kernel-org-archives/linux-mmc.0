From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5 RFC] mmc: sdhci-iproc: Actually enable the clock
Date: Wed, 27 Jan 2016 15:16:10 +0100
Message-ID: <CAPDyKFrCV_GCqCjymsKuOov9GT8gbmb9rBQoJfzmMbMtBnoqWQ@mail.gmail.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
	<1453042744-16196-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453042744-16196-3-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 17 January 2016 at 15:59, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> The RPi firmware-based clocks driver can actually disable
> unused clocks, so when switching to use it we ended up losing
> our MMC clock once all devices were probed.
>
> This patch adopts the changes from 1e5a0a9a58e2 ("mmc: sdhci-bcm2835:
> Actually enable the clock") to sdhci-iproc.
>
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-iproc.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index e22060a..55bc348 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -207,6 +207,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>                 ret = PTR_ERR(pltfm_host->clk);
>                 goto err;
>         }
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable host clk\n");
> +               goto err;
> +       }
>
>         if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>                 host->caps = iproc_host->data->caps;
> @@ -215,10 +220,12 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>
>         ret = sdhci_add_host(host);
>         if (ret)
> -               goto err;
> +               goto err_clk;
>
>         return 0;
>
> +err_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
>  err:
>         sdhci_pltfm_free(pdev);
>         return ret;
> --
> 1.7.9.5
>

There's a missing clk_disable_unprepare() from the ->remove()
callback. Otherwise this looks good.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
