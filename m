From: Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH V4] mmc: Set suspend/resume bus operations if
 CONFIG_PM_RUNTIME is used
Date: Wed, 11 Jan 2012 10:17:49 -0800
Message-ID: <CAH7ZN-yi-q=bX2SpKH1X39mO8Usoe0uSJQmx+k_KjSeHsUPwAA@mail.gmail.com>
References: <20120110181803.0200A3835E@ushik.mtv.corp.google.com>
	<CAGsJ_4wetB3SKDoBg7=qNxEYtOrT8UD59eVwYPKJ+gvb7d3gqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64538 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933820Ab2AKSRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 13:17:50 -0500
Received: by ghbg21 with SMTP id g21so471797ghb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2012 10:17:49 -0800 (PST)
In-Reply-To: <CAGsJ_4wetB3SKDoBg7=qNxEYtOrT8UD59eVwYPKJ+gvb7d3gqQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Bin Shi <bin.shi@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

On Tue, Jan 10, 2012 at 6:44 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/1/10 Dmitry Shmidt <dimitrysh@google.com>:
>> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>
> Hi Dmitry,
> after you move mmc_bus_suspend, mmc_bus_resume to dev_pm_ops, while
> doing hiberantion by swsusp, suspend/resume will not be called by the
> hibernation flow since it will move to call freeze/thaw/restore. if w=
e
> don't stop blk queue for SD while doing hibernation, SD card will han=
g
> in the processing of restoring system.
>
> pls note Bin's patch "mmc: core: move suspend/resume to dev_pm_ops an=
d
> add hibernation support"
> http://www.spinics.net/lists/linux-mmc/msg12007.html
> he has done some duplicated job with you except adding swsusp support=
=2E
>
> -barry

Hi Barry,

Definitely I didn't cover hibernation support.
Bin's patch resolves the problem I tried to address, so I am ok with
his version.

Thanks,

Dmitry

>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 =A04 ++--
>> =A0drivers/mmc/core/bus.c =A0 | =A0 25 ++++++++-----------------
>> =A0include/linux/mmc/card.h | =A0 =A02 +-
>> =A03 files changed, 11 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 1e0e27c..5724ae1 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1676,8 +1676,8 @@ static void mmc_blk_remove(struct mmc_card *ca=
rd)
>> =A0 =A0 =A0 =A0mmc_set_drvdata(card, NULL);
>> =A0}
>>
>> -#ifdef CONFIG_PM
>> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t stat=
e)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mmc_blk_suspend(struct mmc_card *card)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *part_md;
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mmc_get_drvdata(card);
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 6be4924..bf8ad29 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -122,14 +122,15 @@ static int mmc_bus_remove(struct device *dev)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mmc_bus_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_driver *drv =3D to_mmc_driver(dev->driver)=
;
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>> =A0 =A0 =A0 =A0int ret =3D 0;
>>
>> =A0 =A0 =A0 =A0if (dev->driver && drv->suspend)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card);
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> @@ -143,9 +144,9 @@ static int mmc_bus_resume(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D drv->resume(card);
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>> +#endif /* CONFIG_PM_SLEEP */
>>
>> =A0#ifdef CONFIG_PM_RUNTIME
>> -
>> =A0static int mmc_runtime_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>> @@ -164,21 +165,13 @@ static int mmc_runtime_idle(struct device *dev=
)
>> =A0{
>> =A0 =A0 =A0 =A0return pm_runtime_suspend(dev);
>> =A0}
>> +#endif /* CONFIG_PM_RUNTIME */
>>
>> =A0static const struct dev_pm_ops mmc_bus_pm_ops =3D {
>> - =A0 =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D mmc_runtime_suspen=
d,
>> - =A0 =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D mmc_runtime_resume=
,
>> - =A0 =A0 =A0 .runtime_idle =A0 =A0 =A0 =A0 =A0 =3D mmc_runtime_idle=
,
>> + =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resum=
e)
>> + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_re=
sume, mmc_runtime_idle)
>> =A0};
>>
>> -#define MMC_PM_OPS_PTR (&mmc_bus_pm_ops)
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
>> @@ -186,9 +179,7 @@ static struct bus_type mmc_bus_type =3D {
>> =A0 =A0 =A0 =A0.uevent =A0 =A0 =A0 =A0 =3D mmc_bus_uevent,
>> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D mmc_bus_probe,
>> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D mmc_bus_remove,
>> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D mmc_bus_suspend,
>> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D mmc_bus_resume,
>> - =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D MMC_PM_OPS_PTR,
>> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &mmc_bus_pm_ops,
>> =A0};
>>
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
>> --
>> 1.7.3.1
