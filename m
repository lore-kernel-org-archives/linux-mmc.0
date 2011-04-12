From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 16:08:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121604220.8483@peruna>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna> <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com> <201104130100.39810.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1559453478-1302649735=:8483"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:59463 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756134Ab1DLXI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 19:08:59 -0400
In-Reply-To: <201104130100.39810.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1559453478-1302649735=:8483
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 Apr 2011, Arnd Bergmann wrote:
> On Tuesday 12 April 2011, Micha=B3 Miros=B3aw wrote:
> > > +       unsigned int cmd_timeout_ms;
> > > +       __u64 data_ptr;  /* DAT buffer */
> >=20
> > This will be more natural if you have an anonymous union here:
> > union {
> >   __u64 data_ptr_
> >  void *data_ptr;
> > };
>=20
> No, that really does not work. It's important for all members of the ioct=
l data
> structure to have a fixed size, independent of the size of long or pointe=
r.
>=20
> If you do a union, the pointer ends up in the first 32 bits of the 64 bit=
 member,
> which does not work on big-endian architectures. It also doesn't work on =
31
> bit architectures, although that is a minor worry here.
>=20

Gah!  OK, so much for the v5 I just sent then.  What do you think about
the compat_ioctl that I sent in v2?  It means having the extra 32-bit
compat structure, but at least all the compat overhead is conditional
upon CONFIG_COMPAT.  If you're not using CONFIG_COMPAT, you don't get
any compat cruft.

John
---1463811328-1559453478-1302649735=:8483--
