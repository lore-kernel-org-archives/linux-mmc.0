From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Call OF parsing for MMC
Date: Wed, 8 Apr 2015 12:08:03 +0200
Message-ID: <CAPDyKFqoDOpdRaq=yMQGfwnk6_UVkT0Uqurhx3602+vXz1jaeg@mail.gmail.com>
References: <35949221633dcbb490c3c28b8099c5be00cb9730.1428386249.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35949221633dcbb490c3c28b8099c5be00cb9730.1428386249.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 7 April 2015 at 07:57, Michal Simek <michal.simek@xilinx.com> wrote:
> Also check MMC OF properties. The controller supports MMC too.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks! Applied.

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-of-arasan.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index bcb51e9..b8cfac1 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -173,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         pltfm_host->priv = sdhci_arasan;
>         pltfm_host->clk = clk_xin;
>
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
> +               goto clk_disable_all;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto err_pltfm_free;
> --
> 1.7.2.3
>
