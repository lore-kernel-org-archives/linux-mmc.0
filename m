From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: A question on IOCTL interface for MMC
Date: Mon, 24 Oct 2011 18:02:36 +0530
Message-ID: <CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
	<5263525.D4yqBTjgWh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61490 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab1JXMch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 08:32:37 -0400
Received: by iaby12 with SMTP id y12so1281373iab.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 05:32:37 -0700 (PDT)
In-Reply-To: <5263525.D4yqBTjgWh@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

Hi Arnd,
=C2=A0 As explained in previous mail, the IOCTL is actually an inteface=
 to
block layer and it is only expecting read/write commands to be sent
through the interface.The prrof of it can be seen in write_flag
present in the IOCTL structure which indicates the either the command
can be read or a write command.

So, can I submit a linux module to the kernel which uses the same
mmc_ioc_cmd structure and do all the required processing in my module.

To be clear on my requirement:
it is=C2=A0 To test ALL SD/MMC Commands and NOT just the  Read/Write Co=
mmands.
or should I extend the mmc_test module present in kernel to support
testing of individual commands as well ?
Can I get some suggestions on what approach to take ?


On Thu, Oct 20, 2011 at 12:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thursday 20 October 2011 10:39:00 Shashidhar Hiremath wrote:
> > =C2=A0 I am planning to use the existing IOCTL interface for SD/MMC=
 present
> > in the kernel.
> > =C2=A0 Since, the IOCTL interface expects a read/write flag , and t=
he MMC
> > IOCTL is actually an interface to block layer I feel without modify=
ing
> > the block layer for the support of non-read write commands ,I may n=
ot
> > be able to test the non-read/write commands through the IOCTL
> > interface .
> > Is there a way of doing this without modifying block layer ?
>
> Hi Shashidhar,
>
> I think there is actually no problem here at all. The block layer sim=
ply
> passes the ioctl command number and argument to the driver, which can
> do anything with it.
>
> What functionality are you actually looking for?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd



--
regards,
Shashidhar Hiremath
