From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Thu, 13 Oct 2011 10:31:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110131029510.2026-100000@iolanthe.rowland.org>
References: <CACVXFVNXyzzJw7UK+OFuDe23voQvyywoP9AvUsV=iPDFPO4fPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59226 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751356Ab1JMObq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 10:31:46 -0400
In-Reply-To: <CACVXFVNXyzzJw7UK+OFuDe23voQvyywoP9AvUsV=iPDFPO4fPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrei Warkentin <awarkentin@vmware.com>, Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 13 Oct 2011, Ming Lei wrote:

> >> Inside device_add(), device_pm_add is called before bus_probe_devi=
ce,
> >> so the patch can't change the device order in pm list, and just ch=
ange
> >> the driver probe order.
> >
> > That's the way it works now, but can it be reworked? =A0It would be
>=20
> IMO, it depends on what shape you plan to rework.  Currently, the
> deferred probe may found a resource dependency, but I am not sure
> that pm dependency is same with the resource dependency found
> during probe.
>=20
> > possible to adjust the list order after successful probe. =A0Howeve=
r,
> > I'm not clear on the ordering rules for the dpm_list. =A0Right now =
it is
> > explicitly ordered to have parents before children, but as already
> > expressed, that doesn't accurately represent ordering constraints f=
or
> > multiple device dependancies.
>=20
> Maybe we should understand the correct model of the ordering constrai=
nts
> for the multiple device dependancies first, could you give a descript=
ion or
> some examples about it?

The requirement is that devices must be capable of resuming in the=20
order given by dpm_list, and they must be capable of suspending in=20
the reverse order.

Therefore if device A can't work unless device B is functional, then B=20
must come before A in dpm_list.

Alan Stern

