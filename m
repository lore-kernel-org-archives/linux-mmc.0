From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMD
Date: Sun, 20 Mar 2011 06:11:19 +0100
Message-ID: <AANLkTim9PXg8UXMkDXUQ6W9pYp12U6MQ2AR+3ORk-uEX@mail.gmail.com>
References: <201103172255.51442.arnd@arndb.de> <201103182025.14036.arnd@arndb.de>
 <alpine.DEB.2.00.1103181332310.6084@peruna> <201103191252.49490.arnd@arndb.de>
 <alpine.DEB.2.00.1103191849040.13315@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58191 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1CTFLk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2011 01:11:40 -0400
Received: by qwk3 with SMTP id 3so3571422qwk.19
        for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 22:11:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103191849040.13315@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, cjb@laptop.org

2011/3/20 John Calixto <john.calixto@modsystems.com>:
> On Sat, 19 Mar 2011, Arnd Bergmann wrote:
[...]
>> > I expect for more general purposes, like your qemu passthrough cas=
e, you
>> > would want to add a handler for cmd=3DSD_IOC_CMD?
>> Yes, but I suspect that would mean blocking all other activity on th=
e
>> same device, possibly with an ioctl for claiming the host for an
>> extended period of time.
> Sure. =C2=A0And if the testing I described above shows that regular b=
lock
> operations are indeed negatively affected, then I'll have to implemen=
t
> that ioctl for claiming the host myself and you'll have a head start!=
 :)

This idea is scary. ;-) Just think what would happen if userspace made
this sequence:
1. fd =3D open(dev)
2. ioctl(fd, claim host)
3. read(fd, ...)

(if 3. is not convincing, replace it with any access to mounted
filesystem from the same card.)

Best Regards,
Micha=C5=82 Miros=C5=82aw
