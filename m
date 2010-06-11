From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: + s5pc110-sdhci-s3c-can-override-host-capabilities.patch added
	to -mm tree
Date: Fri, 11 Jun 2010 04:48:32 +0100
Message-ID: <20100611034830.GH3498@trinity.fluff.org>
References: <201006102043.o5AKhEtI022722@imap1.linux-foundation.org> <20100611003414.GB3498@trinity.fluff.org> <AANLkTim-ltyN6dj-eKUKXIMxOe18ipzvos6m68hGpSve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:41570 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab0FKDsi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 23:48:38 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim-ltyN6dj-eKUKXIMxOe18ipzvos6m68hGpSve@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Ben Dooks <ben-linux@fluff.org>, akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-mmc@vger.kernel.org

On Fri, Jun 11, 2010 at 12:24:00PM +0900, Kyungmin Park wrote:
> On Fri, Jun 11, 2010 at 9:34 AM, Ben Dooks <ben-linux@fluff.org> wrot=
e:
> > On Thu, Jun 10, 2010 at 01:43:14PM -0700, akpm@linux-foundation.org=
 wrote:
> >>
> >> The patch titled
> >> =A0 =A0 =A0s5pc110: SDHCI-s3c can override host capabilities
> >> has been added to the -mm tree. =A0Its filename is
> >> =A0 =A0 =A0s5pc110-sdhci-s3c-can-override-host-capabilities.patch
> >>
> >> Before you just go and hit "reply", please:
> >> =A0 =A0a) Consider who else should be cc'ed
> >> =A0 =A0b) Prefer to cc a suitable mailing list as well
> >> =A0 =A0c) Ideally: find the original patch on the mailing list and=
 do a
> >> =A0 =A0 =A0 reply-to-all to that, adding suitable additional cc's
> >>
> >> *** Remember to use Documentation/SubmitChecklist when testing you=
r code ***
> >>
> >> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> >> out what to do about this
> >>
> >> The current -mm tree may be found at http://userweb.kernel.org/~ak=
pm/mmotm/
> >>
> >> ------------------------------------------------------
> >> Subject: s5pc110: SDHCI-s3c can override host capabilities
> >> From: Kyungmin Park <kmpark@infradead.org>
> >>
> >> Each board can override the default sdhci host capabilities.
> >> Some board has broken features by hardwares and support 8-bit band=
width.
> >
> > I'd much rather see a mask to remove unsupported features than simp=
ly
> > override the already read hardware mask.
>=20
> what do you mean? please see the Marek patch, each boards can use its
> own connection and configurations. So there's default caps (it's from
> you) and board can override it for their own purpose.

I'm having a rethink about the whole caps, it may not have been such a =
good
idea to do that way. Having the .caps fields means that each board that
needs to override it has to know all the caps for the controller meanin=
g
it is much more difficult to share a standard platform data structure
across the system.

Note, for this we already have a max_width field, we could have easily
used that to force the 8bit capability off in the driver too.
=20
> Thank you,
> Kyungmin Park
>=20
> >
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> Cc: <linux-mmc@vger.kernel.org>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>
> >> =A0arch/arm/plat-samsung/dev-hsmmc.c =A0| =A0 =A02 ++
> >> =A0arch/arm/plat-samsung/dev-hsmmc1.c | =A0 =A02 ++
> >> =A0arch/arm/plat-samsung/dev-hsmmc2.c | =A0 =A02 ++
> >> =A03 files changed, 6 insertions(+)
> >>
> >> diff -puN arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-=
override-host-capabilities arch/arm/plat-samsung/dev-hsmmc.c
> >> --- a/arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-over=
ride-host-capabilities
> >> +++ a/arch/arm/plat-samsung/dev-hsmmc.c
> >> @@ -65,4 +65,6 @@ void s3c_sdhci0_set_platdata(struct s3c_
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
> >> =A0 =A0 =A0 if (pd->cfg_card)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
> >> + =A0 =A0 if (pd->host_caps)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
> >> =A0}
> >> diff -puN arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can=
-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc1.c
> >> --- a/arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-ove=
rride-host-capabilities
> >> +++ a/arch/arm/plat-samsung/dev-hsmmc1.c
> >> @@ -65,4 +65,6 @@ void s3c_sdhci1_set_platdata(struct s3c_
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
> >> =A0 =A0 =A0 if (pd->cfg_card)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
> >> + =A0 =A0 if (pd->host_caps)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
> >> =A0}
> >> diff -puN arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can=
-override-host-capabilities arch/arm/plat-samsung/dev-hsmmc2.c
> >> --- a/arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-ove=
rride-host-capabilities
> >> +++ a/arch/arm/plat-samsung/dev-hsmmc2.c
> >> @@ -66,4 +66,6 @@ void s3c_sdhci2_set_platdata(struct s3c_
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
> >> =A0 =A0 =A0 if (pd->cfg_card)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
> >> + =A0 =A0 if (pd->host_caps)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
> >> =A0}
> >> _
> >>
> >> Patches currently in -mm which might be from kmpark@infradead.org =
are
> >>
> >> mmc-recognize-csd-structure.patch
> >> mmc-recognize-csd-structure-fix.patch
> >> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
> >> s5pc110-sdhci-s3c-support-on-s5pc110.patch
> >> sdhci-add-no-hi-speed-bit-quirk-support.patch
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> > --
> > --
> > Ben
> >
> > Q: =A0 =A0 =A0What's a light-year?
> > A: =A0 =A0 =A0One-third less calories than a regular year.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >

--=20
--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

