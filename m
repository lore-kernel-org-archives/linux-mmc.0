From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers/misc: Add realtek card reader core driver
Date: Wed, 1 Aug 2012 14:31:01 +0000
Message-ID: <201208011431.02050.arnd@arndb.de>
References: <1343720536-22077-1-git-send-email-wei_wang@realsil.com.cn> <201207311123.25862.arnd@arndb.de> <5018CA65.1080906@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55127 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2HAObj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Aug 2012 10:31:39 -0400
In-Reply-To: <5018CA65.1080906@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "bp@alien8.de" <bp@alien8.de>

On Wednesday 01 August 2012, wwang wrote:
> =D3=DA 2012=C4=EA07=D4=C231=C8=D5 19:23, Arnd Bergmann =D0=B4=B5=C0:
> >
> > You posted the sdmmc host driver and the pci card reader driver.
> > I assume that the USB card reader and the memstick host
> > will also get posted at some point. Do you have a timeframe
> > for those?
>=20
> I will submit my memstick host driver around two months later, and
> submit USB part at the end of this year.

ok.

> > The hardware seems to also support xd/smartmedia. Do you have
> > plans to add those? I think we have some code in drivers/mfd
> > that acts as an abstraction layer for these, given that the
> > host has to do the wear leveling there too.
>=20
> Yes, xD is still in our plan. But because the user population of xD/S=
M
> is so small, we put the priority of writing xD host driver in a relev=
ant
> low level.
> Maybe we will submit this driver in the next year.

Ok. When you get to that, I think you should use the code
from drivers/mtd/nand/sm_common.c, but it's better to confirm
that with the MTD maintainers first.

> > As usual for most things getting added to drivers/misc, I'm skeptic=
al
> > about it actually fitting in here. Normally I'd put such a multiple=
xer
> > into drivers/mfd. Given that you actually need your own bus, rather
> > than just a single host with multiple endpoints, drivers/bus/realte=
k/cr
> > might be best.
> We do need a bus driver. We support multi models of card at the same
> time, so we need a way to bind all of the host drivers. And in the
> internal of our card reader, we have only one DMA engine and one ring
> buffer to handle massive data, so we also need a way to protect the
> critical area between different card hosts. Bus driver is convenient =
to
> handle this situation. Another way to fulfill is to call every regist=
er
> function of different host (like mmc, memstick) in sequence in card
> reader driver, whether pci-based or usb-based, if not using bus drive=
r.
> I prefer the prior scheme, which is more flexible and less redundant =
code.

I understand where you are coming from, but IMHO a bus driver would
make more sense if the bus was a low-level abstraction that allows you
to add new high-level drivers (memstick, smartmedia, ...) without
having to modify the low-level drivers, which I believe is not possible
with your current code.

> Using bus driver:
>=20
> sdmmc memstick
> \ /
> \ /
> \ /
> rtsx bus driver
> / \
> / \
> / \
> / \
> rtsx pci rtsx usb

In reality, what you have seems to be actually more like

    sdmmc    memstick
        \       /
         \     /
          \   /
     rtsx bus driver
       /         \
      /           \
     /             \
    /               \
  rtsx-pci         rtsx-usb
   /    \           /    \
 pci-mmc \       usb-mmc  \
   pci-memstick       usb-memstick

> Not using bus driver:
>=20
> sdmmc-pci memstick-pci
> \ /
> \ /
> \ /
> \ /
> rtsx pci
>=20
> sdmmc-usb memstick-usb
> \ /
> \ /
> \ /
> \ /
> rtsx usb
>=20
> And you said we should put our own bus driver in drivers/bus/realtek/=
cr,
> but where is drivers/bus? Or can I just put this bus driver and our
> pci/usb card reader driver into drivers/mfd?

The best driver abstractions have the most specific code as a top-level
module that calls into more generic code.

What I would suggest you do is to have the code that is common between
the USB and PCI drivers in a loadable module that both of the other
modules call into:


   sdmmc-pci      sdmmc-usb        memstick-pci      memstick-usb
     \   \           /   \             /    \           /   |
      |   \         /     \           /      \         /    |
      |    \       /       \___      /        \       /     |
      \    sdmmc-common     ___|____/      memstick-common  |
       \     |             /   |                       |    /
        \____|______      /    |____________      _____|___/
             |      \    /                  \    /     |  =20
             |     pci-common             usb-common   |
             \              \              /           /
              \              \            /            /
               \_____________ \          /____________/
                             \rtsx-common/


You can skip a few of these if they are not needed, but in principle
you should get the idea. In this example, the pci-common and the
usb-common drivers would each be MFD driver that export a bunch
of slave devices. All the mmc specific code that you currently
have in the pci driver would then go all the way to the top into
the sdmmc-pci driver, and anything that is shared goes into one
of the lower modules.

	Arnd
