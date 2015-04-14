From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: pwrseq: Fix error code propagation in mmc_pwrseq_simple_alloc()
Date: Tue, 14 Apr 2015 11:20:40 +0200
Message-ID: <CAPDyKFqnpj3StC-3VKosn2EJnXzbxJgHfMP0FOi7_KUBa-0vDA@mail.gmail.com>
References: <1428934061-29217-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1428934061-29217-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, Kevin Hilman <khilman@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 13 April 2015 at 16:07, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> If the struct mmc_pwrseq_match .alloc function used to allocate a
> struct mmc_pwrseq fails, the error is propagated to mmc_of_parse().
>
> But instead of returning the error code in pwrseq, host->pwrseq is
> returned which will always be 0. So mmc_of_parse() succeeds even if
> the pwrseq .alloc function failed and host->pwrseq is NULL.
>
> This makes the SDIO device to not be powered if the power sequencing
> .alloc functions wants to be deferred due a missing resource because
> the mmc controller driver probe did wrongly succeed.
>
> Fixes: 0f12a0ce4ce4a ("mmc: pwrseq: simplify alloc/free hooks")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks! Applied for fixes.

Kind regards
Uffe

> ---
>  drivers/mmc/core/pwrseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index ab2129781161..4c1d1757dbf9 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -73,7 +73,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>
>         pwrseq = match->alloc(host, &pdev->dev);
>         if (IS_ERR(pwrseq)) {
> -               ret = PTR_ERR(host->pwrseq);
> +               ret = PTR_ERR(pwrseq);
>                 goto err;
>         }
>
> --
> 2.1.4
>
