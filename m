From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Wed, 17 Nov 2010 00:26:31 +0200
Message-ID: <AANLkTi=15cX_3_Ud6ELJBpSKvoQ+tK8xH0y_7==pgARe@mail.gmail.com>
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
 <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
 <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
 <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
 <4CE2BC95.5030605@nets.rwth-aachen.de> <AANLkTi=zt+22P-sE8quU_J78Hpi3zg6xnz5VE+Dy-iLJ@mail.gmail.com>
 <4CE2F4A2.1000006@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48299 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0KPW0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 17:26:53 -0500
Received: by iwn35 with SMTP id 35so1335945iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 14:26:52 -0800 (PST)
In-Reply-To: <4CE2F4A2.1000006@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Nov 16, 2010 at 11:16 PM, Arnd Hannemann <arnd@arndnet.de> wrot=
e:
> Yes, just plugged it in. No extra wire whatsover.

I wonder - when you suspend/resume the host, with that card plugged
in, do you see any errors (particularly in the resume phase) ?

After suspend/resume was completed, can you still work with that card
(wlan is still functional) ?

I'm asking because SDIO suspend/resume is very similar to what the new
2.6.37-rc1 SDIO runtime pm code does.

Thanks,
Ohad.

>
> Regards,
> Arnd
>
>> Thanks!
>> Ohad.
>>
>>
>>> I was able to work with 2.6.35 and .36 plus some out-of-tree patche=
s
>>> for the sh_mobile_sdhi mfd, which are now in mainline:
>>> mmc: Allow 2 byte requests in 4-bit mode for tmio_mmc
>>> tmio_mmc: don't clear unhandled pending interrupts
>>> tmio_mmc: don't clear unhandled pending interrupts
>>>
>>>
>>>>> From 6b5691bdd8184cc0876d209c69d38844ea10f678 Mon Sep 17 00:00:00=
 2001
