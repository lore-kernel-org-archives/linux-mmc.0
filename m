From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Wed, 6 Apr 2011 11:18:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104061054520.391@peruna>
References: <alpine.DEB.2.00.1104051458350.25803@peruna> <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com> <alpine.DEB.2.00.1104051613150.25803@peruna> <BANLkTi=wXpqFGhaBPnoRa+sQJ_eysvrTVA@mail.gmail.com> <alpine.DEB.2.00.1104051733180.25803@peruna>
 <BANLkTinG2Zty-VqnKD4c=-DYuML9ZxBeNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-444021280-1302113922=:391"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:40682 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754812Ab1DFSSp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 14:18:45 -0400
In-Reply-To: <BANLkTinG2Zty-VqnKD4c=-DYuML9ZxBeNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-444021280-1302113922=:391
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Apr 2011, Micha=C5=82 Miros=C5=82aw wrote:

> 2011/4/6 John Calixto <john.calixto@modsystems.com>:
> > On Tue, 5 Apr 2011, Andrei Warkentin wrote:
> >> Could you check the SD behavior for undefined ACMDs? If I do ACMD25,
> >> and ACMD25 is not defined, will it be executed as CMD25? This is the
> >> MMC behavior as I have mentioned.
> > The SD spec has a similar paragraph about unspecified ACMD opcodes -
> > they should be treated as the equivalent CMD opcodes. =C2=A0However, al=
l of
> > the opcodes that I listed are indeed specified. =C2=A0So, if the card
> > identifies itself as an SD card, it must implement those opcodes. =C2=
=A0If
> > it identifies itself as an SD card, and it does *not* implement the ACM=
D
> > opcodes I listed, then it likely "fell out the back door of the
> > manufacturing facility and landed on a store shelf" ;) ... its
> > quality/correct performance/reliability is unlikely.
>=20
> Not all specified ACMDs are mandatory. SD spec 2.00 says that only
> 6,13,41,42,51 are mandatory for all cards. This is less than the list
> you prepared in the patch.
>=20

Hmm... In several places of the full SD spec, and even in the redacted
"SD Specifications, Part 1, Physical Layer, Simplified Specification,
Version 3.01", it states the security functions are mandatory for all SD
cards except ROM cards.  For ROM cards, the security ACMDs are expected
to be treated as illegal commands, and do not fall back to their CMD
equivalents.

> It's better not to make those exceptions and instead prepare an
> userspace daemon that opens mmcblkX (non-exclusively) and forwards the
> requests from unprivileged users to the device (or even implements
> application specific API).
>=20

OK, this sounds reasonable to me (although I still do not see why
non-root, non-privileged users have open() access to /dev/mmcblk0).

I will replace the opcode filter with an unconditional check for
CAP_SYS_RAWIO.  With this capability check, I think I can skip checking
for SD vs. MMC.  It would be nice for this ioctl to have more general
purpose than just enabling secure operations on SD cards (see Arnd
Bergmann's intended use as a passthrough for virtual machines).

Regarding permissions, the next iteration of this patch will:

- Be a single patch containing the main ioctl functionality *and* this
  capability verification (checking "CAP_SYS_RAWIO", per Alan Cox in
  this thread).

- Only have the check for CAP_SYS_RAWIO.  It will *not* have an
  opcode-specific filter, nor a filter limiting it to just SD cards.

Is that satisfactory?

John
---1463811328-444021280-1302113922=:391--
