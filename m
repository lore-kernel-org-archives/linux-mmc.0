From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Fri, 14 Oct 2011 12:33:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110141229450.2036-100000@iolanthe.rowland.org>
References: <CACxGe6vF6em0-PnJ7UuH0CQ0_StJTfmFKBsktvb9O+ccCx6E8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41588 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933275Ab1JNQdc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 12:33:32 -0400
In-Reply-To: <CACxGe6vF6em0-PnJ7UuH0CQ0_StJTfmFKBsktvb9O+ccCx6E8A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ming Lei <tom.leiming@gmail.com>, Andrei Warkentin <awarkentin@vmware.com>, Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, 14 Oct 2011, Grant Likely wrote:

> > How can a device acquire children before it has a driver?
>=20
> There are a few potential situations in embedded systems (or at least
> nothing currently prevents it) where platform setup code constructs a
> device hierarchy without the aid of device drivers, and it is still
> possible for a parent device to be attached to a driver.  IIUC, SPARC
> creates an entire hierarchy of platform_devices from all the nodes in
> the OpenFirmware device tree, and any of those devices can be bound t=
o
> a driver.  I don't like that approach, but at the very least it needs
> to be guarded against.

Do these devices ever require deferred probes?

> On Fri, Oct 14, 2011 at 9:39 AM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> > On Thu, 13 Oct 2011, Grant Likely wrote:
> >> I saw those. =A0I also notice that they are only used by device_mo=
ve()
> >> when reparenting a device (which is another wrinkle I hadn't thoug=
h
> >> about). =A0Reparenting a device becomes problematic if the probe o=
rder
> >> is also represented in the list. =A0If device_move() gets called, =
then
> >> any implicit probe-order sorting for that device would be lost.
> >>
> >> I also notice that device_move disregards any children when moving=
 a
> >> device, which could also be a problem.
> >>
> >> Although it looks like the only users of device_move are:
> >>
> >> drivers/media/video/pvrusb2/pvrusb2-v4l2.c
> >> drivers/s390/cio/device.c
> >> net/bluetooth/hci_sysfs.c
> >> net/bluetooth/rfcomm/tty.c
> >>
> >> So it may not be significant to adapt.
> >
> > I trust that very little will be needed. =A0I haven't checked the
> > existing callers, but it's reasonable to require that a device bein=
g
> > moved not have any children.
>=20
> Yes, that does indeed simplify the issue considerably.  Let's do that=
=2E
>  So, for this patch, there will be two bits added.  First, don't allo=
w
> deferral on devices with children, and second a successful probe
> (deferred or otherwise) should always move a device to the end of the
> dap_list if it doesn't have children to guarantee that the list order
> satisfies both the hierarchical and probe order.  Manjunath, do you
> think you can prototype this?

I don't think the second part needs to be quite so invasive. =20
Certainly drivers that never defer probes shouldn't require anything to
be moved.

A deferred probe _should_ move the device to the end of the list.  But
this needs to happen in the probe routine itself (after it has verified
that all the other required devices are present and before it has
registered any children) to prevent races.  It can't be done in a
central location.

Alan Stern

