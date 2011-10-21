From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: A question on IOCTL interface for MMC
Date: Fri, 21 Oct 2011 20:40:51 +0530
Message-ID: <CANYdXnq19NUPe3=hqTjVt-WBsJuFe8aYfzFdBAGx+nj_hbWy+Q@mail.gmail.com>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
	<29942744.123457.1319122534256.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<CANYdXnp06UUY28Xjzd9DyCTbLeVNoGNV2T5XTihf2GRoKCEJdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33401 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1JUPKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 11:10:52 -0400
Received: by iaek3 with SMTP id k3so4838905iae.19
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2011 08:10:51 -0700 (PDT)
In-Reply-To: <CANYdXnp06UUY28Xjzd9DyCTbLeVNoGNV2T5XTihf2GRoKCEJdA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>, Sandeep Pendharkar <sandeep@vayavyalabs.com>, pavitra <pavitra@vayavyalabs.com>

Hi All,
Let me explain things in detail :-

My INTENT / REQUIREMENT is to test "ALL"  the SD/MMC Commands and NOT
just the Read/Write(data transfer) Commands.

How can this be helpful
  1. It can be used to validate the SD/MMC Core flows(Command specific
code paths)
  2. The Card Enumeration can be done from user space or for that
matter any sequence of commands can be sent from the user space.
  3. Individual commands can be tested with this interface, which is
good for the Buggy IP/Hardware testing. This provides fine control
over testing.

To do this I had two options
  1. Use the Block layer IOCTL.
  2. Write my own kernel module and hack MMC Core to call command
specific functions. This would be similar to "mmc_test.c" module.

APPROACH 1 : Using the Block Layer IOCTL

  Block Layer IOCTL expects only the READ/WRITE commands and hence its
  limited in functionality. I cannot send commands other than
Read/Write, say CMD 2 or
  CMD 0.
  Also you said that the Block Layer cannot be modified to add support =
for the
  non read/write commands. How should I go about this ?

   OR

  Can we have an IOCTL in MMC Core like the one at Block layer.

    Or

  Can we have a kernel module which can directly call the driver by byp=
assing
  mmc_core.

APPROACH 2 :

  I have already tested a Kernel Module that uses the sysfs interface t=
o
  send commands. MMC Core will have to be binded to this kernel module.
  This is similar to mmc_test.c module usage.

  Commands will be sent via the sys file and response can be got from t=
he card.
  As of now, the response is not sent to the user space but just to
/var/log/messages.

  MMC Core has to be hacked to export certain functions which will be c=
alled
  from the module.

  Is this ok and  can I submit this code.

Cheers,
Shashi


On Fri, Oct 21, 2011 at 10:04 AM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> thanks for the reply Andrei,
> =C2=A0through the IOCTL, I am actually trying to send a command to th=
e
> device and validate the response.So, when I send the command using th=
e
> IOCTL, I actually get a Input/Output Error. The reason I feel is that
> the command is sent to the block layer and since block layer only
> supports the read/write commands,even when I send command zero ,it
> treats it like a read/write command.
>
> On Thu, Oct 20, 2011 at 8:25 PM, Andrei Warkentin <awarkentin@vmware.=
com> wrote:
>> Hi,
>>
>> ----- Original Message -----
>>> From: "Shashidhar Hiremath" <shashidharh@vayavyalabs.com>
>>> To: "Chris Ball" <cjb@laptop.org>, "J Freyensee" <james_p_freyensee=
@linux.intel.com>, "John Calixto"
>>> <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org
>>> Sent: Thursday, October 20, 2011 1:09:00 AM
>>> Subject: A question on IOCTL interface for MMC
>>>
>>> Hi ,
>>> =C2=A0 I am planning to use the existing IOCTL interface for SD/MMC
>>> =C2=A0 present
>>> in the kernel.
>>> =C2=A0 Since, the IOCTL interface expects a read/write flag and the=
 MMC
>>> IOCTL is actually an interface to block layer I feel without
>>> modifying
>>> the block layer for the support of non-read write commands ,I may n=
ot
>>> be able to test the non-read/write commands through the IOCTL
>>> interface .
>>
>> Unsure what you mean. Certainly it's up to you how to handle the dat=
a
>> you pass to the ioctl(). The "in" and "out" just says whether you
>> are passing data to the kernel or expecting something back, no more =
-
>> no less.
>>
>> What are you actually trying to do? What are you trying to expose or=
 control
>> through an ioctl?
>>
>> A
>>
>
>
>
> --
> regards,
> Shashidhar Hiremath
>
