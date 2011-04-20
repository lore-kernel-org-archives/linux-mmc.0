From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 13:47:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104201341430.28361@peruna>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com> <alpine.DEB.2.00.1104201131080.28361@peruna> <201104202117.14463.arnd@arndb.de> <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1404909235-1303332444=:28361"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:50895 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225Ab1DTUr1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 16:47:27 -0400
In-Reply-To: <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1404909235-1303332444=:28361
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Apr 2011, Micha=C5=82 Miros=C5=82aw wrote:
> >> I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of your
> >> solution. =C2=A0If everyone else thinks it is reasonable, I'll submit =
a v7
> >> with it.
> > No need for a union or a ptr_size member in the struct. Just use
> > a single __u64 and let the user cast the pointer to that. This
> > will work on all architectures.
>=20
> Union is just hiding this cast (it will be done in kernel) and allows
> cleaner code for userspace (there's a single kernel and possibly
> multiple applications that will implement this call).
>=20

Chris,

Do you have a preference here?  I do not have a preference.  On the one
hand, not having the union makes for a cleaner-to-read struct.  On the
other hand, not having to cast the pointer in 32-bit userspace is nice
especially since I foresee using this ioctl on a lot of ARM SoCs.

John
---1463811328-1404909235-1303332444=:28361--
