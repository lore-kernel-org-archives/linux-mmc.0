From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc/host/sdhci-of-arasan.c: Use signed formatting in
 error messages
Date: Mon, 27 Oct 2014 16:38:04 +0100
Message-ID: <CAPDyKFrCMHor7PegYiT52ooST2E_3pio+ko0ybG48OgacVMZHQ@mail.gmail.com>
References: <1414063861-5491-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414063861-5491-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Chris Ball <chris@printf.net>
List-Id: linux-mmc@vger.kernel.org

On 23 October 2014 13:31, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> "ret" is a signed int, so use "%d" in format strings instead of "%u".
> This prevents cryptic codes in error messages like this:
> sdhci-arasan e0101000.sdhci: platform register failed (4294966779)
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks! Applied for next.

I will expect a v2 of patch2.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 8cf81c3..7ac6718 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -161,7 +161,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> -               dev_err(&pdev->dev, "platform init failed (%u)\n", ret);
> +               dev_err(&pdev->dev, "platform init failed (%d)\n", ret);
>                 goto clk_disable_all;
>         }
>
> @@ -172,7 +172,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = sdhci_add_host(host);
>         if (ret) {
> -               dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
> +               dev_err(&pdev->dev, "platform register failed (%d)\n", ret);
>                 goto err_pltfm_free;
>         }
>
> --
> 1.7.9.5
>