>>>>> From: Ohad Ben-Cohen <ohad@wizery.com>
>>>>> Date: Mon, 1 Nov 2010 09:41:44 +0200
>>>>> Subject: [PATCH] mmc: add MMC_CAP_RUNTIME_PM
>>>>>
>>>>> Some board/card/host configurations are not capable of powering o=
ff/on
>>>>> on the card during runtime.
>>>>>
>>>>> To support such configurations, and to allow smoother transition =
to
>>>>> runtime PM behavior, MMC_CAP_RUNTIME_PM is added, so hosts need t=
o
>>>>> explicitly indicate that it's OK to power off their cards after b=
oot.
>>>>>
>>>>> This will prevent sdio_bus_probe() from failing to power on the c=
ard
>>>>> when the driver is loaded on such setups.
>>>>>
>>>>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>>>>> ---
>>>>> =A0drivers/mmc/core/sdio.c =A0 =A0 | =A0 37 +++++++++++++++++++++=
++--------------
>>>>> =A0drivers/mmc/core/sdio_bus.c | =A0 33 ++++++++++++++++++++++---=
--------
>>>>> =A0include/linux/mmc/host.h =A0 =A0| =A0 =A01 +
>>>>> =A03 files changed, 46 insertions(+), 25 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>>>> index 6a9ad40..373d56d 100644
>>>>> --- a/drivers/mmc/core/sdio.c
>>>>> +++ b/drivers/mmc/core/sdio.c
>>>>> @@ -547,9 +547,11 @@ static void mmc_sdio_detect(struct mmc_host =
*host)
>>>>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Make sure card is powered before detecting it *=
/
>>>>> - =A0 =A0 =A0 err =3D pm_runtime_get_sync(&host->card->dev);
>>>>> - =A0 =A0 =A0 if (err < 0)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D pm_runtime_get_sync(&host->=
card->dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>>>>
>>>>> @@ -570,7 +572,8 @@ out:
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Tell PM core that we're done */
>>>>> - =A0 =A0 =A0 pm_runtime_put(&host->card->dev);
>>>>> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&host->card->dev);
>>>>> =A0}
>>>>>
>>>>> =A0/*
>>>>> @@ -720,16 +723,21 @@ int mmc_attach_sdio(struct mmc_host *host, =
u32 ocr)
>>>>> =A0 =A0 =A0 =A0card =3D host->card;
>>>>>
>>>>> =A0 =A0 =A0 =A0/*
>>>>> - =A0 =A0 =A0 =A0* Let runtime PM core know our card is active
>>>>> + =A0 =A0 =A0 =A0* Enable runtime PM only if supported by host+ca=
rd+board
>>>>> =A0 =A0 =A0 =A0 */
>>>>> - =A0 =A0 =A0 err =3D pm_runtime_set_active(&card->dev);
>>>>> - =A0 =A0 =A0 if (err)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto remove;
>>>>> + =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Let runtime PM core know our c=
ard is active
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D pm_runtime_set_active(&card=
->dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto remove;
>>>>>
>>>>> - =A0 =A0 =A0 /*
>>>>> - =A0 =A0 =A0 =A0* Enable runtime PM for this card
>>>>> - =A0 =A0 =A0 =A0*/
>>>>> - =A0 =A0 =A0 pm_runtime_enable(&card->dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable runtime PM for this car=
d
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&card->dev);
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 * The number of functions on the card is encoded =
inside
>>>>> @@ -747,9 +755,10 @@ int mmc_attach_sdio(struct mmc_host *host, u=
32 ocr)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove;
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Runtime PM for this fun=
c
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Runtime PM for this fun=
c (if supported)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&card->sdio_func[=
i]->dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->caps & MMC_CAP_RUNTIME_PM=
)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&=
card->sdio_func[i]->dev);
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>>>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_=
bus.c
>>>>> index 2716c7a..f3ce21b 100644
>>>>> --- a/drivers/mmc/core/sdio_bus.c
>>>>> +++ b/drivers/mmc/core/sdio_bus.c
>>>>> @@ -17,6 +17,7 @@
>>>>> =A0#include <linux/pm_runtime.h>
>>>>>
>>>>> =A0#include <linux/mmc/card.h>
>>>>> +#include <linux/mmc/host.h>
>>>>> =A0#include <linux/mmc/sdio_func.h>
>>>>>
>>>>> =A0#include "sdio_cis.h"
>>>>> @@ -132,9 +133,11 @@ static int sdio_bus_probe(struct device *dev=
)
>>>>> =A0 =A0 =A0 =A0 * it should call pm_runtime_put_noidle() in its p=
robe routine and
>>>>> =A0 =A0 =A0 =A0 * pm_runtime_get_noresume() in its remove routine=
=2E
>>>>> =A0 =A0 =A0 =A0 */
>>>>> - =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
>>>>> - =A0 =A0 =A0 if (ret < 0)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Set the default block size so the driver is sur=
e it's something
>>>>> =A0 =A0 =A0 =A0 * sensible. */
>>>>> @@ -151,7 +154,8 @@ static int sdio_bus_probe(struct device *dev)
>>>>> =A0 =A0 =A0 =A0return 0;
>>>>>
>>>>> =A0disable_runtimepm:
>>>>> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>> =A0out:
>>>>> =A0 =A0 =A0 =A0return ret;
>>>>> =A0}
>>>>> @@ -160,12 +164,14 @@ static int sdio_bus_remove(struct device *d=
ev)
>>>>> =A0{
>>>>> =A0 =A0 =A0 =A0struct sdio_driver *drv =3D to_sdio_driver(dev->dr=
iver);
>>>>> =A0 =A0 =A0 =A0struct sdio_func *func =3D dev_to_sdio_func(dev);
>>>>> - =A0 =A0 =A0 int ret;
>>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Make sure card is powered before invoking ->rem=
ove() */
>>>>> - =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
>>>>> - =A0 =A0 =A0 if (ret < 0)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(dev);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0 =A0 =A0 =A0drv->remove(func);
>>>>>
>>>>> @@ -178,10 +184,12 @@ static int sdio_bus_remove(struct device *d=
ev)
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0/* First, undo the increment made directly above *=
/
>>>>> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Then undo the runtime PM settings in sdio_bus_p=
robe() */
>>>>> - =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>>>>>
>>>>> =A0out:
>>>>> =A0 =A0 =A0 =A0return ret;
>>>>> @@ -191,6 +199,8 @@ out:
>>>>>
>>>>> =A0static int sdio_bus_pm_prepare(struct device *dev)
>>>>> =A0{
>>>>> + =A0 =A0 =A0 struct sdio_func *func =3D dev_to_sdio_func(dev);
>>>>> +
>>>>> =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 * Resume an SDIO device which was suspended at ru=
n time at this
>>>>> =A0 =A0 =A0 =A0 * point, in order to allow standard SDIO suspend/=
resume paths
>>>>> @@ -212,7 +222,8 @@ static int sdio_bus_pm_prepare(struct device =
*dev)
>>>>> =A0 =A0 =A0 =A0 * since there is little point in failing system s=
uspend if a
>>>>> =A0 =A0 =A0 =A0 * device can't be resumed.
>>>>> =A0 =A0 =A0 =A0 */
>>>>> - =A0 =A0 =A0 pm_runtime_resume(dev);
>>>>> + =A0 =A0 =A0 if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_resume(dev);
>>>>>
>>>>> =A0 =A0 =A0 =A0return 0;
>>>>> =A0}
>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>> index c3ffad8..e5eee0e 100644
>>>>> --- a/include/linux/mmc/host.h
>>>>> +++ b/include/linux/mmc/host.h
>>>>> @@ -167,6 +167,7 @@ struct mmc_host {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DDR mode at 1.8V */
>>>>> =A0#define MMC_CAP_1_2V_DDR =A0 =A0 =A0 (1 << 12) =A0 =A0 =A0 /* =
can support */
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DDR mode at 1.2V */
>>>>> +#define MMC_CAP_RUNTIME_PM =A0 =A0 (1 << 13) =A0 =A0 =A0 /* Can =
power off/on in runtime */
>>>>>
>>>>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0=
 =A0 =A0/* supported pm features */
>>>>>
>>>>> --
>>>>> 1.7.0.4
>>>>>
>>>>>
>>>>>
>>>
>>>
>>
>
>
