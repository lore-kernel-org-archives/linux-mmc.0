From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 07:11:15 +0200
Message-ID: <201104210711.15457.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104202117.14463.arnd@arndb.de> <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55049 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1DUFLX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 01:11:23 -0400
In-Reply-To: <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

On Wednesday 20 April 2011 21:46:04 Micha=C5=82 Miros=C5=82aw wrote:
> 2011/4/20 Arnd Bergmann <arnd@arndb.de>:
> > No, please don't try to invent random new ways of doing this.
> > Your example relies on the assumption that the task is calling
> > the entry point for its native word size. Some architectures
> > intentionally allow calling the 32 bit entry point from 64 bit
> > tasks and vice versa, e.g. for user space emulators converting
> > to a different ABI, and in that case is_compat_task() produces
> > the wrong result. Don't ever rely on that.
>=20
> This doesn't make sense to me. If you call 32-bit entry point from
> 64-bit process, you can't reliably pass pointers through the call
> (unless you limit 64-bit process to 32-bit address space).
>=20
> Do you know a working example of something using this kind of cross-c=
all?

There are people that use 32 bit programs on x86_64 in 64 bit mode
and switch on the ADDR_LIMIT_32BIT personality, IIRC.
This gives you more registers and lets you do 64 bit arithmetic
while not using any more memory to store long pointers.
There are a few problems with this, and the new x32 ABI will make it
cleaner.

I believe qemu also does this to run foreign user binaries. You
can use qemu-user to emulate user space with a different instruction
set, but when you call into the kernel, you have to use the native
data structures that the host understands.

> >> I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of yo=
ur
> >> solution.  If everyone else thinks it is reasonable, I'll submit a=
 v7
> >> with it.
> > No need for a union or a ptr_size member in the struct. Just use
> > a single __u64 and let the user cast the pointer to that. This
> > will work on all architectures.
>=20
> Union is just hiding this cast (it will be done in kernel) and allows
> cleaner code for userspace (there's a single kernel and possibly
> multiple applications that will implement this call).

As I explained, it doesn't work. Please read my earlier mails.

> >> However, I still think it should be implemented in compat_ioctl()
> >> because compat_blkdev_ioctl() expects it.  Either that, or I add t=
o the
> >> big switch in compat_blkdev_driver_ioctl(), and spreading this cha=
nge
> >> out to block/compat_ioctl.c does not seem like The Right Thing to =
me.
> > Yes, you definitely need to fill the .compat_ioctl member. We don't=
 want
> > new entries in the switch statement, in particular none that are sp=
ecific
> > to a single driver.
>=20
> Hmm, you're right. fs/compat_ioctl.c falls back to plain .ioctl if
> .compat_ioctl =3D=3D NULL.

No, it doesn't.


	Arnd
