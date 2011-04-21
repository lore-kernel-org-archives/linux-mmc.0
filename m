From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 12:28:36 +0200
Message-ID: <BANLkTinuzNRUOKOVY+SOqJ3fjjfKFUhNdA@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104202117.14463.arnd@arndb.de>
 <BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com> <201104210711.15457.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42831 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab1DUK25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 06:28:57 -0400
Received: by qyk7 with SMTP id 7so2742257qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 03:28:56 -0700 (PDT)
In-Reply-To: <201104210711.15457.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

W dniu 21 kwietnia 2011 07:11 u=BFytkownik Arnd Bergmann <arnd@arndb.de=
> napisa=B3:
> On Wednesday 20 April 2011 21:46:04 Micha=B3 Miros=B3aw wrote:
>> 2011/4/20 Arnd Bergmann <arnd@arndb.de>:
>> > No, please don't try to invent random new ways of doing this.
>> > Your example relies on the assumption that the task is calling
>> > the entry point for its native word size. Some architectures
>> > intentionally allow calling the 32 bit entry point from 64 bit
>> > tasks and vice versa, e.g. for user space emulators converting
>> > to a different ABI, and in that case is_compat_task() produces
>> > the wrong result. Don't ever rely on that.
>>
>> This doesn't make sense to me. If you call 32-bit entry point from
>> 64-bit process, you can't reliably pass pointers through the call
>> (unless you limit 64-bit process to 32-bit address space).
>>
>> Do you know a working example of something using this kind of cross-=
call?
>
> There are people that use 32 bit programs on x86_64 in 64 bit mode
> and switch on the ADDR_LIMIT_32BIT personality, IIRC.
> This gives you more registers and lets you do 64 bit arithmetic
> while not using any more memory to store long pointers.
> There are a few problems with this, and the new x32 ABI will make it
> cleaner.

Ok. Thanks for the pointers.

>> >> I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of y=
our
>> >> solution. =A0If everyone else thinks it is reasonable, I'll submi=
t a v7
>> >> with it.
>> > No need for a union or a ptr_size member in the struct. Just use
>> > a single __u64 and let the user cast the pointer to that. This
>> > will work on all architectures.
>>
>> Union is just hiding this cast (it will be done in kernel) and allow=
s
>> cleaner code for userspace (there's a single kernel and possibly
>> multiple applications that will implement this call).
>
> As I explained, it doesn't work. Please read my earlier mails.

If you're referring to your mail:

Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 13 Apr 2011 01:00:39 +0200
Message-Id: <201104130100.39810.arnd@arndb.de>

Then I already provided an example of implementation that's
independent of endianness and avoids casts on userspace.

>> >> However, I still think it should be implemented in compat_ioctl()
>> >> because compat_blkdev_ioctl() expects it. =A0Either that, or I ad=
d to the
>> >> big switch in compat_blkdev_driver_ioctl(), and spreading this ch=
ange
>> >> out to block/compat_ioctl.c does not seem like The Right Thing to=
 me.
>> > Yes, you definitely need to fill the .compat_ioctl member. We don'=
t want
>> > new entries in the switch statement, in particular none that are s=
pecific
>> > to a single driver.
>> Hmm, you're right. fs/compat_ioctl.c falls back to plain .ioctl if
>> .compat_ioctl =3D=3D NULL.
> No, it doesn't.

I'll need to look at the code again then.

Best Regards,
Micha=B3 Miros=B3aw
