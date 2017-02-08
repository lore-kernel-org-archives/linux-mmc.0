From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Wed, 8 Feb 2017 12:59:03 +0100
Message-ID: <CAPDyKFodi4gsQ5HVuXeT8SsJhF=u1zfDETcVZLzqaLSE5w2sEw@mail.gmail.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com> <1486483202-5515-4-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34625 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdBHShj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 13:37:39 -0500
Received: by mail-vk0-f42.google.com with SMTP id r136so107297953vke.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 10:36:34 -0800 (PST)
In-Reply-To: <1486483202-5515-4-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 7 February 2017 at 17:00, Uri Yanai <uri.yanai@sandisk.com> wrote:
> In case of Runtime Suspend, check the device BKOPS level.
> Return =E2=80=93EBUSY if device need more time to complete its internal B=
KOPS.
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

This change needs some more extensive testing in linux-next, but that
won't be possible as it's getting closer to the merge window for 4.11.

Therefore, I leave it open for more discussions until 4.11 rc1 is out.

Kind regards
Uffe

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
> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality=
 Notice & Disclaimer:
>
> This e-mail and any files transmitted with it may contain confidential or=
 legally privileged information of WDC and/or its affiliates, and are inten=
ded solely for the use of the individual or entity to which they are addres=
sed. If you are not the intended recipient, any disclosure, copying, distri=
bution or any action taken or omitted to be taken in reliance on it, is pro=
hibited. If you have received this e-mail in error, please notify the sende=
r immediately and delete the e-mail in its entirety from your system.
