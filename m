From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-bcm2835: Actually enable the clock
Date: Mon, 1 Jun 2015 10:05:50 +0200
Message-ID: <CAPDyKFoUp+XmVkgZwgUNq8cpiA218bC4QxRMUWjSb=OqyAg0Zw@mail.gmail.com>
References: <1432933572-8695-1-git-send-email-eric@anholt.net>
	<1432933572-8695-2-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32963 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbFAIFv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 04:05:51 -0400
Received: by qkhg32 with SMTP id g32so80076892qkh.0
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 01:05:50 -0700 (PDT)
In-Reply-To: <1432933572-8695-2-git-send-email-eric@anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rpi-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 29 May 2015 at 23:06, Eric Anholt <eric@anholt.net> wrote:
> We're currently using a fixed frequency clock specified in the DT, so
> enabling is a no-op.  However, the RPi firmware-based clocks driver
> can actually disable unused clocks, so when switching to use it we
> ended up losing our MMC clock once all devices were probed.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Thanks, applied!

Kind regards
Uffe


> ---
>
> v2: Re-disable our clock on sdhci_add_host() failure.
>
>  drivers/mmc/host/sdhci-bcm2835.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 32f4046..1c65d46 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -172,12 +172,19 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>                 ret = PTR_ERR(pltfm_host->clk);
>                 goto err;
>         }
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable host clk\n");
> +               goto err;
> +       }
>
>         ret = sdhci_add_host(host);
>         if (ret)
> -               goto err;
> +               goto err_clk;
>
>         return 0;
> +err_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
>  err:
>         sdhci_pltfm_free(pdev);
>         return ret;
> --
> 2.1.4
>
