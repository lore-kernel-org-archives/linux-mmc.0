From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav2: add error handling of clk_prepare_enable()
Date: Tue, 14 Mar 2017 17:21:08 +0100
Message-ID: <CAPDyKFoqoFpwwnneDsBD9Z16HEaTfaSPqeuFcUhf83djxA3u-A@mail.gmail.com>
References: <1486767286-3361-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486767286-3361-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-Id: linux-mmc@vger.kernel.org

On 10 February 2017 at 23:54, Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> There is no check if clk_prepare_enable() succeed in sdhci_pxav2_probe().
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav2.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 347eae2d7b6a..80513f54e9d4 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -185,7 +185,11 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>                 goto err_clk_get;
>         }
>         pltfm_host->clk = clk;
> -       clk_prepare_enable(clk);
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable io clock\n");
> +               goto err_clk_enable;
> +       }
>
>         host->quirks = SDHCI_QUIRK_BROKEN_ADMA
>                 | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> @@ -228,6 +232,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>
>  err_add_host:
>         clk_disable_unprepare(clk);
> +err_clk_enable:
>         clk_put(clk);
>  err_clk_get:
>         sdhci_pltfm_free(pdev);
> --
> 2.7.4
>
