From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] mmc: sdhci-of-at91: remove a line of dead code
Date: Thu, 17 Sep 2015 10:49:19 +0200
Message-ID: <CAPDyKFoR1gq+xEBZRqaPZ9WPKLN_KAkcbNCF_pnR+VJ9RXJCFg@mail.gmail.com>
References: <20150916061949.GA21542@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150916061949.GA21542@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 16 September 2015 at 08:19, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The goto is correct and the unreachable "return -EINVAL" should be
> removed.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied for next!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index d155664..d3df786 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -110,7 +110,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "failed to set gck");
>                 goto hclock_disable_unprepare;
> -               return -EINVAL;
>         }
>         /*
>          * We need to check if we have the requested rate for gck because in
