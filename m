From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Fri, 9 Jun 2017 16:28:23 +0200
Message-ID: <CAPDyKFrCCmaF8MrbjiEnnRYW400V8OFdJiktf8fBWD=L-H3OqQ@mail.gmail.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com> <1486483202-5515-4-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34940 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdFIO2Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 10:28:24 -0400
Received: by mail-qt0-f176.google.com with SMTP id w1so77376242qtg.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 07:28:24 -0700 (PDT)
In-Reply-To: <1486483202-5515-4-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Uri/Alex,

Apologize for the long delay, I have simply forgot about this.

On 7 February 2017 at 17:00, Uri Yanai <uri.yanai@sandisk.com> wrote:
> In case of Runtime Suspend, check the device BKOPS level.
> Return =E2=80=93EBUSY if device need more time to complete its internal B=
KOPS.
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> ---
>
> Changes in v3:
> - start with checking if *auto* BKOPS is enabled
>
> Changes in v2:
> - return =E2=80=93EBUSY instead of delaying suspend
> - remove define EXT_CSD_BKOPS_LEVEL_1
>
> ---
>  drivers/mmc/core/mmc.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f70f6a1..4888609 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1942,7 +1942,8 @@ static void mmc_detect(struct mmc_host *host)
>         }
>  }
>
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +       bool is_runtime_pm)
>  {
>         int err =3D 0;
>         unsigned int notify_type =3D is_suspend ? EXT_CSD_POWER_OFF_SHORT=
 :
> @@ -1953,7 +1954,26 @@ static int _mmc_suspend(struct mmc_host *host, boo=
l is_suspend)
>         if (mmc_card_suspended(host->card))
>                 goto out;
>
> -       if (mmc_card_doing_bkops(host->card)) {
> +       if (mmc_card_doing_bkops(host->card) ||
> +                       host->card->ext_csd.auto_bkops_en) {
> +               if (is_runtime_pm) {
> +                       err =3D mmc_read_bkops_status(host->card);
> +                       if (err) {
> +                               pr_err("%s: error %d reading BKOPS Status=
\n",
> +                                               mmc_hostname(host), err);
> +                               goto out;
> +                       }
> +
> +                       if (host->card->ext_csd.raw_bkops_status >=3D
> +                                       EXT_CSD_BKOPS_LEVEL_2) {
> +                               /*
> +                                * Device still needs time to complete
> +                                * internal BKOPS
> +                                */
> +                               err =3D -EBUSY;
> +                               goto out;
> +                       }
> +               }

As the above path becomes executed only from mmc_runtime_suspend() and
when the host cap MMC_CAP_AGGRESSIVE_PM is set, I think it would be
better to make this it a part of mmc_runtime_suspend().

Moreover, on those platforms where autosleep (or opportunistic sleep)
is enabled for system suspend, perhaps we should also return -EBUSY
and take a wakeup source for a certain timeout, to avoid system
suspend being re-tried for a while.

>                 err =3D mmc_stop_bkops(host->card);
>                 if (err)
>                         goto out;
> @@ -1987,7 +2007,7 @@ static int mmc_suspend(struct mmc_host *host)
>  {
>         int err;
>
> -       err =3D _mmc_suspend(host, true);
> +       err =3D _mmc_suspend(host, true, false);
>         if (!err) {
>                 pm_runtime_disable(&host->card->dev);
>                 pm_runtime_set_suspended(&host->card->dev);
> @@ -2034,7 +2054,7 @@ static int mmc_shutdown(struct mmc_host *host)
>                 err =3D _mmc_resume(host);
>
>         if (!err)
> -               err =3D _mmc_suspend(host, false);
> +               err =3D _mmc_suspend(host, false, false);
>
>         return err;
>  }
> @@ -2058,7 +2078,7 @@ static int mmc_runtime_suspend(struct mmc_host *hos=
t)
>         if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>                 return 0;
>
> -       err =3D _mmc_suspend(host, true);
> +       err =3D _mmc_suspend(host, true, true);
>         if (err)
>                 pr_err("%s: error %d doing aggressive suspend\n",
>                         mmc_hostname(host), err);
> --
> 1.9.1
>

Kind regards
Uffe
