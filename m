From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Tue, 16 Nov 2010 15:22:16 +0200
Message-ID: <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
 <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
 <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
 <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
 <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com> <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38269 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab0KPNWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 08:22:37 -0500
Received: by gwj17 with SMTP id 17so272993gwj.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 05:22:36 -0800 (PST)
In-Reply-To: <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnd Hannemann <arnd@arndnet.de>

On Mon, Nov 1, 2010 at 10:27 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Sun, Oct 31, 2010 at 9:06 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
> ...
>> we need to support boards with controllers/cards
>> which we can't power off in runtime.
>>
>> On such boards, the right thing to do would be to disable runtime PM=
 altogether.
>
> The patch below (/attached) should trivially fix the problem - can yo=
u
> please check it out ?
>
> It's very simple: it just requires hosts to explicitly indicate they
> support runtime powering off/on their cards (by means of
> MMC_CAP_RUNTIME_PM).
>
> There is no way around this I'm afraid: it is legitimate for a
> board/host/card configuration not to support powering off the card
> after boot, and we must allow it.
>
> In addition having an explicit MMC_CAP_RUNTIME_PM will also allow us
> smoother transition to runtime PM behavior. Developers will have to
> explicitly turn it on, and will not be surprised if things won't
> immediately work.
>
> Please note that this cap is not interchangeable, and can't be replac=
e
> with CONFIG_PM_RUNTIME.
>
> Having said that, I still think we need to understand why CMD3 timed
> out on the XO-1.5.

Just to update the list, the problem with the XO-1.5 was because the
sd8686 has an external reset gpio line which is currently being
manipulated manually by an out-of-tree kernel patch:

http://dev.laptop.org/git/olpc-2.6/commit/?h=3Dolpc-2.6.35&id=3De9bee72=
1fb0cc303286d1fe5df4930ce79b0b1e0

=2E.. which makes me wonder whether we really want to take that
MMC_CAP_RUNTIME_PM road. I'm not sure anymore.

