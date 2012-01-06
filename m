From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks
 manually on ARM
Date: Fri, 6 Jan 2012 09:21:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201060917130.16279@axis700.grange>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
 <1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58401 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab2AFIVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2012 03:21:19 -0500
In-Reply-To: <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

On Fri, 6 Jan 2012, Magnus Damm wrote:

> Hi Guennadi,
>=20
> On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On ARM the same clock is used by the PM subsystem and by the driver
> > directly. This leads to the clock staying permanently on, independe=
nt of
> > the runtime PM state. This patch makes clock enable and disable cal=
ls in
> > the driver SuperH-specific.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A06 ++++++
> > =A01 files changed, 6 insertions(+), 0 deletions(-)
>=20
> Thanks for your patch.
>=20
> >From my point of view there is very little difference between SH and
> SH-Mobile ARM, so I don't understand the special treatment. Also, is
> this change really needed for SH with your recent Runtime PM patches?

I didn't try SuperH. I seem to remember, there were 2 clocks per SDHI=20
controller on some platforms, of which one was handled by runtime PM an=
d=20
the other one directly. However, a quick look through SDHI users didn't=
=20
reveal any such cases, so, maybe I'm confusing SDHI with some other=20
hardware block. In that case - yes, I'd gladly remove that handling=20
completely!

> I believe we need to make use of the clock framework to get the clock
> rate configuration in the SDHI driver. At the same time we want to
> stop the clock as frequently as possible. I believe we should disable
> and enable the clock together with the Runtime PM get/put operations =
-
> pretty much exactly like our I2C master driver does. The only problem
> is, while the clock is disabled the clock rate may be changed. So we
> need to be able to notify the MMC subsystem about the new clock rate.
>=20
> Any ideas on how to make this happen?

Huh, if that's really possible... I'll have a look at that.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
