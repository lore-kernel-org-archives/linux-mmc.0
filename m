From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] Add Winbond WB528SD Secure Digital (SD) card reader driver
Date: Sat, 21 Jan 2012 15:54:13 +0100
Message-ID: <4F1AD195.70305@freemail.hu>
References: <4F1A98F5.3080402@freemail.hu> <20120121125153.GB18829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120121125153.GB18829@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, techeng <dzshen@gmail.com>, clyu@citiz.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

thanks for your response and your questions, I think it will help my
work very much.

Greg KH wrote:
> On Sat, Jan 21, 2012 at 11:52:37AM +0100, N=E9meth M=E1rton wrote:
>> From: M=E1rton N=E9meth <nm127@freemail.hu>
>>
>> This driver version of Winbond WB528SD can detect mechanical card
>> presence only. The information is provided through sysfs.
>=20
> How is it provided through sysfs?  Is this done in a standard way?  I=
f
> not, why not?

I used device_create_file()/device_remove_file() and DEVICE_ATTR(), in
that sense it is standard. I'm not sure, however, that you a referring
to this, rather referring to the standard way how other SD card readers
provide the card presence information to the user space, right?
To tell you the truth, I could not find an other PCI card driver which
I can take as an example, I would need some help on this.

> Why is this driver submitted to the staging tree?  What is keeping it
> from going into the "real" portion of the kernel for other card reade=
rs?

Interrupt handling, read, write and connecting the driver upwards to th=
e
block subsystem, I guess.

> We need a TODO file for what is needed to get it moved out of staging=
=2E

I can create one, no problem.

> Oh, and it needs to do a bit more than just detect a card to be usefu=
l,
> right?  How about read/write to it?

Sure. My intention was to get feedback for my work as early as possible=
=2E
I reached a state where a minimal level of functionality is available:
the mechanical SD card presence is available for userspace programs.

The read/write access will be a bit more difficult, I guess because I
currently don't have access to the register programming reference of
this device, I can use the trial-and-error method, for example.

	M=E1rton N=E9meth
