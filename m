From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/3] drivers/misc: Add realtek card reader core driver
Date: Mon, 13 Aug 2012 23:59:36 +0300
Message-ID: <1344891576.16792.5.camel@maxim-laptop>
References: <1343720536-22077-1-git-send-email-wei_wang@realsil.com.cn>
	 <201207311123.25862.arnd@arndb.de> <5018CA65.1080906@realsil.com.cn>
	 <201208011431.02050.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201208011431.02050.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: wwang <wei_wang@realsil.com.cn>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "bp@alien8.de" <bp@alien8.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2012-08-01 at 14:31 +0000, Arnd Bergmann wrote:=20
> On Wednesday 01 August 2012, wwang wrote:
> > =E4=BA=8E 2012=E5=B9=B407=E6=9C=8831=E6=97=A5 19:23, Arnd Bergmann =
=E5=86=99=E9=81=93:
> > >
> > > You posted the sdmmc host driver and the pci card reader driver.
> > > I assume that the USB card reader and the memstick host
> > > will also get posted at some point. Do you have a timeframe
> > > for those?
> >=20
> > I will submit my memstick host driver around two months later, and
> > submit USB part at the end of this year.
>=20
> ok.
>=20
> > > The hardware seems to also support xd/smartmedia. Do you have
> > > plans to add those? I think we have some code in drivers/mfd
> > > that acts as an abstraction layer for these, given that the
> > > host has to do the wear leveling there too.
> >=20
> > Yes, xD is still in our plan. But because the user population of xD=
/SM
> > is so small, we put the priority of writing xD host driver in a rel=
evant
> > low level.
> > Maybe we will submit this driver in the next year.
>=20
> Ok. When you get to that, I think you should use the code
> from drivers/mtd/nand/sm_common.c, but it's better to confirm
> that with the MTD maintainers first.
Just note that this file doesn't have much stuff as it turned out
that xD card readers and cards are just raw NAND.
Except that large xD cards, still use small block size, and somewhat
different IDs, thus I placed them in this file.

You just need to write a NAND driver exposing raw flash, and my sm_ftl
will take care of wear leveling and everything else.


If any questions, bug-reports, just notes, I glad to hear about this.
Best regards,
Maxim Levitsky
