From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
Date: Mon, 18 Apr 2011 22:19:57 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB504989@SAUSEXMBP01.amd.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-6-git-send-email-andreiw@motorola.com>
	<201104171925.10929.arnd@arndb.de>
	<BANLkTi=C=d=OLdKek9T4zpj4Z2dxH9MjqA@mail.gmail.com>
 <BANLkTimDhyQPOubC72xPc9FPHO2fooC9ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:41154
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754422Ab1DSDUq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2011 23:20:46 -0400
In-Reply-To: <BANLkTimDhyQPOubC72xPc9FPHO2fooC9ag@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>

Hi Andrei,


> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Tuesday, April 19, 2011 8:36 AM
> To: Nath, Arindam
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; subhashj@codeaurora.or=
g;
> Arnd Bergmann
> Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
>=20
> Arindam,
>=20
> On Sun, Apr 17, 2011 at 2:31 PM, Andrei Warkentin
> <andreiw@motorola.com> wrote:
> > Hi Arnd,
> >
> > On Sun, Apr 17, 2011 at 12:25 PM, Arnd Bergmann <arnd@arndb.de>
> wrote:
> >> On Saturday 16 April 2011, Andrei Warkentin wrote:
> >>> @@ -68,6 +68,15 @@ config MMC_SDHCI_PCI
> >>>
> >>> =A0 =A0 =A0 =A0 =A0 If unsure, say N.
> >>>
> >>> +config MMC_SDHCI_AUTO_CMD23
> >>> + =A0 =A0 =A0 tristate "SDHCI 3.0 Auto-CMD23 support (EXPERIMENTA=
L)"
> >>> + =A0 =A0 =A0 depends on MMC_SDHCI && EXPERIMENTAL
> >>> + =A0 =A0 =A0 help
> >>> + =A0 =A0 =A0 =A0 This enables the Auto-CMD23 optimization for mu=
ltiblock
> >>> + =A0 =A0 =A0 =A0 transfers where a CMD23 would be sent
> >>> +
> >>> + =A0 =A0 =A0 =A0 If unsure, say N.
> >>> +
> >>> =A0config MMC_RICOH_MMC
> >>> =A0 =A0 =A0 =A0 bool "Ricoh MMC Controller Disabler =A0(EXPERIMEN=
TAL)"
> >>> =A0 =A0 =A0 =A0 depends on MMC_SDHCI_PCI
> >>
> >> Does this need to be a Konfig option? We are already asking too ma=
ny
> >> questions here IMHO.
> >
> > Sorry, I should have clarified - I made this an experimental option
> > because I couldn't vouch for the correct functionality (no SDHCI 3.=
0
> > hardware around me) and I posted it only because Arindam wanted to
> try
> > it out and see if it worked alright. As soon as we're clear it work=
s
> > fine I'll take the Kconfig out.
> >
> > A
> >
>=20
> Any update? Have you tried this out?

I am planning to re-submit V3 patches sometime today or tomorrow. Only =
after that I will apply your patches on top of mine, and test it out. P=
lease give me some time, I will try to get back to you ASAP.

Thanks,
Arindam

>=20
> Thanks,
> A


