From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Add error message when switching fails in mmc_select_hs()
Date: Thu, 25 Aug 2016 12:02:46 +0200
Message-ID: <CAPDyKFoLOUoRY77_5Andtm397-sy-Z_EJc2Xfv_xia-fNwOQtg@mail.gmail.com>
References: <1472034849-9100-1-git-send-email-js07.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472034849-9100-1-git-send-email-js07.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jungseung Lee <js07.lee@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 August 2016 at 12:34, Jungseung Lee <js07.lee@samsung.com> wrote:
> The switch failure message in mmc_select_timing() had been removed
> since that is invalid: commit 0400ed0a083a ("mmc: core: remove the
> invalid message in mmc_select_timing")
>
> Now, in the case when mmc_select_hs() return error in mmc_select_timing(),
> there is nothing to print failure message.
> Let's make for mmc_select_hs() print message itself in the failure case.
>
> Signed-off-by: Jungseung Lee <js07.lee@samsung.com>

Thanks, applied for next!

Future wise, please bump the version number and include a history of
what has changed. This helps the reviewers.

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f2d185c..3486bc7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1029,6 +1029,10 @@ static int mmc_select_hs(struct mmc_card *card)
>                 err = mmc_switch_status(card);
>         }
>
> +       if (err)
> +               pr_warn("%s: switch to high-speed failed, err:%d\n",
> +                       mmc_hostname(card->host), err);
> +
>         return err;
>  }
>
> @@ -1265,11 +1269,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
>
>         /* Switch card to HS mode */
>         err = mmc_select_hs(card);
> -       if (err) {
> -               pr_err("%s: switch to high-speed failed, err:%d\n",
> -                       mmc_hostname(host), err);
> +       if (err)
>                 goto out_err;
> -       }
>
>         err = mmc_switch_status(card);
>         if (err)
> --
> 1.7.9.5
>
