From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: A question on IOCTL interface for MMC
Date: Fri, 21 Oct 2011 10:04:39 +0530
Message-ID: <CANYdXnp06UUY28Xjzd9DyCTbLeVNoGNV2T5XTihf2GRoKCEJdA@mail.gmail.com>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
	<29942744.123457.1319122534256.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37800 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1JUEek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 00:34:40 -0400
Received: by iaek3 with SMTP id k3so4239044iae.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2011 21:34:40 -0700 (PDT)
In-Reply-To: <29942744.123457.1319122534256.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

thanks for the reply Andrei,
  through the IOCTL, I am actually trying to send a command to the
device and validate the response.So, when I send the command using the
IOCTL, I actually get a Input/Output Error. The reason I feel is that
the command is sent to the block layer and since block layer only
supports the read/write commands,even when I send command zero ,it
treats it like a read/write command.

On Thu, Oct 20, 2011 at 8:25 PM, Andrei Warkentin <awarkentin@vmware.co=
m> wrote:
> Hi,
>
> ----- Original Message -----
>> From: "Shashidhar Hiremath" <shashidharh@vayavyalabs.com>
>> To: "Chris Ball" <cjb@laptop.org>, "J Freyensee" <james_p_freyensee@=
linux.intel.com>, "John Calixto"
>> <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org
>> Sent: Thursday, October 20, 2011 1:09:00 AM
>> Subject: A question on IOCTL interface for MMC
>>
>> Hi ,
>> =C2=A0 I am planning to use the existing IOCTL interface for SD/MMC
>> =C2=A0 present
>> in the kernel.
>> =C2=A0 Since, the IOCTL interface expects a read/write flag and the =
MMC
>> IOCTL is actually an interface to block layer I feel without
>> modifying
>> the block layer for the support of non-read write commands ,I may no=
t
>> be able to test the non-read/write commands through the IOCTL
>> interface .
>
> Unsure what you mean. Certainly it's up to you how to handle the data
> you pass to the ioctl(). The "in" and "out" just says whether you
> are passing data to the kernel or expecting something back, no more -
> no less.
>
> What are you actually trying to do? What are you trying to expose or =
control
> through an ioctl?
>
> A
>



--=20
regards,
Shashidhar Hiremath
