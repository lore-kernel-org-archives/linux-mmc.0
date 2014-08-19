From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: slot-gpio: restore error reporting
Date: Tue, 19 Aug 2014 09:29:59 +0200
Message-ID: <CAPDyKFq4CjwRfZeCbLf-wtBc7LU+YyLcD8xThPJQKbi49KpZ6g@mail.gmail.com>
References: <1408418880-10250-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1408418880-10250-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 19 August 2014 05:28, Linus Walleij <linus.walleij@linaro.org> wrote:
> The patch switching the MMC core to use GPIO descriptors
> depromoted errors to debug messages for unsuccessful attempt
> to get CD or WP GPIOs. This was because sometimes these are
> not specified, and that should not be an error.
>
> However that is not so helpful: explicitly check whether a
> GPIO is not specified (i.e. -ENOENT is returned) and if there
> is some other error, report it with dev_err().
>
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Cc: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Until we have a fix for the !GPIOLIB, I will drop the four gpiod
patches I recently applied.

I suggest we fold this change into one of the earlier patcher instead.
Please send a new version of the complete patchset.

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 048c6d687cc9..6f7ed9c50346 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -368,9 +368,11 @@ int mmc_of_parse(struct mmc_host *host)
>                 if (ret) {
>                         if (ret == -EPROBE_DEFER)
>                                 return ret;
> -                       dev_dbg(host->parent,
> -                               "Failed to request CD GPIO: %d\n",
> -                               ret);
> +                       if (ret != -ENOENT) {
> +                               dev_err(host->parent,
> +                                       "Failed to request CD GPIO: %d\n",
> +                                       ret);
> +                       }
>                 } else
>                         dev_info(host->parent, "Got CD GPIO\n");
>         }
> @@ -383,9 +385,11 @@ int mmc_of_parse(struct mmc_host *host)
>         if (ret) {
>                 if (ret == -EPROBE_DEFER)
>                         goto out;
> -               dev_dbg(host->parent,
> -                       "Failed to request WP GPIO: %d\n",
> -                       ret);
> +               if (ret != -ENOENT) {
> +                       dev_err(host->parent,
> +                               "Failed to request WP GPIO: %d\n",
> +                               ret);
> +               }
>         } else
>                 dev_info(host->parent, "Got WP GPIO\n");
>
> --
> 1.9.3
>
