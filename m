From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 14:49:51 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C3317FA311@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
 <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2CVOuI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 10:50:08 -0400
In-Reply-To: <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 22, 2012 at 19:57:16, S, Venkatraman wrote:
> On Thu, Mar 22, 2012 at 6:50 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com=
> wrote:
> > On Thu, Mar 22, 2012 at 09:53:23, Bedia, Vaibhav wrote:
> >> Hi,
> >>
> >> I am trying to do suspend-resume test with a file copy on MMC/SD g=
oing on
> >> in the background. The test involves simply copying a 450MB file o=
n an ext3
> >> partition to the same partition under a different name.
> >>
> >> This is on an AM335x board which uses the omap_hsmmc driver.
> >> The kernel is v3.2 and I have also applied the following patch
> >>
> >
> > [...]
> >
> > I found that whenever this issue crops up, mmc_host_suspend() is no=
t able to claim the host
> > And returns -EBUSY. omap_hsmmc driver does not pass on this error c=
ode to the PM core and
> > hence the suspend process continues. When the driver is made to ret=
urn -EBUSY, the suspend
> > process gets aborted and the user can try suspending again. I am no=
t sure whether this sort
> > of suspend failure is acceptable or the driver is doing something w=
rong. The following
> > workaround is what I came up with. Do this look a reasonable thing =
to do?
> >
> > ---
> >
> > From a4040dd1869b351a5fa29dacd08facf6e24df609 Mon Sep 17 00:00:00 2=
001
> > From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Date: Thu, 22 Mar 2012 17:14:49 +0530
> > Subject: [PATCH 1/1] mmc: omap_hsmmc: Pass on the suspend failure t=
o the PM core
> >
> > In some cases mmc_host_suspend() is not able to claim the
> > host and proceed with the suspend process. The core returns
> > -EBUSY to the host controller driver. Unfortunately, the
> > host controller driver does not pass on this information
> > to the PM core and hence the system suspend process continues.
> >
> > In these cases the MMC core gets to an unexpected state
> > during resume and multiple issues related to MMC crop up.
> > 1. Host controller driver starts accessing the device registers
> > before the clocks are enabled which leads to a prefetch abort.
> > 2. A file copy thread which was launched before suspend gets
> > stuck due to the host not being reclaimed during resume.
> >
> > To avoid such problems pass on the -EBUSY status to the PM core
> > from the host controller driver. With this change, MMC core
> > suspend might still fail but it does not end up making the
> > system unusable. Suspend gets aborted and the user can try
> > suspending the system again.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > ---
> > =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 +
> > =A01 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
> > index 3d8dbbb..1f938d9 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2238,6 +2238,7 @@ static int omap_hsmmc_suspend(struct device *=
dev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unmask interrupt failed\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >
> > --
> > 1.7.0.4
>=20
> I see (in 3.3) that the host controller driver does a "return ret" an=
d
> that means the errors is propagated.
> Where is the return code lost /overridden ?

As seen from http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux=
-2.6.git;a=3Dblob;f=3Ddrivers/mmc/host/omap_hsmmc.c;h=3Dfd0c661bbad38a7=
152a37955146ff6068d4d7137;hb=3Drefs/tags/v3.3

omap_hsmmc.c=20

@ 2045

pdata->resume =3D omap_hsmmc_resume_cdirq;


@227

static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
{
        struct omap_mmc_platform_data *mmc =3D dev->platform_data;

        enable_irq(mmc->slots[0].card_detect_irq);
        return 0;							-----> always return 0
}

@2167

                        if (host->pdata->resume) {
                                ret =3D host->pdata->resume(&pdev->dev,=
		--> ret becomes zero irrespective of its previous value.
                                                          host->slot_id=
);
                                if (ret)
                                        dev_dbg(mmc_dev(host->mmc),
                                                "Unmask interrupt faile=
d\n");
                        }


>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20


Regards,=20
Gururaja
