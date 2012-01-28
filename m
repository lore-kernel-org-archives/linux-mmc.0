From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V4] mmc: Set suspend/resume bus operations if
 CONFIG_PM_RUNTIME is used
Date: Sat, 28 Jan 2012 22:32:26 +0800
Message-ID: <CAGsJ_4wJuRH2rmAxpnAMARB6u6+wd0auTzNZoVk7mW4Yg6ucbw@mail.gmail.com>
References: <20120110181803.0200A3835E@ushik.mtv.corp.google.com>
 <CAGsJ_4wetB3SKDoBg7=qNxEYtOrT8UD59eVwYPKJ+gvb7d3gqQ@mail.gmail.com> <CAH7ZN-yi-q=bX2SpKH1X39mO8Usoe0uSJQmx+k_KjSeHsUPwAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33071 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2A1Ocs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Jan 2012 09:32:48 -0500
Received: by bkas6 with SMTP id s6so2129752bka.19
        for <linux-mmc@vger.kernel.org>; Sat, 28 Jan 2012 06:32:46 -0800 (PST)
In-Reply-To: <CAH7ZN-yi-q=bX2SpKH1X39mO8Usoe0uSJQmx+k_KjSeHsUPwAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: linux-mmc@vger.kernel.org, Bin Shi <bin.shi@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2012/1/12 Dmitry Shmidt <dimitrysh@google.com>
>
> On Tue, Jan 10, 2012 at 6:44 PM, Barry Song <21cnbao@gmail.com> wrote=
:
> > 2012/1/10 Dmitry Shmidt <dimitrysh@google.com>:
> >> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
> >
> > Hi Dmitry,
> > after you move mmc_bus_suspend, mmc_bus_resume to dev_pm_ops, while
> > doing hiberantion by swsusp, suspend/resume will not be called by t=
he
> > hibernation flow since it will move to call freeze/thaw/restore. if=
 we
> > don't stop blk queue for SD while doing hibernation, SD card will h=
ang
> > in the processing of restoring system.
> >
> > pls note Bin's patch "mmc: core: move suspend/resume to dev_pm_ops =
and
> > add hibernation support"
> > http://www.spinics.net/lists/linux-mmc/msg12007.html
> > he has done some duplicated job with you except adding swsusp suppo=
rt.
> >
> > -barry
>
> Hi Barry,
>
> Definitely I didn't cover hibernation support.
> Bin's patch resolves the problem I tried to address, so I am ok with
> his version.

i think maybe merging yours and bin's is better. i'd like to send v4
with your and bin's sob and think you as the author of the patch.
at least, SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS are better use=
d.

>
> Thanks,
>
> Dmitry
>
> >
> >> ---
> >> =C2=A0drivers/mmc/card/block.c | =C2=A0 =C2=A04 ++--
> >> =C2=A0drivers/mmc/core/bus.c =C2=A0 | =C2=A0 25 ++++++++----------=
-------
> >> =C2=A0include/linux/mmc/card.h | =C2=A0 =C2=A02 +-
> >> =C2=A03 files changed, 11 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >> index 1e0e27c..5724ae1 100644
> >> --- a/drivers/mmc/card/block.c
> >> +++ b/drivers/mmc/card/block.c
> >> @@ -1676,8 +1676,8 @@ static void mmc_blk_remove(struct mmc_card *=
card)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_set_drvdata(card, NULL);
> >> =C2=A0}
> >>
> >> -#ifdef CONFIG_PM
> >> -static int mmc_blk_suspend(struct mmc_card *card, pm_message_t st=
ate)
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int mmc_blk_suspend(struct mmc_card *card)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *part_md;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md =3D mmc_get_drv=
data(card);
> >> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> >> index 6be4924..bf8ad29 100644
> >> --- a/drivers/mmc/core/bus.c
> >> +++ b/drivers/mmc/core/bus.c
> >> @@ -122,14 +122,15 @@ static int mmc_bus_remove(struct device *dev=
)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> >> =C2=A0}
> >>
> >> -static int mmc_bus_suspend(struct device *dev, pm_message_t state=
)
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int mmc_bus_suspend(struct device *dev)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_driver *drv =3D to_mmc_drive=
r(dev->driver);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_card *card =3D mmc_dev_to_ca=
rd(dev);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->driver && drv->suspend)
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv->su=
spend(card, state);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv->su=
spend(card);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> >> =C2=A0}
> >>
> >> @@ -143,9 +144,9 @@ static int mmc_bus_resume(struct device *dev)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drv=
->resume(card);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> >> =C2=A0}
> >> +#endif /* CONFIG_PM_SLEEP */
> >>
> >> =C2=A0#ifdef CONFIG_PM_RUNTIME
> >> -
> >> =C2=A0static int mmc_runtime_suspend(struct device *dev)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_card *card =3D mmc_dev_to_ca=
rd(dev);
> >> @@ -164,21 +165,13 @@ static int mmc_runtime_idle(struct device *d=
ev)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pm_runtime_suspend(dev);
> >> =C2=A0}
> >> +#endif /* CONFIG_PM_RUNTIME */
> >>
> >> =C2=A0static const struct dev_pm_ops mmc_bus_pm_ops =3D {
> >> - =C2=A0 =C2=A0 =C2=A0 .runtime_suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D mmc_runtime_suspend,
> >> - =C2=A0 =C2=A0 =C2=A0 .runtime_resume =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D mmc_runtime_resume,
> >> - =C2=A0 =C2=A0 =C2=A0 .runtime_idle =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D mmc_runtime_idle,
> >> + =C2=A0 =C2=A0 =C2=A0 SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mm=
c_bus_resume)
> >> + =C2=A0 =C2=A0 =C2=A0 SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc=
_runtime_resume, mmc_runtime_idle)
> >> =C2=A0};
> >>
> >> -#define MMC_PM_OPS_PTR (&mmc_bus_pm_ops)
> >> -
> >> -#else /* !CONFIG_PM_RUNTIME */
> >> -
> >> -#define MMC_PM_OPS_PTR NULL
> >> -
> >> -#endif /* !CONFIG_PM_RUNTIME */
> >> -
> >> =C2=A0static struct bus_type mmc_bus_type =3D {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D "mmc",
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev_attrs =C2=A0 =C2=A0 =C2=A0=3D mmc_=
dev_attrs,
> >> @@ -186,9 +179,7 @@ static struct bus_type mmc_bus_type =3D {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0.uevent =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 mmc_bus_uevent,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D mmc_bus_probe,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 mmc_bus_remove,
> >> - =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mmc=
_bus_suspend,
> >> - =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D mmc=
_bus_resume,
> >> - =C2=A0 =C2=A0 =C2=A0 .pm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D MMC_PM_OPS_PTR,
> >> + =C2=A0 =C2=A0 =C2=A0 .pm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D &mmc_bus_pm_ops,
> >> =C2=A0};
> >>
> >> =C2=A0int mmc_register_bus(void)
> >> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >> index c8ef9bc..80caf1d 100644
> >> --- a/include/linux/mmc/card.h
> >> +++ b/include/linux/mmc/card.h
> >> @@ -455,7 +455,7 @@ struct mmc_driver {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_driver drv;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*probe)(struct mmc_card *);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*remove)(struct mmc_card *);
> >> - =C2=A0 =C2=A0 =C2=A0 int (*suspend)(struct mmc_card *, pm_messag=
e_t);
> >> + =C2=A0 =C2=A0 =C2=A0 int (*suspend)(struct mmc_card *);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*resume)(struct mmc_card *);
> >> =C2=A0};
> >>
> >> --
> >> 1.7.3.1

-barry
