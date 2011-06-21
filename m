From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Tue, 21 Jun 2011 10:13:03 +0900
Message-ID: <20110621011257.GD16230@verge.net.au>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
 <1308610812-3479-4-git-send-email-horms@verge.net.au>
 <BANLkTikh9D=uaGmZ5BCMPmESexjDSczwhg@mail.gmail.com>
 <20110621005020.GB16230@verge.net.au>
 <BANLkTimRUnaMtk_zhLAquAKQre4E8ZJUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimRUnaMtk_zhLAquAKQre4E8ZJUJQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2011 at 09:59:37AM +0900, Magnus Damm wrote:
> On Tue, Jun 21, 2011 at 9:50 AM, Simon Horman <horms@verge.net.au> wr=
ote:
> > On Tue, Jun 21, 2011 at 09:36:03AM +0900, Magnus Damm wrote:
> >> On Tue, Jun 21, 2011 at 8:00 AM, Simon Horman <horms@verge.net.au>=
 wrote:

[snip]

> >> > index 5a90266..0dc9804 100644
> >> > --- a/include/linux/mfd/tmio.h
> >> > +++ b/include/linux/mfd/tmio.h
> >> > @@ -94,6 +101,7 @@ struct tmio_mmc_data {
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*set_pwr)(struct platform_devic=
e *host, int state);
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*set_clk_div)(struct platform_d=
evice *host, int state);
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*get_cd)(struct platform_device =
*host);
> >> > + =C2=A0 =C2=A0 =C2=A0 int (*write16_hook)(struct tmio_mmc_host =
*host, int addr);
> >> > =C2=A0};
> >> >
> >> > =C2=A0static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data=
 *pdata)
> >>
> >> What's the reason behind passing "struct tmio_mmc_host *" =C2=A0as=
 an
> >> argument to the new hook? Performance? All other callbacks seem to
> >> take a "struct platform_device *", so being consistent here may be
> >> good unless it comes with too much overhead.
> >
> > The reason is that
> > 1) The hook is called from sd_ctrl_write16 which takes
> > =C2=A0 struct tmio_mmc_host * as its first argument and;
> > 2) The hook that has been implemented calls sd_ctrl_read16() which =
takes a
> > =C2=A0 struct tmio_mmc_host * as its first argument.
> > So it seemed logical to pass that down.
> >
> > In the caes of 1) we can get the struct platform_device * using hos=
t->pdev.
> > However, in the case of 2) is it less clear to me how we can get th=
e
> > struct tmio_mmc_host * from a struct platform_device *.
>=20
> Have a look at the code in tmio_mmc_host_suspend() for some code that
> does struct device * -> struct tmio_mmc_host *:
> int tmio_mmc_host_suspend(struct device *dev)
> {
> 	struct mmc_host *mmc =3D dev_get_drvdata(dev);
> 	struct tmio_mmc_host *host =3D mmc_priv(mmc);
>=20
> You can easily change the dev_get_drvdata() to platform_get_drvdata()=
,
> see include/linux/platform_device.h

Thanks, I'm happy to make that change if you think it is worth it.
(I will need to re-test on AG5, which I could do this afternoon
 if it is free)

> I guess a similar conversion can be done in tmio_mmc_enable_dma() to
> move from writew() to sd_ctrl_write16()?

Are you proposing changing tmio_mmc_enable_dma() to take
a struct platform_device * as its first argument?

tmio_mmc_enable_dma() is already altered in one of the
patches in this series to use sd_ctrl_write16() without
altering the arguments taht tmio_mmc_enable_dma() takes.

static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable=
)
{
#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
	/* Switch DMA mode on or off - SuperH specific? */
	sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
#endif
}
