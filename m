From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Write errors on Cherrytrail eMMC
Date: Fri, 16 Oct 2015 16:41:29 +0200
Message-ID: <1445006489.4432.14.camel@hadess.net>
References: <1444436356.28661.47.camel@hadess.net>
	 <56186468.80805@rock-chips.com> <1444585510.28661.68.camel@hadess.net>
	 <1444990095.4432.9.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45445 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbJPOlf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 10:41:35 -0400
In-Reply-To: <1444990095.4432.9.camel@hadess.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>

On Fri, 2015-10-16 at 12:08 +0200, Bastien Nocera wrote:
> On Sun, 2015-10-11 at 19:45 +0200, Bastien Nocera wrote:
> > On Sat, 2015-10-10 at 09:05 +0800, Shawn Lin wrote:
> > >=20
> > <snip>
> > > No, sdhci finally complete the tansfer. So, you can try to
> > > augment
> > > the=20
> > > timeout [here, mod_timer(&host->timer, timeout)] to see how the
> > > things=20
> > > going.
> >=20
> > I applied this patch to get some more debug, and increase the
> > default
> > timeout. I'm not certain this was actually used for all the
> > codepaths,
> > but I certainly saw that it was getting applied at least in some
> > cases.
> >=20
> > What would those errors be this time?
>=20
> Looks like one of:
> commit 66c39dfc92f9d35ed9f713833156547842086891
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:=C2=A0=C2=A0=C2=A0Thu May 7 13:10:21 2015 +0300
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0mmc: sdhci: Change to new way of doing re-tun=
ing
> =C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Make use of mmc core support for re-tuning in=
stead
> =C2=A0=C2=A0=C2=A0=C2=A0of doing it all in the sdhci driver.
> =C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0This patch also changes to flag the need for =
re-tuning
> =C2=A0=C2=A0=C2=A0=C2=A0always after runtime suspend when tuning has =
been used
> =C2=A0=C2=A0=C2=A0=C2=A0at initialization. Previously it was only don=
e if
> =C2=A0=C2=A0=C2=A0=C2=A0the re-tuning timer was in use.
> =C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Adrian Hunter <adrian.hunter@i=
ntel.com>
> =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Ulf Hansson <ulf.hansson@linar=
o.org>
>
> commit b69587e2d5b09a192c45c604ea1f9e8d51f4c3a1
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:=C2=A0=C2=A0=C2=A0Fri Feb 6 14:13:01 2015 +0200
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0mmc: sdhci-pci: Enable HS400 for some Intel h=
ost controllers
> =C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Enable detection of HS400 support via capabil=
ity bit-63
> =C2=A0=C2=A0=C2=A0=C2=A0for some Intel host controllers.
> =C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Adrian Hunter <adrian.hunter@i=
ntel.com>
> =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Ulf Hansson <ulf.hansson@linar=
o.org>
>=20
> is responsible for the errors seen on this device. Reverting those 2
> allowed me to perform the installation without the controller timing
> out.
>=20
> I'll try to pinpoint which one of the two is responsible for the
> timeout errors on this Surface 3.

After testing, both patches need to be reverted to get a stable eMMC on
the Surface 3. Where do we go from here?

Cheers
