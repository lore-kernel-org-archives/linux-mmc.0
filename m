From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq: use gpiod_get() instead of index 0
Date: Thu, 17 Sep 2015 10:48:51 +0200
Message-ID: <CAPDyKFqmpA7F=W=HyH8tU53K45cYA_R61kTa9-_4pc4fMHq_JA@mail.gmail.com>
References: <1442232035-32051-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442232035-32051-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On 14 September 2015 at 14:00, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The gpiod_get() function expands to gpiod_get_index() with index 0
> so it's better to use it since is easier to read and more concise.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/core/pwrseq_emmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 9d6d2fb21796..137c97fb7aa8 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -76,7 +76,7 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>         if (!pwrseq)
>                 return ERR_PTR(-ENOMEM);
>
> -       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
> +       pwrseq->reset_gpio = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>         if (IS_ERR(pwrseq->reset_gpio)) {
>                 ret = PTR_ERR(pwrseq->reset_gpio);
>                 goto free;
> --
> 2.4.3
>
