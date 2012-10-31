From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed
 cards
Date: Wed, 31 Oct 2012 07:44:28 +0200
Message-ID: <20121031054428.GC6971@arwen.pp.htv.fi>
References: <1351515408-19403-1-git-send-email-gururaja.hebbar@ti.com>
 <20121029161719.GI27566@arwen.pp.htv.fi>
 <1BAFE6F6C881BF42822005164F1491C33EAB96FB@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EAB96FB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "S, Venkatraman" <svenkatr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 06:17:02AM +0100, Hebbar, Gururaja wrote:
> On Mon, Oct 29, 2012 at 21:47:19, Balbi, Felipe wrote:
> > Hi,
> >=20
> > On Mon, Oct 29, 2012 at 06:26:48PM +0530, Hebbar, Gururaja wrote:
> > > HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> > > Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> > > on the HSMMC IP timing closure done for the high speed cards.
> > >=20
> > > From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
> > >=20
> > > The MMC/SD/SDIO output signals can be driven on either falling edge or
> > > rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> > > to reach better timing performance, and thus to increase data transfer
> > > frequency.
> > >=20
> > > There are few pre-requisites for enabling the HSPE bit
> > > - Controller should support High-Speed-Enable Bit and
> > > - Controller should not be using DDR Mode and
> > > - Controller should advertise that it supports High Speed in
> > >   capabilities register and
> > > - MMC/SD clock coming out of controller > 25MHz
> > >=20
> > > Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > > ---
> > > Rebased on mmc-next (v3.7.0-rc1)
> > > Only Build tested since EDMA support for AM335x is not yet added
> > >=20
> > > :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindi=
ngs/mmc/ti-omap-hsmmc.txt
> > > :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/pla=
t/mmc.h
> > > :100644 100644 54bfd0c... 3fd95cb... M	drivers/mmc/host/omap_hsmmc.c
> > >  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
> > >  arch/arm/plat-omap/include/plat/mmc.h              |    1 +
> > >  drivers/mmc/host/omap_hsmmc.c                      |   30 ++++++++++=
+++++++++-
> > >  3 files changed, 31 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt =
b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > > index be76a23..ed271fc 100644
> > > --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > > @@ -19,6 +19,7 @@ ti,dual-volt: boolean, supports dual voltage cards
> > >  "supply-name" examples are "vmmc", "vmmc_aux" etc
> > >  ti,non-removable: non-removable slot (like eMMC)
> > >  ti,needs-special-reset: Requires a special softreset sequence
> > > +ti,needs-special-hs-handling: HSMMC IP needs special setting for han=
dling High Speed
> >=20
> > can't you do runtime revision detection for this ?
>=20
> Platforms like AM335x & TI814x both use the same IP.=20
> But only AM335x needed this bit to be set in order to sustain high
> speed transfers. This was concluded after AM335x HSMMC IP timing
> closure was completed for High speed Cards.

fair enough.

> > >  Example:
> > >  	mmc1: mmc@0x4809c000 {
> > > diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-om=
ap/include/plat/mmc.h
> > > index 8b4e4f2..346af5b 100644
> > > --- a/arch/arm/plat-omap/include/plat/mmc.h
> > > +++ b/arch/arm/plat-omap/include/plat/mmc.h
> > > @@ -126,6 +126,7 @@ struct omap_mmc_platform_data {
> > >  		/* we can put the features above into this variable */
> > >  #define HSMMC_HAS_PBIAS		(1 << 0)
> > >  #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
> > > +#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
> > >  		unsigned features;
> > > =20
> > >  		int switch_pin;			/* gpio (card detect) */
> > > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> > > index 54bfd0c..3fd95cb 100644
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -62,6 +62,7 @@
> > > =20
> > >  #define VS18			(1 << 26)
> > >  #define VS30			(1 << 25)
> > > +#define HSS			(1 << 21)
> > >  #define SDVS18			(0x5 << 9)
> > >  #define SDVS30			(0x6 << 9)
> > >  #define SDVS33			(0x7 << 9)
> > > @@ -89,6 +90,7 @@
> > >  #define MSBS			(1 << 5)
> > >  #define BCE			(1 << 1)
> > >  #define FOUR_BIT		(1 << 1)
> > > +#define HSPE			(1 << 2)
> > >  #define DDR			(1 << 19)
> > >  #define DW8			(1 << 5)
> > >  #define CC			0x1
> > > @@ -489,6 +491,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmm=
c_host *host)
> > >  	struct mmc_ios *ios =3D &host->mmc->ios;
> > >  	unsigned long regval;
> > >  	unsigned long timeout;
> > > +	unsigned long clkdiv;
> > > =20
> > >  	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
> > > =20
> > > @@ -496,7 +499,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmm=
c_host *host)
> > > =20
> > >  	regval =3D OMAP_HSMMC_READ(host->base, SYSCTL);
> > >  	regval =3D regval & ~(CLKD_MASK | DTO_MASK);
> > > -	regval =3D regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
> > > +	clkdiv =3D calc_divisor(host, ios);
> > > +	regval =3D regval | (clkdiv << 6) | (DTO << 16);
> >=20
> > not part of $SUBJECT
>=20
> The output of the calc_divisor() is reused in the below HSPE checking. So
> instead of calling it twice I have taken the output of that function into
> a variable and reused it.