We need a demonstrated hardware limitation before we take that
approach (or a setup which worked using vanilla kernels and now
doesn't), because frankly this MMC_CAP_RUNTIME_PM approach is
cumbersome and involving. I would not like to introduce it just to fix
out-of-tree software issues, and it seems that at least the XO-1.5
case can be cleanly solved by software (e.g. by letting the regulator
handle that sd8686 quirk).

I'm looping in Arnd, who reported similar problems with b43-sdio on
AP4EVB (arm) with tmio_mmc.

Arnd,

We're trying to exactly understand the reasons behind the reported
SDIO runtime pm failures (we had two, yours, and OLPC). So far it
seems that the OLPC had a software issue, and I'm wondering about
yours.

Can you please supply additional information about your board ? where
does your wifi card gets its power from ? is there an external gpio
involved ? Were you able to work with vanilla kernels (prior to
2.6.37) or do you carry some out-of-tree patches ?

Thanks,
Ohad.

>
> From 6b5691bdd8184cc0876d209c69d38844ea10f678 Mon Sep 17 00:00:00 200=
1
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Mon, 1 Nov 2010 09:41:44 +0200
> Subject: [PATCH] mmc: add MMC_CAP_RUNTIME_PM
>
> Some board/card/host configurations are not capable of powering off/o=
n
> on the card during runtime.
>
> To support such configurations, and to allow smoother transition to
> runtime PM behavior, MMC_CAP_RUNTIME_PM is added, so hosts need to
> explicitly indicate that it's OK to power off their cards after boot.
>
> This will prevent sdio_bus_probe() from failing to power on the card
> when the driver is loaded on such setups.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> =A0drivers/mmc/core/sdio.c =A0 =A0 | =A0 37 +++++++++++++++++++++++--=
------------
> =A0drivers/mmc/core/sdio_bus.c | =A0 33 ++++++++++++++++++++++-------=
----
> =A0include/linux/mmc/host.h =A0 =A0| =A0 =A01 +
> =A03 files changed, 46 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 6a9ad40..373d56d 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -547,9 +547,11 @@ static void mmc_sdio_detect(struct mmc_host *hos=
t)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0/* Make sure card is powered before detecting it */
> - =A0 =A0 =A0 err =3D pm_runtime_get_sync(&host->card->dev);
> - =A0 =A0 =A0 if (err < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D pm_runtime_get_sync(&host->card=
->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
>
> @@ -570,7 +572,8 @@ out:
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Tell PM core that we're done */
> - =A0 =A0 =A0 pm_runtime_put(&host->card->dev);
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&host->card->dev);
> =A0}
>
> =A0/*
> @@ -720,16 +723,21 @@ int mmc_attach_sdio(struct mmc_host *host, u32 =
ocr)
> =A0 =A0 =A0 =A0card =3D host->card;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Let runtime PM core know our card is active
> + =A0 =A0 =A0 =A0* Enable runtime PM only if supported by host+card+b=
oard
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 err =3D pm_runtime_set_active(&card->dev);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto remove;
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Let runtime PM core know our card =
is active
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D pm_runtime_set_active(&card->de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto remove;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Enable runtime PM for this card
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 pm_runtime_enable(&card->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable runtime PM for this card
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&card->dev);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The number of functions on the card is encoded insi=
de
> @@ -747,9 +755,10 @@ int mmc_attach_sdio(struct mmc_host *host, u32 o=
cr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Runtime PM for this func
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Runtime PM for this func (i=
f supported)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&card->sdio_func[i]->=
dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&card=
->sdio_func[i]->dev);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mmc_release_host(host);
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.=
c
> index 2716c7a..f3ce21b 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/pm_runtime.h>
>
> =A0#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> =A0#include <linux/mmc/sdio_func.h>
>
> =A0#include "sdio_cis.h"
> @@ -132,9 +133,11 @@ static int sdio_bus_probe(struct device *dev)
> =A0 =A0 =A0 =A0 * it should call pm_runtime_put_noidle() in its probe=
 routine and
> =A0 =A0 =A0 =A0 * pm_runtime_get_noresume() in its remove routine.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Set the default block size so the driver is sure it=
's something
> =A0 =A0 =A0 =A0 * sensible. */
> @@ -151,7 +154,8 @@ static int sdio_bus_probe(struct device *dev)
> =A0 =A0 =A0 =A0return 0;
>
> =A0disable_runtimepm:
> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
> =A0out:
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -160,12 +164,14 @@ static int sdio_bus_remove(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct sdio_driver *drv =3D to_sdio_driver(dev->driver=
);
> =A0 =A0 =A0 =A0struct sdio_func *func =3D dev_to_sdio_func(dev);
> - =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int ret =3D 0;
>
> =A0 =A0 =A0 =A0/* Make sure card is powered before invoking ->remove(=
) */
> - =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0drv->remove(func);
>
> @@ -178,10 +184,12 @@ static int sdio_bus_remove(struct device *dev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* First, undo the increment made directly above */
> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>
> =A0 =A0 =A0 =A0/* Then undo the runtime PM settings in sdio_bus_probe=
() */
> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>
> =A0out:
> =A0 =A0 =A0 =A0return ret;
> @@ -191,6 +199,8 @@ out:
>
> =A0static int sdio_bus_pm_prepare(struct device *dev)
> =A0{
> + =A0 =A0 =A0 struct sdio_func *func =3D dev_to_sdio_func(dev);
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Resume an SDIO device which was suspended at run ti=
me at this
> =A0 =A0 =A0 =A0 * point, in order to allow standard SDIO suspend/resu=
me paths
> @@ -212,7 +222,8 @@ static int sdio_bus_pm_prepare(struct device *dev=
)
> =A0 =A0 =A0 =A0 * since there is little point in failing system suspe=
nd if a
> =A0 =A0 =A0 =A0 * device can't be resumed.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 pm_runtime_resume(dev);
> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_resume(dev);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c3ffad8..e5eee0e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -167,6 +167,7 @@ struct mmc_host {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* DDR mode at 1.8V */
> =A0#define MMC_CAP_1_2V_DDR =A0 =A0 =A0 (1 << 12) =A0 =A0 =A0 /* can =
support */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* DDR mode at 1.2V */
> +#define MMC_CAP_RUNTIME_PM =A0 =A0 (1 << 13) =A0 =A0 =A0 /* Can powe=
r off/on in runtime */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> --
> 1.7.0.4
>
