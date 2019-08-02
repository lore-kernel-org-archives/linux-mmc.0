From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Mark expected switch fall-through
Date: Fri, 2 Aug 2019 17:16:18 +0200
Message-ID: <CAPDyKFpv0CW2G9ServNX9UKEtGrHRK=u9KoQWfZ8LyQ6Gy3-KQ@mail.gmail.com>
References: <20190729000259.GA24022@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729000259.GA24022@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 29 Jul 2019 at 02:03, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
> drivers/mmc/host/sdhci-s3c.c:613:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> drivers/mmc/host/sdhci-s3c.c:614:2: note: here
>   case 4:
>   ^~~~
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e4a8ba33f05..cefa0fb8cfde 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>         switch (pdata->max_width) {
>         case 8:
>                 host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +               /* Fall through */
>         case 4:
>                 host->mmc->caps |= MMC_CAP_4_BIT_DATA;
>                 break;
> --
> 2.22.0
>
