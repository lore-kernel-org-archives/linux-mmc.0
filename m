From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Thu, 2 Feb 2017 13:49:37 +0100
Message-ID: <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com> <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38338 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdBBMtj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2017 07:49:39 -0500
Received: by mail-wm0-f41.google.com with SMTP id r141so87690144wmg.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2017 04:49:38 -0800 (PST)
In-Reply-To: <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>

+ Adrian, Shawn-Lin, Jaehoon, Ritesh

On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
> In case of Runtime Suspend, check the device BKOPS level.
> Return =E2=80=93EBUSY if device need more time to complete its internal B=
KOPS.
>
> Changes in v2:
> - return =E2=80=93EBUSY instead of delaying suspend
> - remove define EXT_CSD_BKOPS_LEVEL_1
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/core/mmc.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f70f6a1..211b726 100644
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
> @@ -1954,6 +1955,24 @@ static int _mmc_suspend(struct mmc_host *host, boo=
l is_suspend)
>                 goto out;
>
>         if (mmc_card_doing_bkops(host->card)) {
> +               if (is_runtime_pm && host->card->ext_csd.auto_bkops_en) {

This don't work. Primarily because mmc_card_doing_bkops(host->card)
don't ever return true, unless manual BKOPS is enabled.

I think you need to start with checking if *auto* BKOPS is enabled,
then you can continue to read the BKOPS status to find out whether you
should return -EBUSY.

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
> +                                * We don=E2=80=99t allow Runtime Suspend=
 while device
> +                                * still needs time to complete internal =
BKOPS
> +                                */

Hmm.

Shouldn't we abort (return -EBUSY) also in the system PM suspend case
and not only for runtime PM suspend?

I think we need to discuss this with some other mmc folkz as well,
looping in Adrian, Shawn, Jaehoon and Ritesh.

Of course, unless we are being clever, in could mean that the system
will never enter system PM suspend state, due to a bad behaving eMMC
always reporting EXT_CSD_BKOPS_LEVEL_2. So we need to be careful here.

Now, assume we may want to abort in the system PM suspend case as
well, then we consider to avoid the "Opportunistic sleep" from
hammering us with new system PM suspend attempts. That can be avoided
by activating a wakeup source (aka wakelock), via calling
pm_wakeup_event(), using the struct device for the mmc_card as the
parameter.

> +                               err =3D -EBUSY;
> +                               goto out;
> +                       }
> +               }
>                 err =3D mmc_stop_bkops(host->card);
>                 if (err)
>                         goto out;
> @@ -1987,7 +2006,7 @@ static int mmc_suspend(struct mmc_host *host)
>  {
>         int err;
>
> -       err =3D _mmc_suspend(host, true);
> +       err =3D _mmc_suspend(host, true, false);
>         if (!err) {
>                 pm_runtime_disable(&host->card->dev);
>                 pm_runtime_set_suspended(&host->card->dev);
> @@ -2034,7 +2053,7 @@ static int mmc_shutdown(struct mmc_host *host)
>                 err =3D _mmc_resume(host);
>
>         if (!err)
> -               err =3D _mmc_suspend(host, false);
> +               err =3D _mmc_suspend(host, false, false);
>
>         return err;
>  }
> @@ -2058,7 +2077,7 @@ static int mmc_runtime_suspend(struct mmc_host *hos=
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
