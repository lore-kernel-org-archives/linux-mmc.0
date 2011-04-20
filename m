From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 21:17:14 +0200
Message-ID: <201104202117.14463.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com> <alpine.DEB.2.00.1104201131080.28361@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab1DTTRd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 15:17:33 -0400
In-Reply-To: <alpine.DEB.2.00.1104201131080.28361@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

On Wednesday 20 April 2011 21:06:49 John Calixto wrote:
> On Wed, 20 Apr 2011, Micha=C5=82 Miros=C5=82aw wrote:
> > Hmm. This might be even better:
> >=20
> > static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> > unsigned int cmd, unsigned long arg)
> > {
> >   struct mmc_ioc_cmd blk;
> >=20
> >   if (cmd !=3D MMC_IOC_CMD)
> >     return -EINVAL;
> >=20
> >   copy_from_user((void __user *)arg, &blk) ...
> >=20
> > #ifdef CONFIG_COMPAT
> >   if (is_compat_task())
> >     blk.data_ptr =3D compat_ptr(*(u32 *)&blk.data_ptr);
> > #endif
> >=20
> >   return mmc_blk_ioctl_cmd(bdev, &blk);
> > }

No, please don't try to invent random new ways of doing this.
Your example relies on the assumption that the task is calling
the entry point for its native word size. Some architectures
intentionally allow calling the 32 bit entry point from 64 bit
tasks and vice versa, e.g. for user space emulators converting
to a different ABI, and in that case is_compat_task() produces
the wrong result. Don't ever rely on that.

> I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of your
> solution.  If everyone else thinks it is reasonable, I'll submit a v7
> with it.

No need for a union or a ptr_size member in the struct. Just use
a single __u64 and let the user cast the pointer to that. This
will work on all architectures.
=20
> However, I still think it should be implemented in compat_ioctl()
> because compat_blkdev_ioctl() expects it.  Either that, or I add to t=
he
> big switch in compat_blkdev_driver_ioctl(), and spreading this change
> out to block/compat_ioctl.c does not seem like The Right Thing to me.

Yes, you definitely need to fill the .compat_ioctl member. We don't wan=
t
new entries in the switch statement, in particular none that are specif=
ic
to a single driver.

	Arnd
