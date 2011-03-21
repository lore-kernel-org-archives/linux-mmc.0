From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMD
Date: Mon, 21 Mar 2011 13:25:34 +0100
Message-ID: <201103211325.34785.arnd@arndb.de>
References: <201103172255.51442.arnd@arndb.de> <alpine.DEB.2.00.1103191849040.13315@peruna> <AANLkTim9PXg8UXMkDXUQ6W9pYp12U6MQ2AR+3ORk-uEX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57793 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab1CUMZq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 08:25:46 -0400
In-Reply-To: <AANLkTim9PXg8UXMkDXUQ6W9pYp12U6MQ2AR+3ORk-uEX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

On Sunday 20 March 2011, Micha=C5=82 Miros=C5=82aw wrote:
> 2011/3/20 John Calixto <john.calixto@modsystems.com>:
> > On Sat, 19 Mar 2011, Arnd Bergmann wrote:
> [...]
> >> > I expect for more general purposes, like your qemu passthrough c=
ase, you
> >> > would want to add a handler for cmd=3DSD_IOC_CMD?
> >> Yes, but I suspect that would mean blocking all other activity on =
the
> >> same device, possibly with an ioctl for claiming the host for an
> >> extended period of time.
> > Sure.  And if the testing I described above shows that regular bloc=
k
> > operations are indeed negatively affected, then I'll have to implem=
ent
> > that ioctl for claiming the host myself and you'll have a head star=
t! :)
>=20
> This idea is scary. ;-) Just think what would happen if userspace mad=
e
> this sequence:
> 1. fd =3D open(dev)
> 2. ioctl(fd, claim host)
> 3. read(fd, ...)
>=20
> (if 3. is not convincing, replace it with any access to mounted
> filesystem from the same card.)

I agree. If we allow such a command on a block device, that
should probably be mutually exclusive with normal read/write
access or mounting the block device, and it needs to be a
priviledged operation.

	Arnd
