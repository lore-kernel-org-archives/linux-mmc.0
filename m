From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH][next] mmc: sdhci-of-esdhc: fix spelling mistake
 "upsupported" -> "unsupported"
Date: Thu, 6 Dec 2018 11:27:19 +0100
Message-ID: <CAPDyKFrR6u=WbDo9OpeZeTyEwwQfBqpECNFsOnttewQ6c7ic4g@mail.gmail.com>
References: <20181206092411.12152-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206092411.12152-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 6 Dec 2018 at 10:24, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_warn message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 856e809f38b7..e21e90f81bbd 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -597,7 +597,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                         pre_div = 4;
>                         div = 3;
>                 } else {
> -                       pr_warn("%s: using upsupported clock division.\n",
> +                       pr_warn("%s: using unsupported clock division.\n",
>                                 mmc_hostname(host->mmc));
>                 }
>         }
> --
> 2.19.1
>
