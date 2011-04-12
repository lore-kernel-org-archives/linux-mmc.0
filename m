From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 14:51:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121450420.8483@peruna>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna> <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-279189751-1302645114=:8483"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:35693 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932332Ab1DLVv7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 17:51:59 -0400
In-Reply-To: <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-279189751-1302645114=:8483
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Apr 2011, Micha=B3 Miros=B3aw wrote:
> 2011/4/11 John Calixto <john.calixto@modsystems.com>:
> [...]
> > --- /dev/null
> > +++ b/include/linux/mmc/ioctl.h
> > @@ -0,0 +1,32 @@
> > +#ifndef _MMC_IOCTL_H
> > +#define _MMC_IOCTL_H
> > +struct mmc_ioc_cmd {
> > + =A0 =A0 =A0 /* implies direction of data. =A0true =3D write, false =
=3D read */
> > + =A0 =A0 =A0 int write_flag;
> > +
> > + =A0 =A0 =A0 __u32 opcode;
> > + =A0 =A0 =A0 __u32 arg;
> > + =A0 =A0 =A0 __u32 response[4]; =A0/* CMD response */
> > + =A0 =A0 =A0 unsigned int flags;
> > + =A0 =A0 =A0 unsigned int blksz;
> > + =A0 =A0 =A0 unsigned int blocks;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Sleep at least postsleep_min_us useconds, and at mos=
t
> > + =A0 =A0 =A0 =A0* postsleep_max_us useconds *after* issuing command. =
=A0Needed for some
> > + =A0 =A0 =A0 =A0* read commands for which cards have no other way of i=
ndicating
> > + =A0 =A0 =A0 =A0* they're ready for the next command (i.e. there is no=
 equivalent of a
> > + =A0 =A0 =A0 =A0* "busy" indicator for read operations).
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 unsigned int postsleep_min_us;
> > + =A0 =A0 =A0 unsigned int postsleep_max_us;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Override driver-computed timeouts. =A0Note the diffe=
rence in units!
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 unsigned int data_timeout_ns;
> > + =A0 =A0 =A0 unsigned int cmd_timeout_ms;
> > + =A0 =A0 =A0 __u64 data_ptr; =A0/* DAT buffer */
>=20
> This will be more natural if you have an anonymous union here:
> union {
>   __u64 data_ptr_l;
>   void *data_ptr;
> };
>=20

Ah, but of course!  Thanks!

John
---1463811328-279189751-1302645114=:8483--
