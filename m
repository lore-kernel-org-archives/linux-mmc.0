From: Tor Krill <tor@openproducts.com>
Subject: Re: Unstable mmc operation on armada38x
Date: Tue, 03 May 2016 15:35:50 +0200
Message-ID: <1462282550.3203.40.camel@openproducts.com>
References: <1461930531.2784.21.camel@openproducts.com>
	 <CAPDyKFpH2CLxxgf+fWSkkmyAnc1Ge+Eg0zRHykJEiM3zQYTc4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from op-mail.openproducts.com ([54.93.171.173]:55115 "EHLO
	op-mail.openproducts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcECNfz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 09:35:55 -0400
In-Reply-To: <CAPDyKFpH2CLxxgf+fWSkkmyAnc1Ge+Eg0zRHykJEiM3zQYTc4Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Uffe,

Thank you for your reply!

On m=C3=A5n, 2016-05-02 at 10:59 +0200, Ulf Hansson wrote:
> On 29 April 2016 at 13:48, Tor Krill <tor@openproducts.com> wrote:
> > Hi,
> >=20
> > I work on a custom setup using the Solid-run ClearFog Pro that uses
> > the
> > Marvell 88F6828. I use this with a SOM that is equipped with on
> > board
> > eMMC.
> >=20
> > When using the provided Marvell based kernel fork operation works
> > nicely.
> >=20
> > But when i however try using either stable kernel.org, i.e. 4.5.2,
> > or
> > the latest mmc-next the system malfunctions on the mmc-operation
> > resulting in the root-filesystem remount read only and the system
> > becomes unusable. (I still use the Marvell/Solid-run u-boot to boot
> > the
> > board)
> >=20
> > When doing this i get:
> >=20
> > mmcblk0: error -110 sending status command, retrying
> > mmcblk0: error -110 sending status command, retrying
> > mmcblk0: error -110 sending status command, aborting
> >=20
> > Thus it seems like the mmc doesn't answer the status request?
> >=20
> > I have tried debug this further by enable debug on sdhci-pxav3 and
> > mmc_core. When doing so i unfortunately can't reproduce the
> > problem. I
> > do log on a slow serial port which might be the reason for
> > affecting
> > operation since i get a lot of debug messages when doing this.
>=20
> We recently added mmc specific TRACE support to the MMC core. That
> allows you to trace each command/request being send to the card, if
> you don't want to affect the timing etc. I suggest you give it a try.

Thank you for that pointer. I now at least can get some capture on what
is happening. (Unfortunately i'm no expert on sd/mmc protocol)

I have created a new paste with an excerpt of the end off my
transaction:

http://pastebin.com/R32MsLyh

If i interpret it somewhat it seems like it does a write and then try
poll status of the device, which then does not respond (at all?).

> You could also try a bisect, as it seems like it might be a
> regression
> and can thus help to pin-point at what commit it broke.

This would be ideal, but since i have two different source trees,
kernel.org and Marvell/SolidRuns bsp that would be difficult. I will
try testing some of the earlier kernel.org kernels that have support
for this platform and se if i can find anything that works and then
bisect from that.

> On the other hand, the problem seems timing related, so it might be
> that the problem been around for a while but was just triggered by an
> unrelated change.

I agree, it somehow seems timing related. The big question here would
then be why it fails three times with the status request? Could it be
that the controller or mmc-chip somehow have "given up"?

Best Regards,

/Tor
