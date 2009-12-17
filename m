From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] tmio_mmc: keep card-detect interrupts enabled
Date: Thu, 17 Dec 2009 21:25:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0912172113510.5991@axis700.grange>
References: <Pine.LNX.4.64.0911061127240.4389@axis700.grange>
 <c09aa50a0911090242l35d0dfb2vec0cdeff8b86d33e@mail.gmail.com>
 <Pine.LNX.4.64.0911091530030.4289@axis700.grange>
 <c09aa50a0911091218i681449e0r5cb96b9db3e0def6@mail.gmail.com>
 <Pine.LNX.4.64.0911092134440.4289@axis700.grange>
 <c09aa50a0911091736k27d66483t9012e296bfbf578a@mail.gmail.com>
 <Pine.LNX.4.64.0911282002490.3696@axis700.grange>
 <Pine.LNX.4.64.0912162223170.5283@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764905AbZLQU0X@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0912162223170.5283@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Andrew

I originally submitted this [1] patch on the 6th of November, then=20
accidentally the MMC list got dropped from CC and the discussion moved =
to=20
another irrelevant list, Ian's last reply is at [2]. Unfortunately, Ian=
=20
hasn't replied to my reminders since then, and I don't see this patch=20
anywhere upstream. Is there any way we could get it into 2.6.33?

Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/704
[2] http://thread.gmane.org/gmane.linux.drivers.video-input-infrastruct=
ure/11981/focus=3D11995

On Wed, 16 Dec 2009, Guennadi Liakhovetski wrote:

> On Sat, 28 Nov 2009, Guennadi Liakhovetski wrote:
>=20
> > On Tue, 10 Nov 2009, Ian Molton wrote:
> >=20
> > > Well if they are only masked they shouldnt stop being asserted. B=
ut we
> > > should unmask them again.
> > >=20
> > > Im not really sure we should mask them anyway, with the card poss=
ibly
> > > being gone... Will need to look into it further.
> >=20
> > Hi Ian
> >=20
> > What's the status of this patch? Are you going to queue it for 2.6.=
33?
>=20
> Ian, ping? I still don't see this patch in any (Linus' / next) upstre=
am=20
> tree and the merge window will be closing soon. Any update?
>=20
> Thanks
> Guennadi
>=20
> >=20
> > Thanks
> > Guennadi
> >=20
> > >=20
> > > 2009/11/9 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > > > (re-adding accidentally dropped ML)
> > > >
> > > > On Mon, 9 Nov 2009, Ian Molton wrote:
> > > >
> > > >> Well, I presume we want to know when the card gets removed :)
> > > >
> > > > Sure, that's why we shouldn't mask those interrupts:-) If they =
do get
> > > > masked and missed, I do not know, if the interrupt remains pend=
ing in this
> > > > case, because they never get detected then:)
> > > >
> > > >>
> > > >> 2009/11/9 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > > >> > Hi Ian
> > > >> >
> > > >> > Why did you drop all CCs?
> > > >> >
> > > >> > On Mon, 9 Nov 2009, Ian Molton wrote:
> > > >> >
> > > >> >> I havent looked at the consequences for the driver if a ins=
ert IRQ
> > > >> >> occurs during IO, however it seems logical that we should n=
ot
> > > >> >> permanently mask the IRQ.
> > > >> >>
> > > >> >> I presume that the IRQ remains pending?
> > > >> >
> > > >> > Don't know, never checked. Is this important to know?
> > > >> >
> > > >> > Thanks
> > > >> > Guennadi
> > > >> >
> > > >> >>
> > > >> >> 2009/11/6 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > > >> >> > On SuperH platforms the SDHI controller does not produce =
any command IRQs
> > > >> >> > after a completed IO. This leads to card-detect interrupt=
s staying
> > > >> >> > disabled. Do not disable card-detect interrupts on DATA I=
RQs.
> > > >> >> >
> > > >> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.=
de>
> > > >> >> > ---
> > > >> >> >
> > > >> >> > Marked as RFC because I'm not really sure this is a corre=
ct approach to
> > > >> >> > fix this problem, and whether this will have negative eff=
ect on other
> > > >> >> > tmio_mmc MFD users.
> > > >> >> >
> > > >> >> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/ho=
st/tmio_mmc.h
> > > >> >> > index c676767..0b31d44 100644
> > > >> >> > --- a/drivers/mmc/host/tmio_mmc.h
> > > >> >> > +++ b/drivers/mmc/host/tmio_mmc.h
> > > >> >> > @@ -55,10 +55,8 @@
> > > >> >> > =A0/* Define some IRQ masks */
> > > >> >> > =A0/* This is the mask used at reset by the chip */
> > > >> >> > =A0#define TMIO_MASK_ALL =A0 =A0 =A0 =A0 =A0 0x837f031d
> > > >> >> > -#define TMIO_MASK_READOP =A0(TMIO_STAT_RXRDY | TMIO_STAT=
_DATAEND | \
> > > >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 TMIO_STAT_CARD_REMOVE | TMI=
O_STAT_CARD_INSERT)
> > > >> >> > -#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DA=
TAEND | \
> > > >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 TMIO_STAT_CARD_REMOVE | TMI=
O_STAT_CARD_INSERT)
> > > >> >> > +#define TMIO_MASK_READOP =A0(TMIO_STAT_RXRDY | TMIO_STAT=
_DATAEND)
> > > >> >> > +#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DA=
TAEND)
> > > >> >> > =A0#define TMIO_MASK_CMD =A0 =A0 (TMIO_STAT_CMDRESPEND | =
TMIO_STAT_CMDTIMEOUT | \
> > > >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TMIO_STAT_CARD_REMOVE | TM=
IO_STAT_CARD_INSERT)
> > > >> >> > =A0#define TMIO_MASK_IRQ =A0 =A0 (TMIO_MASK_READOP | TMIO=
_MASK_WRITEOP | TMIO_MASK_CMD)
> > > >
> > > > Thanks
> > > > Guennadi
> > > > ---
> > > > Guennadi Liakhovetski, Ph.D.
> > > > Freelance Open-Source Software Developer
> > > > http://www.open-technology.de/
> > > >
> > >=20
> > >=20
> > >=20
> > > --=20
> > > Ian Molton
> > > Linux, Automotive, and other hacking:
> > > http://www.mnementh.co.uk/
> > >=20
> >=20
> > ---
> > Guennadi Liakhovetski
> >=20
>=20
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>=20

---
Guennadi Liakhovetski
