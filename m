From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMD
Date: Mon, 21 Mar 2011 09:26:29 -0500
Message-ID: <AANLkTikD07xreYEu4_=uQuw-+vi1TuQm5tmA4uWF82=n@mail.gmail.com>
References: <201103172255.51442.arnd@arndb.de>
	<alpine.DEB.2.00.1103191849040.13315@peruna>
	<AANLkTim9PXg8UXMkDXUQ6W9pYp12U6MQ2AR+3ORk-uEX@mail.gmail.com>
	<201103211325.34785.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:44192 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1CUO0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 10:26:33 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2LEQoQI029368
	for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 10:26:50 -0400 (EDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2LEQUH8029224
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 10:26:50 -0400 (EDT)
Received: by mail-ww0-f42.google.com with SMTP id 4so3809486wwk.3
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 07:26:30 -0700 (PDT)
In-Reply-To: <201103211325.34785.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

2011/3/21 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 20 March 2011, Micha=C5=82 Miros=C5=82aw wrote:
>> 2011/3/20 John Calixto <john.calixto@modsystems.com>:
>> > On Sat, 19 Mar 2011, Arnd Bergmann wrote:
>> [...]
>> >> > I expect for more general purposes, like your qemu passthrough =
case, you
>> >> > would want to add a handler for cmd=3DSD_IOC_CMD?
>> >> Yes, but I suspect that would mean blocking all other activity on=
 the
>> >> same device, possibly with an ioctl for claiming the host for an
>> >> extended period of time.
>> > Sure. =C2=A0And if the testing I described above shows that regula=
r block
>> > operations are indeed negatively affected, then I'll have to imple=
ment
>> > that ioctl for claiming the host myself and you'll have a head sta=
rt! :)
>>
>> This idea is scary. ;-) Just think what would happen if userspace ma=
de
>> this sequence:
>> 1. fd =3D open(dev)
>> 2. ioctl(fd, claim host)
>> 3. read(fd, ...)
>>
>> (if 3. is not convincing, replace it with any access to mounted
>> filesystem from the same card.)
>
> I agree. If we allow such a command on a block device, that
> should probably be mutually exclusive with normal read/write
> access or mounting the block device, and it needs to be a
> priviledged operation.
>

Chances are, the filesystem could be located on the device itself, so
exclusive access isn't always possible. Right now you can 'dd' all
over a block device
even if a filesystem is mounted on it, so the ioctl shouldn't be any
more restrictive than that. The contract on the ioctl should be that
the rest of the sd/sdio stack is not confused
over the card state, possibly resulting in the wrong operation. For
example, I briefly skimmed the simplified SD physical layer spec, and
I found nothing that said it was safe to assume a particular command
set would always work while the card is in some particular function
mode (set using SWITCH command, for example to put card into OTP,
ASSD.) In fact, if you look at 4.3.12 of
Part_1_Physical_Layer_Simplified_Specification_Ver3.01_Final_100518.pdf=
,
it says right there that care must be shown as to what command system
mode the card is in, as the commands may change meanings.

I think you need to nail down what exactly is going to be sent across
the IOCTL within the boundary of the simplified SD spec. If the
security extensions involve putting the card into a mode where normal
block/sdio/whatever functionality is impaired until the mode is
exited, then the kernel should always have the ability to put the card
back in normal mode, and restore your special mode when you do another
related ioctl.

A
