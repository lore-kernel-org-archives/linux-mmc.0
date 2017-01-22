From: Uri Yanai <Uri.Yanai@sandisk.com>
Subject: RE: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Sun, 22 Jan 2017 15:55:35 +0000
Message-ID: <037111DC0C584A4DB9F38021EA3CBDA506103F51@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
 <1484655337-32562-4-git-send-email-uri.yanai@sandisk.com>
 <7a21bfe1-9eef-0f6f-56ce-4fc34d628ac0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:36944
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751204AbdAVP4v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Jan 2017 10:56:51 -0500
In-Reply-To: <7a21bfe1-9eef-0f6f-56ce-4fc34d628ac0@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

Hi Adrian

Thanks for your review.
Ulf rejected our approach in the first patch submission calling pm_schedule=
_suspend()

" If I understand correctly, you would like to abort the runtime suspend
and allow the background operations to complete. That seems
reasonable, although in such case you need to return -EBUSY from this
function."

If I understood Ulf correctly, instead of suspending he suggest aborting th=
e suspend altogether returning -EBUSY.

If I understood you correctly, your approach is similar to the one taken in=
 the first patch submission.
Instead of calling pm_schedule_suspend(), you suggest calling  mmc_poweroff=
_notify(host->card, SLEEP_NOTIFICATION).

Regards
Uri

-----Original Message-----
From: Adrian Hunter [mailto:adrian.hunter@intel.com]=20
Sent: Friday, January 20, 2017 1:56 PM
To: Uri Yanai; ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org; chris@printf.net; Alex Lemberg
Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend

On 17/01/17 14:15, Uri Yanai wrote:
> If asked to do device Runtime Suspend while in BKOPS and auto BKOPS is=20
> enabled return -EBUSY

The spec also says

"Before moving to Sleep state hosts may set the POWER_OFF_NOTIFICATION byte=
 to SLEEP_NOTIFICATION (0x04) if aware that the device is capable of autono=
mously initiating background operations for possible performance improvemen=
ts."

Have you considered that?

But I wonder if we shouldn't always use SLEEP_NOTIFICATION before sleep?

>=20
> Change-Id: Ie4b38a32fe98179f0bca5b57edaaa47a02d0a389
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/core/mmc.c  | 35 ++++++++++++++++++++++++++++-------
>  include/linux/mmc/mmc.h |  2 ++
>  2 files changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index=20
> f70f6a1..21f5851 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1942,7 +1942,8 @@ static void mmc_detect(struct mmc_host *host)
>  	}
>  }
> =20
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +	bool is_runtime_pm)
>  {
>  	int err =3D 0;
>  	unsigned int notify_type =3D is_suspend ? EXT_CSD_POWER_OFF_SHORT :
> @@ -1953,10 +1954,30 @@ static int _mmc_suspend(struct mmc_host *host, bo=
ol is_suspend)
>  	if (mmc_card_suspended(host->card))
>  		goto out;
> =20
> -	if (mmc_card_doing_bkops(host->card)) {
> -		err =3D mmc_stop_bkops(host->card);
> -		if (err)
> +	if (mmc_card_doing_bkops(host->card) ||
> +		host->card->ext_csd.auto_bkops_en) {
> +		err =3D mmc_read_bkops_status(host->card);
> +		if (err) {
> +			pr_err("%s: error %d reading BKOPS Status\n",
> +				mmc_hostname(host), err);
>  			goto out;
> +		}
> +		if (is_runtime_pm && host->card->ext_csd.raw_bkops_status >=3D
> +				EXT_CSD_BKOPS_LEVEL_PM_SUSPEND) {
> +			/*
> +			 * We don't allow Runtime Suspend while device still
> +			 * needs time to complete internal BKOPS, returning
> +			 * -EBUSY while BKOPS level is above
> +			 *  EXT_CSD_BKOPS_LEVEL_PM_SUSPEND
> +			 */
> +			err =3D -EBUSY;
> +			goto out;
> +		}
> +		if (mmc_card_doing_bkops(host->card)) {
> +			err =3D mmc_stop_bkops(host->card);
> +			if (err)
> +				goto out;
> +		}
>  	}
> =20
>  	err =3D mmc_flush_cache(host->card);
> @@ -1987,7 +2008,7 @@ static int mmc_suspend(struct mmc_host *host)  {
>  	int err;
> =20
> -	err =3D _mmc_suspend(host, true);
> +	err =3D _mmc_suspend(host, true, false);
>  	if (!err) {
>  		pm_runtime_disable(&host->card->dev);
>  		pm_runtime_set_suspended(&host->card->dev);
> @@ -2034,7 +2055,7 @@ static int mmc_shutdown(struct mmc_host *host)
>  		err =3D _mmc_resume(host);
> =20
>  	if (!err)
> -		err =3D _mmc_suspend(host, false);
> +		err =3D _mmc_suspend(host, false, false);
> =20
>  	return err;
>  }
> @@ -2058,7 +2079,7 @@ static int mmc_runtime_suspend(struct mmc_host *hos=
t)
>  	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>  		return 0;
> =20
> -	err =3D _mmc_suspend(host, true);
> +	err =3D _mmc_suspend(host, true, true);
>  	if (err)
>  		pr_err("%s: error %d doing aggressive suspend\n",
>  			mmc_hostname(host), err);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index=20
> 126b8d5..2633274 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -445,6 +445,8 @@ struct _mmc_csd {
>   */
>  #define EXT_CSD_BKOPS_LEVEL_2		0x2
> =20
> +#define EXT_CSD_BKOPS_LEVEL_PM_SUSPEND	EXT_CSD_BKOPS_LEVEL_2
> +
>  /*
>   * BKOPS modes
>   */
>=20

