From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Tue, 25 Oct 2011 17:31:35 -0400
Message-ID: <CANz0V+5VQekjq0+Q8pLtZp9+uBMT3U56xEAraOAt-evVsGwvFQ@mail.gmail.com>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	<m2vcrh55lm.fsf@bob.laptop.org>
	<CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
	<m2r5245i0y.fsf@bob.laptop.org>
	<4EA52E92.1010406@stericsson.com>
	<m2sjmi4s7x.fsf@bob.laptop.org>
	<E2E6AC6BFAD06343BA2D97432459C1B6071A90E6A8@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49522 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab1JYVbh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2011 17:31:37 -0400
Received: by wyg36 with SMTP id 36so1032154wyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2011 14:31:36 -0700 (PDT)
In-Reply-To: <E2E6AC6BFAD06343BA2D97432459C1B6071A90E6A8@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>, Ulf HANSSON <ulf.hansson@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, John BECKETT <john.beckett@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2011/10/24 Johan RUDHOLM <johan.rudholm@stericsson.com>:

>> I think the overlap between your patch and Andrei's
>> mmcblkXbootY/force_ro
>> node is going to be confusing -- one operates purely in the kernel a=
nd
>> the other is sent to the card. =C2=A0Do you have any proposal for ma=
king the
>> difference clearer?
>
> I concur, the same can be said about general purpose partitions as we=
ll? Partitions that are configured in hardware rather than software. Th=
e current layout in sysfs does not reflect this difference either, belo=
w
>

Well, they're not really partitions, though, but separate logical
devices that can be
configred only once,  but I generally agree with you.

My personal opinion is that since the kernel is not used solely in a
controlled, embedded
environment, effort should be done to reduce the number of physically d=
amaging
actions a curious user could do :-). I don't mean "formatting disk", I
mean "raising Vcc
to the point of smoking device", bricking, exploding, etc. In line
with this thought,
I think it should be more difficult to permanently lock a card - an
ioctl (whether
specific or generic, involving knowing what command to send) I think
is the better solution.

As far as the temporary locking, I'm still not really convinced, but
I'll say I don't have a
strong opinion about it. Certainly, as an implementer, I would do so
in the bootloader
rather than the kernel (why? for Android - because you can fastboot
boot kernels via USB,
or maybe some bootloader somewhere supports booting from SD, so your
security policy
should be enforced as soon as possible, instead of relying on booting
your trusted image).

A
