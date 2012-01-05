From: Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH V2] mmc: Set suspend/resume bus operations if
 CONFIG_PM_RUNTIME is used
Date: Thu, 5 Jan 2012 12:32:28 -0800
Message-ID: <CAH7ZN-ypnEiAycrGKdDzn9+W6yrYp8GEs=NmwDfAYCQnBH3ioA@mail.gmail.com>
References: <20120103231445.9CA943835D@ushik.mtv.corp.google.com>
	<4F043C25.2020305@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62762 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758290Ab2AEUc3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 15:32:29 -0500
Received: by yenm11 with SMTP id m11so384278yen.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2012 12:32:29 -0800 (PST)
In-Reply-To: <4F043C25.2020305@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Jan 4, 2012 at 3:46 AM, Ulf Hansson <ulf.hansson@stericsson.com=
> wrote:
> Dmitry Shmidt wrote:
>>
>> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 =A02 +-
>> =A0drivers/mmc/core/bus.c =A0 | =A0 25 +++++++------------------
>> =A0include/linux/mmc/card.h | =A0 =A02 +-
>> =A03 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 1e0e27c..969d49b 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1677,7 +1677,7 @@ static void mmc_blk_remove(struct mmc_card *ca=
rd)
>> =A0}
>> =A0#ifdef CONFIG_PM
>
>
> Should not this be:
> #ifdef CONFIG_PM_SLEEP

No, I didn't change this code.  #ifdef CONFIG_PM is original line.

>
>
>
>> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t stat=
e)
>> +static int mmc_blk_suspend(struct mmc_card *card)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *part_md;
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mmc_get_drvdata(card);
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 6be4924..13ca498 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -122,18 +122,18 @@ static int mmc_bus_remove(struct device *dev)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>
>
> Should we not add #ifdef CONFIG_PM_SLEEP around mmc_bus_pm_resume|sus=
pend
> below as well?
>

No, v3.2-rc7 code is using CONFIG_PM. Am I missing something ?

>
>> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
>> +static int mmc_bus_pm_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_driver *drv =3D to_mmc_driver(dev->driver)=
;
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>> =A0 =A0 =A0 =A0int ret =3D 0;
>> =A0 =A0 =A0 =A0if (dev->driver && drv->suspend)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card);
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>> =A0-static int mmc_bus_resume(struct device *dev)
>> +static int mmc_bus_pm_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_driver *drv =3D to_mmc_driver(dev->driver)=
;
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>> @@ -145,7 +145,6 @@ static int mmc_bus_resume(struct device *dev)
>> =A0}
>> =A0#ifdef CONFIG_PM_RUNTIME
>> -
>> =A0static int mmc_runtime_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>> @@ -164,21 +163,13 @@ static int mmc_runtime_idle(struct device *dev=
)
>> =A0{
>> =A0 =A0 =A0 =A0return pm_runtime_suspend(dev);
>> =A0}
>
>
> While you are doing this clean up, you could also remove the
> mmc_runtime_idle function and instead directly in SET_RUNTIME_PM_OPS =
use
> pm_generic_runtime_idle, which will do the same thing.
>
>
>> +#endif /* CONFIG_PM_RUNTIME */
>> =A0static const struct dev_pm_ops mmc_bus_pm_ops =3D {
>> - =A0 =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D mmc_runtime_suspen=
d,
>> - =A0 =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D mmc_runtime_resume=
,
>> - =A0 =A0 =A0 .runtime_idle =A0 =A0 =A0 =A0 =A0 =3D mmc_runtime_idle=
,
>> + =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_pm_suspend, mmc_bus_pm=
_resume)
>> + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_re=
sume,
>> mmc_runtime_idle)
>> =A0};
>> =A0-#define MMC_PM_OPS_PTR =A0 =A0 =A0 =A0(&mmc_bus_pm_ops)
>> -
>> -#else /* !CONFIG_PM_RUNTIME */
>> -
>> -#define MMC_PM_OPS_PTR NULL
>> -
>> -#endif /* !CONFIG_PM_RUNTIME */
>> -
>> =A0static struct bus_type mmc_bus_type =3D {
>> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mmc",
>> =A0 =A0 =A0 =A0.dev_attrs =A0 =A0 =A0=3D mmc_dev_attrs,
>> @@ -186,9 +177,7 @@ static struct bus_type mmc_bus_type =3D {
>> =A0 =A0 =A0 =A0.uevent =A0 =A0 =A0 =A0 =3D mmc_bus_uevent,
>> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D mmc_bus_probe,
>> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D mmc_bus_remove,
>> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D mmc_bus_suspend,
>> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D mmc_bus_resume,
>> - =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D MMC_PM_OPS_PTR,
>> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &mmc_bus_pm_ops,
>> =A0};
>> =A0int mmc_register_bus(void)
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index c8ef9bc..80caf1d 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -455,7 +455,7 @@ struct mmc_driver {
>> =A0 =A0 =A0 =A0struct device_driver drv;
>> =A0 =A0 =A0 =A0int (*probe)(struct mmc_card *);
>> =A0 =A0 =A0 =A0void (*remove)(struct mmc_card *);
>> - =A0 =A0 =A0 int (*suspend)(struct mmc_card *, pm_message_t);
>> + =A0 =A0 =A0 int (*suspend)(struct mmc_card *);
>> =A0 =A0 =A0 =A0int (*resume)(struct mmc_card *);
>> =A0};
>>
>
>
> Br
> Ulf Hansson
