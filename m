From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to
 detect card
Date: Mon, 18 May 2015 21:27:43 -0500
Message-ID: <1432002463.27761.49.camel@freescale.com>
References: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFrgr5-xL3xG83AdFd8sAf20TUetCN=7etCg9rsKoZ317g@mail.gmail.com>
	 <BY1PR0301MB11920E68DD9C4B17F1B1373FF2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	 <CAPDyKFpB2a=9J1T2+EwKUCx-6f27CbJyJSfXVMkK5sL0DsJL2Q@mail.gmail.com>
	 <BY1PR0301MB1192B676B858B31C3B1893C1F2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	 <1431981783.27761.5.camel@freescale.com>
	 <DM2PR0301MB1199D37E394B9CF805CD220DF2C30@DM2PR0301MB1199.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:31564
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751900AbbESDBA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 May 2015 23:01:00 -0400
In-Reply-To: <DM2PR0301MB1199D37E394B9CF805CD220DF2C30@DM2PR0301MB1199.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On Mon, 2015-05-18 at 21:16 -0500, Lu Yangbo-B47093 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, May 19, 2015 4:43 AM
> > To: Lu Yangbo-B47093
> > Cc: Ulf Hansson; linux-mmc; Chris Ball
> > Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mod=
e to
> > detect card
> >=20
> > On Mon, 2015-05-18 at 04:55 -0500, Lu Yangbo-B47093 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > Sent: Monday, May 18, 2015 5:50 PM
> > > > To: Lu Yangbo-B47093
> > > > Cc: linux-mmc; Chris Ball; Wood Scott-B07421
> > > > Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt=
 mode
> > > > to detect card
> > > >
> > > > On 18 May 2015 at 11:30, Lu Y.B. <yangbo.lu@freescale.com> wrot=
e:
> > > > >
> > > > >
> > > > >> -----Original Message-----
> > > > >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > >> Sent: Monday, May 18, 2015 5:04 PM
> > > > >> To: Lu Yangbo-B47093
> > > > >> Cc: linux-mmc; Chris Ball; Wood Scott-B07421
> > > > >> Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interr=
upt
> > > > >> mode to detect card
> > > > >>
> > > > >> On 15 May 2015 at 04:46, Yangbo Lu <yangbo.lu@freescale.com>=
 wrote:
> > > > >> > Enable interrupt mode to detect card instead of polling mo=
de
> > > > >> > for
> > > > >> > P1020/P4080/P5020/P5040/T1040 by removing the quirk
> > > > >> > SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
> > > > >> > transferring performance and avoid the call trace caused b=
y
> > > > >> > polling card status sometime.
> > > > >> >
> > > > >> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > > > >> > ----
> > > > >> > Changes for v2:
> > > > >> >         - Aligned all "of_device_is_compatibles" in same c=
olumn
> > > > >> > ---
> > > > >> >  drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
> > > > >> >  1 file changed, 7 insertions(+)
> > > > >> >
> > > > >> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
> > > > >> > b/drivers/mmc/host/sdhci-pltfm.c index c5b01d6..97128f3 10=
0644
> > > > >> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > > > >> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > > > >> > @@ -102,6 +102,13 @@ void sdhci_get_of_property(struct
> > > > >> > platform_device
> > > > >> *pdev)
> > > > >> >                     of_device_is_compatible(np, "fsl,mpc85=
36-
> > esdhc"))
> > > > >> >                         host->quirks |=3D
> > > > >> > SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > > > >> >
> > > > >> > +               if (of_device_is_compatible(np,
> > > > >> > + "fsl,p5040-esdhc")
> > > > ||
> > > > >> > +                   of_device_is_compatible(np,
> > > > >> > + "fsl,p5020-esdhc")
> > > > ||
> > > > >> > +                   of_device_is_compatible(np,
> > > > >> > + "fsl,p4080-esdhc")
> > > > ||
> > > > >> > +                   of_device_is_compatible(np,
> > > > >> > + "fsl,p1020-esdhc")
> > > > ||
> > > > >> > +                   of_device_is_compatible(np, "fsl,t1040=
-
> > esdhc"))
> > > > >> > +                       host->quirks &=3D
> > > > >> > + ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > > > >>
> > > > >> This looks strange to me.
> > > > >>
> > > > >> Why not just change the DT files for the relevant platforms =
to
> > > > >> not enable "broken-cd"?
> > > > >>
> > > > > Thanks Uffe.
> > > > > Because most platforms using sdhci-of-esdhc have broken CD, w=
e
> > > > > hope
> > > > this quirk is selected in default.
> > > > > Only several platforms could use CD to detect and we clear th=
is
> > > > > bit for
> > > > them.
> > > >
> > > > Hmm.
> > > >
> > > > Those platforms could still update their DT files and add
> > > > "broken-cd", since that would be the proper description of the =
HW.
> > > > Once that's done, it would enable you to remove the
> > > > SDHCI_QUIRK_BROKEN_CARD_DETECTION as default, right?
> > > >
> > > Yes, and if remove SDHCI_QUIRK_BROKEN_CARD_DETECTION as default,
> > 'borken-cd' would be needed to be added for most platforms using es=
dhc.
> >=20
> > I was OK with changing the device tree if it just meant that things=
 that
> > previously didn't work now work.  I'm not OK with requiring the dev=
ice
> > trees to change in order for things that already work to stay worki=
ng.
> >=20
> > In general it is not reasonable to expect device trees to enumerate
> > hardware bugs since the bugs (or the need to work aronud them) are =
often
> > discovered after the device tree has been created.
> >=20
> > Yangbo, when I asked why you couldn't use SVR you said that it was =
a
> > common SDHC file.  But, the file that sets
> > SDHCI_QUIRK_BROKEN_CARD_DETECTION in the first place is sdhci-of-es=
dhc.c
> > which is Freescale-specific.  Why not just test SVR in there to det=
ermine
> > whether the quirk should be set?
> Thanks Scott.
> The SVR testing could be only used for PPC. It doesn=E2=80=99t suppor=
t ARM that we will use.
> I think using the dts should be better way.

None of the chips that this patch looks for are ARM chips.  Are you're
saying our ARM chips don't have any form of identification?  Even if
that's the case, there's nothing wrong with looking at the device tree;
it's changing the device tree that I'm objecting to if there's an
alternative.

In any case, I don't know why these checks are being added to common
code rather than sdhci-of-esdhc.c.

-Scott


