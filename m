From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] mmc: implement Driver Stage Register handling
Date: Fri, 15 Aug 2014 20:42:44 +0200
Message-ID: <20140815184244.GJ5134@pengutronix.de>
References: <1408091882-32123-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAPDyKFp=1BDeZUC-GNLLT+BK0gqisQ0mP8x4chu43F2pKujGsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44408 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaHOSmy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Aug 2014 14:42:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=1BDeZUC-GNLLT+BK0gqisQ0mP8x4chu43F2pKujGsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Niebel <Markus.Niebel@tq-group.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

Hello Ulf,

On Fri, Aug 15, 2014 at 11:05:39AM +0200, Ulf Hansson wrote:
> On 15 August 2014 10:38, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Some eMMC and SD cards implement a DSR register that allows to tune
> > raise/fall times and drive strength of the CMD and DATA outputs.
> > The values to use depend on the card in use and the host.
> > It might be needed to reduce the drive strength to prevent voltage =
peaks
> > above the host's specification.
> >
> > Implement a 'dsr' devicetree property that allows to specify the va=
lue
> > to set the DSR to. For non-dt setups the new members of mmc_host ca=
n be
> > set by board code.
> >
> > This patch was initially authored by Sascha Hauer. It contains
> > improvements authored by Markus Niebel and Uwe Kleine-K=F6nig.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v3:
> >
> >  - fix a compiler warning about err not being used.
> >  - clearified valid range. I didn't write "16-bit value" because th=
e
> >    value is still expected to be written as 32-bit value in the dev=
ice
> >    tree.
> >  - make host->dsr an u32, which simplified parsing the device tree =
and
> >    also makes casting in mmc_set_dsr unnecessary.
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc.txt |  2 ++
> >  drivers/mmc/core/host.c                       |  8 ++++++++
> >  drivers/mmc/core/mmc.c                        |  8 ++++++++
> >  drivers/mmc/core/mmc_ops.c                    | 20 +++++++++++++++=
+++++
> >  drivers/mmc/core/mmc_ops.h                    |  1 +
> >  drivers/mmc/core/sd.c                         |  8 ++++++++
> >  include/linux/mmc/card.h                      |  3 ++-
> >  include/linux/mmc/host.h                      |  3 +++
> >  8 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Docume=
ntation/devicetree/bindings/mmc/mmc.txt
> > index 3c18001dfd5d..a3fe21f2b709 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> > @@ -40,6 +40,8 @@ Optional properties:
> >  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> >  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
> >  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
> > +- dsr: Value the card's (optional) Driver Stage Register (DSR) sho=
uld be
> > +  programmed with. Valid range: [0 .. 0xffff].
> >
> >  *NOTE* on CD and WP polarity. To use common for all SD/MMC host co=
ntrollers line
> >  polarity properties, we have to fix the meaning of the "normal" an=
d "inverted"
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 95cceae96944..6442eecb672e 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (of_find_property(np, "mmc-hs400-1_2v", &len))
> >                 host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS2=
00_1_2V_SDR;
> >
> > +       host->dsr_req =3D of_property_read_u32(np, "dsr", &host->ds=
r);
> > +       if (host->dsr_req && (host->dsr & ~0xffff)) {
>=20
> This doesn't look correct.
> I guess what you want is: if (!host->dsr_req && (host->dsr & ~0xffff)=
)
Ah, you're right. I thought that of_property_read_u32 returned true if
it worked and false if not. But it returns 0 for success and -ESOMETHIN=
G
otherwise.

So I want host->dsr_req =3D !of_property_read_u32(np, "dsr", &host->dsr=
);

I now have some working hardware again, will test again and send an v5.

>=20
> > +               dev_err(host->parent,
> > +                       "device tree specified broken value for DSR=
: 0x%x, ignoring\n",
> > +                       host->dsr);
> > +               host->dsr_req =3D 0;
> > +       }
> > +
> >         return 0;
> >
> >  out:
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 793c6f7ddb04..fdc1ac1360c4 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *card=
)
> >         csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
> >         csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
> >         csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
> > +       csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
> >         csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
> >         csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
> >         csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
> > @@ -1273,6 +1274,13 @@ static int mmc_init_card(struct mmc_host *ho=
st, u32 ocr,
> >         }
> >
> >         /*
> > +        * handling only for cards supporting DSR and hosts request=
ing
> > +        * DSR configuration
> > +        */
> > +       if (card->csd.dsr_imp && host->dsr_req)
>=20
> if (card->csd.dsr_imp && !host->dsr_req)
With the above change my line is correct.

> >  struct mmc_ext_csd {
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 7960424d0bc0..8acaebd866a7 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -319,6 +319,7 @@ struct mmc_host {
> >  #ifdef CONFIG_MMC_DEBUG
> >         unsigned int            removed:1;      /* host is being re=
moved */
> >  #endif
> > +       unsigned int            dsr_req:1;      /* DSR is requested=
 for Host */
>=20
> Should be an int instead.
I don't care much, can change to int.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
