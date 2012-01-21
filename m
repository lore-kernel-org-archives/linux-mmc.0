From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Add Winbond WB528SD Secure Digital (SD) card reader
 driver
Date: Sat, 21 Jan 2012 10:02:51 -0500
Message-ID: <20120121150251.GA28340@suse.de>
References: <4F1A98F5.3080402@freemail.hu>
 <20120121125153.GB18829@suse.de>
 <4F1AD195.70305@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F1AD195.70305@freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, techeng <dzshen@gmail.com>, clyu@citiz.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Jan 21, 2012 at 03:54:13PM +0100, N=E9meth M=E1rton wrote:
> Hi Greg,
>=20
> thanks for your response and your questions, I think it will help my
> work very much.
>=20
> Greg KH wrote:
> > On Sat, Jan 21, 2012 at 11:52:37AM +0100, N=E9meth M=E1rton wrote:
> >> From: M=E1rton N=E9meth <nm127@freemail.hu>
> >>
> >> This driver version of Winbond WB528SD can detect mechanical card
> >> presence only. The information is provided through sysfs.
> >=20
> > How is it provided through sysfs?  Is this done in a standard way? =
 If
> > not, why not?
>=20
> I used device_create_file()/device_remove_file() and DEVICE_ATTR(), i=
n
> that sense it is standard. I'm not sure, however, that you a referrin=
g
> to this, rather referring to the standard way how other SD card reade=
rs
> provide the card presence information to the user space, right?

Yes, the latter is what matters.

> To tell you the truth, I could not find an other PCI card driver whic=
h
> I can take as an example, I would need some help on this.

I don't think that any other device does this, as it properly hooks up
the block device for the card inserted, which generates the needed
userspace notifications.

So please don't create a non-standard way of determining if a card is
present or not, you are creating a kernel/user API here that needs to b=
e
preserved if it gets into the kernel tree.

> > Why is this driver submitted to the staging tree?  What is keeping =
it
> > from going into the "real" portion of the kernel for other card rea=
ders?
>=20
> Interrupt handling, read, write and connecting the driver upwards to =
the
> block subsystem, I guess.
>=20
> > We need a TODO file for what is needed to get it moved out of stagi=
ng.
>=20
> I can create one, no problem.
>=20
> > Oh, and it needs to do a bit more than just detect a card to be use=
ful,
> > right?  How about read/write to it?
>=20
> Sure. My intention was to get feedback for my work as early as possib=
le.
> I reached a state where a minimal level of functionality is available=
:
> the mechanical SD card presence is available for userspace programs.

What could a userspace program do with this information?

> The read/write access will be a bit more difficult, I guess because I
> currently don't have access to the register programming reference of
> this device, I can use the trial-and-error method, for example.

Yeah, doing this type of work is hard, and I understand your want to ge=
t
it into the tree at this early stage.  However, we really need somethin=
g
that actually works, otherwise people are going to be very confused whe=
n
they see their device bound to this driver, yet nothing works.

So I think we need to wait until it can handle the block device handlin=
g
logic first, before we can add it to the kernel tree, even in the
staging directory.

Good luck with this effort, it is not easy at all.

greg k-h
