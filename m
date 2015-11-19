From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq: constify mmc_pwrseq_ops structures
Date: Thu, 19 Nov 2015 12:51:30 +0100
Message-ID: <CAPDyKFpav2M+XyPmhKdGX33OemxJo-w9AenEcWk1uw_L8-zu2Q@mail.gmail.com>
References: <1447520720-11564-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447520720-11564-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 November 2015 at 18:05, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> The mmc_pwrseq_ops structures are never modified, so declare them as const.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>  drivers/mmc/core/pwrseq.h        |    2 +-
>  drivers/mmc/core/pwrseq_emmc.c   |    2 +-
>  drivers/mmc/core/pwrseq_simple.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 096da48..133de04 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -16,7 +16,7 @@ struct mmc_pwrseq_ops {
>  };
>
>  struct mmc_pwrseq {
> -       struct mmc_pwrseq_ops *ops;
> +       const struct mmc_pwrseq_ops *ops;
>  };
>
>  #ifdef CONFIG_OF
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index ad4f94e..4a82bc7 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -51,7 +51,7 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
>         kfree(pwrseq);
>  }
>
> -static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
>         .post_power_on = mmc_pwrseq_emmc_reset,
>         .free = mmc_pwrseq_emmc_free,
>  };
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538b..2b16263 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -87,7 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>         kfree(pwrseq);
>  }
>
> -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>         .pre_power_on = mmc_pwrseq_simple_pre_power_on,
>         .post_power_on = mmc_pwrseq_simple_post_power_on,
>         .power_off = mmc_pwrseq_simple_power_off,
>
