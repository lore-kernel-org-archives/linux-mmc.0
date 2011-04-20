From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 21:46:04 +0200
Message-ID: <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com>
 <alpine.DEB.2.00.1104201131080.28361@peruna> <201104202117.14463.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46734 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933Ab1DTUDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 16:03:15 -0400
Received: by qwk3 with SMTP id 3so533880qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 13:03:14 -0700 (PDT)
In-Reply-To: <201104202117.14463.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

2011/4/20 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 20 April 2011 21:06:49 John Calixto wrote:
>> On Wed, 20 Apr 2011, Micha=C5=82 Miros=C5=82aw wrote:
>> > Hmm. This might be even better:
>> >
>> > static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>> > unsigned int cmd, unsigned long arg)
>> > {
>> > =C2=A0 struct mmc_ioc_cmd blk;
>> >
>> > =C2=A0 if (cmd !=3D MMC_IOC_CMD)
>> > =C2=A0 =C2=A0 return -EINVAL;
>> >
>> > =C2=A0 copy_from_user((void __user *)arg, &blk) ...
>> >
>> > #ifdef CONFIG_COMPAT
>> > =C2=A0 if (is_compat_task())
>> > =C2=A0 =C2=A0 blk.data_ptr =3D compat_ptr(*(u32 *)&blk.data_ptr);
>> > #endif
>> >
>> > =C2=A0 return mmc_blk_ioctl_cmd(bdev, &blk);
>> > }
>
> No, please don't try to invent random new ways of doing this.
> Your example relies on the assumption that the task is calling
> the entry point for its native word size. Some architectures
> intentionally allow calling the 32 bit entry point from 64 bit
> tasks and vice versa, e.g. for user space emulators converting
> to a different ABI, and in that case is_compat_task() produces
> the wrong result. Don't ever rely on that.

This doesn't make sense to me. If you call 32-bit entry point from
64-bit process, you can't reliably pass pointers through the call
(unless you limit 64-bit process to 32-bit address space).

Do you know a working example of something using this kind of cross-cal=
l?

>> I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of your
>> solution. =C2=A0If everyone else thinks it is reasonable, I'll submi=
t a v7
>> with it.
> No need for a union or a ptr_size member in the struct. Just use
> a single __u64 and let the user cast the pointer to that. This
> will work on all architectures.

Union is just hiding this cast (it will be done in kernel) and allows
cleaner code for userspace (there's a single kernel and possibly
multiple applications that will implement this call).

>> However, I still think it should be implemented in compat_ioctl()
>> because compat_blkdev_ioctl() expects it. =C2=A0Either that, or I ad=
d to the
>> big switch in compat_blkdev_driver_ioctl(), and spreading this chang=
e
>> out to block/compat_ioctl.c does not seem like The Right Thing to me=
=2E
> Yes, you definitely need to fill the .compat_ioctl member. We don't w=
ant
> new entries in the switch statement, in particular none that are spec=
ific
> to a single driver.

Hmm, you're right. fs/compat_ioctl.c falls back to plain .ioctl if
=2Ecompat_ioctl =3D=3D NULL. That's not the case for block ioctls, thou=
gh.
The separate compat_ioctl is the way to go.

Best Regards,
Micha=C5=82 Miros=C5=82aw
