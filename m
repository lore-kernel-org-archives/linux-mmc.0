From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to
 detect card
Date: Mon, 18 May 2015 22:06:35 -0500
Message-ID: <1432004795.27761.57.camel@freescale.com>
References: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFrgr5-xL3xG83AdFd8sAf20TUetCN=7etCg9rsKoZ317g@mail.gmail.com>
	 <BY1PR0301MB11920E68DD9C4B17F1B1373FF2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	 <CAPDyKFpB2a=9J1T2+EwKUCx-6f27CbJyJSfXVMkK5sL0DsJL2Q@mail.gmail.com>
	 <BY1PR0301MB1192B676B858B31C3B1893C1F2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	 <1431981783.27761.5.camel@freescale.com>
	 <DM2PR0301MB1199D37E394B9CF805CD220DF2C30@DM2PR0301MB1199.namprd03.prod.outlook.com>
	 <1432002463.27761.49.camel@freescale.com>
	 <DM2PR0301MB1199F34464FC9F372A74ED60F2C30@DM2PR0301MB1199.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:8992
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752592AbbESDGo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 May 2015 23:06:44 -0400
In-Reply-To: <DM2PR0301MB1199F34464FC9F372A74ED60F2C30@DM2PR0301MB1199.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On Mon, 2015-05-18 at 21:49 -0500, Lu Yangbo-B47093 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, May 19, 2015 10:28 AM
> > To: Lu Yangbo-B47093
> > Cc: Ulf Hansson; linux-mmc; Chris Ball
> > Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mod=
e to
> > detect card
> >=20
> > On Mon, 2015-05-18 at 21:16 -0500, Lu Yangbo-B47093 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Tuesday, May 19, 2015 4:43 AM
> > > > To: Lu Yangbo-B47093
> > > > Cc: Ulf Hansson; linux-mmc; Chris Ball
> > > > Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt=
 mode
> > > > to detect card
> > > >
> > > > On Mon, 2015-05-18 at 04:55 -0500, Lu Yangbo-B47093 wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > > > Sent: Monday, May 18, 2015 5:50 PM
> > > > > > To: Lu Yangbo-B47093
> > > > > > Cc: linux-mmc; Chris Ball; Wood Scott-B07421
> > > > > > Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable inter=
rupt
> > > > > > mode to detect card
> > > > > >
> > > > > > Those platforms could still update their DT files and add
> > > > > > "broken-cd", since that would be the proper description of =
the HW.
> > > > > > Once that's done, it would enable you to remove the
> > > > > > SDHCI_QUIRK_BROKEN_CARD_DETECTION as default, right?
> > > > > >
> > > > > Yes, and if remove SDHCI_QUIRK_BROKEN_CARD_DETECTION as defau=
lt,
> > > > 'borken-cd' would be needed to be added for most platforms usin=
g
> > esdhc.
> > > >
> > > > I was OK with changing the device tree if it just meant that th=
ings
> > > > that previously didn't work now work.  I'm not OK with requirin=
g the
> > > > device trees to change in order for things that already work to=
 stay
> > working.
> > > >
> > > > In general it is not reasonable to expect device trees to enume=
rate
> > > > hardware bugs since the bugs (or the need to work aronud them) =
are
> > > > often discovered after the device tree has been created.
> > > >
> > > > Yangbo, when I asked why you couldn't use SVR you said that it =
was a
> > > > common SDHC file.  But, the file that sets
> > > > SDHCI_QUIRK_BROKEN_CARD_DETECTION in the first place is
> > > > sdhci-of-esdhc.c which is Freescale-specific.  Why not just tes=
t SVR
> > > > in there to determine whether the quirk should be set?
> > > Thanks Scott.
> > > The SVR testing could be only used for PPC. It doesn=E2=80=99t su=
pport ARM that
> > we will use.
> > > I think using the dts should be better way.
> >=20
> > None of the chips that this patch looks for are ARM chips.  Are you=
're
> > saying our ARM chips don't have any form of identification?  Even i=
f
> > that's the case, there's nothing wrong with looking at the device t=
ree;
> > it's changing the device tree that I'm objecting to if there's an
> > alternative.
> >=20
> > In any case, I don't know why these checks are being added to commo=
n code
> > rather than sdhci-of-esdhc.c.
> >=20
> Scott, I know what you mean now.
> What about moving these checks to sdhci-of-esdhc and still using dts?

The only thing I'm strongly opposed to is requiring chips that are
already working to add broken-cd to their device trees to continue
working.  I'd rather see SVR be used, as we do for errata in other
devices, but assuming the chips affected by this patch have never had
this feature work I'm not insisting on it.

> I know the SVR checks is from <asm/mpc85xx.h> and we will need to che=
ck
> ARM architecture like LS2085A later although it hasn't been exist on
> upstream now. =20

Again, ARM can use the device tree (ESDHC isn't described in the
upstream LS2085A device tree yet, and the internal one already has
"fsl,ls2085a-esdhc").  And looking at the manual, LS2085A *does* have
SVR.  You'd need to read it from the DCFG block rather than a core
register, but it's there.

-Scott