looks like this could/should go into commit log ;-)

> > >  	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> > >  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> > >  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> > > @@ -507,6 +511,27 @@ static void omap_hsmmc_set_clock(struct omap_hsm=
mc_host *host)
> > >  		&& time_before(jiffies, timeout))
> > >  		cpu_relax();
> > > =20
> > > +	/*
> > > +	 * Enable High-Speed Support
> > > +	 * Pre-Requisites
> > > +	 *	- Controller should support High-Speed-Enable Bit
> > > +	 *	- Controller should not be using DDR Mode
> > > +	 *	- Controller should advertise that it supports High Speed
> > > +	 *	  in capabilities register
> > > +	 *	- MMC/SD clock coming out of controller > 25MHz
> > > +	 */
> > > +	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> >=20
> > is this really needed...
>=20
> As explained above, this is needed only on platforms which requires the
> Bit to be set (currently AM335x). Such platforms will set this
> parameter in it .dts file
>=20
> >=20
> > > +	    (ios->timing !=3D MMC_TIMING_UHS_DDR50) &&
> > > +	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) =3D=3D HSS)) {
> >=20
> > ... provided you check device's register ?
>=20
> As explained above, both TI814x & AM335x support HSS but only AM335x
> require HSPE bit set.

ok, understood. Just one small simplification:

if (a & BIT(n)) will have the same effect as if ((a & BIT(n) =3D=3D BIT(n))=
),
so you can simplify that a little bit.

--=20
balbi

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkLq8AAoJEIaOsuA1yqREtKkP/2lJALixfoWdzuV+8tQo/u3Q
kL3uzDVlzg7PyBl7Uij7LOmIlMgu+FgpWkp/SJjnML5eaYGPRaTbCs864LMaZe8Q
56hlheXC3K3zIGSeA6kOTwkQTA8AoX3pXRC9Cbgz3aIC2bGT1vlXCOoUy3JXp3uI
DQeutBkRuaVgxyahw9gXgSoqKXf+wfYqCqpiUdvQhUyMDQI6l5xPLcHgrvCe37/8
U7k1SsaprQcWRqW+nICvkvE2+p36O75yWUfT8aliEyyTfUtowzmjc2HfB+WiwDan
pXsjgo00ohzbv5UWn2gLkhkHVTzqhGb15VdScOyxjvj3auztykAMxv1biMhkEII/
yNHc9H77ZG2GQTV1GPxh2fMHDwacQ/UWa13+zwm8ZORSsYzteSQFCxgCD94L5xhq
v2WQYE7IAkiwbkKG1S+YHHYPF59crJKyCWl2sbzqXs0nvNEiNsFsRZwcFcmfFfGt
1EZV4XOLSU13pniRR3CtyF++FUqnGuQLv7TqaijuANn9u0V/S09pwsc0hsT3ElY6
Gl4MOJxn5EZx6NAaDOodn7UK4iCD+t8+z3hz655x/q7ofNmx+mluaYEuoG+s+xBn
idPC9tnn4+n2RC8kI8s2rLyGgr1hPSu851zRNAvUdZ5BZMMhQyF3p1bW15E3aNZy
foxUXdBUueSDvavvbxHz
=iz62
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
