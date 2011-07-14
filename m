From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] ARM: mach-shmobile: use GPIO interrupt also for card
 eject on SDHI0 on mackerel
Date: Thu, 14 Jul 2011 10:04:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107140911560.10688@axis700.grange>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
 <CANqRtoQ+pi-2ek+z2NXhPiVj2prCs8wZ6NYiOX44HQ1NZrei7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61712 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab1GNIEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 04:04:44 -0400
In-Reply-To: <CANqRtoQ+pi-2ek+z2NXhPiVj2prCs8wZ6NYiOX44HQ1NZrei7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

Hi Magnus

On Thu, 14 Jul 2011, Magnus Damm wrote:

> On Thu, Jul 14, 2011 at 8:25 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
> > also card eject events will have to be detected by the platform.
> > This patch prepares mackerel to this switch.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 68 +++++++++++++++=
++++++++++++----
> > =A01 files changed, 60 insertions(+), 8 deletions(-)
>=20
> Thanks for your work on this.
>=20
> What is the reason why we can't use GPIO for all cases of insert/ejec=
t
> event detection? Switching between GPIO and function mode for the pin
> seems overly complex IMO - that unless there is a real win behind it.
> Please explain.

Because the way, board-supported (cold) card-detection is currently=20
implemented on mackerel is, that on a card slot event a pm_runtime_get(=
)=20
is issued, which then calls the .runtime_resume() hook in the tmio driv=
er.=20
However, if the runtime PM is inactive, if the hook doesn't get called,=
=20
e.g., bacause the power domain, the respective SDHI controller is in, i=
s=20
held on by other devices, the event would be missed. That's why the nor=
mal=20
pin state is the SDHI card-detection function, which then works perform=
s=20
the detection in such cases.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
