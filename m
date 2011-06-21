From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Tue, 21 Jun 2011 09:50:30 +0900
Message-ID: <20110621005020.GB16230@verge.net.au>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
 <1308610812-3479-4-git-send-email-horms@verge.net.au>
 <BANLkTikh9D=uaGmZ5BCMPmESexjDSczwhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikh9D=uaGmZ5BCMPmESexjDSczwhg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2011 at 09:36:03AM +0900, Magnus Damm wrote:
> On Tue, Jun 21, 2011 at 8:00 AM, Simon Horman <horms@verge.net.au> wr=
ote:
> > Some controllers require waiting for the bus to become idle
> > before writing to some registers. I have implemented this
> > by adding a hook to sd_ctrl_write16() and implementing
> > a hook for SDHI which waits for the bus to become idle.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> >
> > Dependencies: "mmc: tmio: Share register access functions"
> >
> > v2:
> > * Include linux/delay.h instead of asm/delay.h
> > * Skip write if sh_mobile_sdhi_wait_idle() times out
> > =C2=A0- The bus will probably be in an inconsistent state and writi=
ng
> > =C2=A0 =C2=A0may lock up the bus
> > * Only set hook if TMIO_MMC_HAS_IDLE_WAIT is set in platform data
> > =C2=A0rather than checking for TMIO_MMC_HAS_IDLE_WAIT each time the
> > =C2=A0hook is called.
> > ---
>=20
> Thanks Simon, this version looks much better!
>=20
> > index 5a90266..0dc9804 100644
> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -94,6 +101,7 @@ struct tmio_mmc_data {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*set_pwr)(struct platform_device *=
host, int state);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*set_clk_div)(struct platform_devi=
ce *host, int state);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*get_cd)(struct platform_device *ho=
st);
> > + =C2=A0 =C2=A0 =C2=A0 int (*write16_hook)(struct tmio_mmc_host *ho=
st, int addr);
> > =C2=A0};
> >
> > =C2=A0static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *p=
data)
>=20
> What's the reason behind passing "struct tmio_mmc_host *"  as an
> argument to the new hook? Performance? All other callbacks seem to
> take a "struct platform_device *", so being consistent here may be
> good unless it comes with too much overhead.

The reason is that
1) The hook is called from sd_ctrl_write16 which takes=20
   struct tmio_mmc_host * as its first argument and;
2) The hook that has been implemented calls sd_ctrl_read16() which take=
s a
   struct tmio_mmc_host * as its first argument.
So it seemed logical to pass that down.

In the caes of 1) we can get the struct platform_device * using host->p=
dev.
However, in the case of 2) is it less clear to me how we can get the
struct tmio_mmc_host * from a struct platform_device *.

