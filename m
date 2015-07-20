From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Mon, 20 Jul 2015 16:21:52 +0200
Message-ID: <CAPDyKFoU9a6Ta_c8Q=cnOhWdsaYok1mrNZJgz1Jx+BD_HYbpwg@mail.gmail.com>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 July 2015 at 13:53, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
> Ensure SDCC is working with maximum clock otherwise card
> detection could be extremely slow, up to 7 seconds.
>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, applied!

Kind regards
Uffe

> ---
>
> Changes since v0:
> - s/falied/failed in warning message.
>
>  drivers/mmc/host/sdhci-msm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4a09f76..4bcee03 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 goto pclk_disable;
>         }
>
> +       /* Vote for maximum clock rate for maximum performance */
> +       ret = clk_set_rate(msm_host->clk, INT_MAX);
> +       if (ret)
> +               dev_warn(&pdev->dev, "core clock boost failed\n");
> +
>         ret = clk_prepare_enable(msm_host->clk);
>         if (ret)
>                 goto pclk_disable;
> --
> 1.9.1
>
