From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] mmc: change initial clock setting
Date: Sat, 26 Jun 2010 17:57:45 +0100
Message-ID: <87tyopg29i.fsf@linux-g6p1.site>
References: <4C1AF098.1080400@samsung.com> <87iq5gfr6j.fsf@linux-g6p1.site> <4C1EEAA1.4020005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:37017 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753294Ab0FZQ5t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Jun 2010 12:57:49 -0400
In-Reply-To: <4C1EEAA1.4020005@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org

On Mon, 21 Jun 2010 13:29:21 +0900, Jaehoon Chung <jh80.chung@samsung.c=
om> wrote:
> On 2010-06-18 =EC=98=A4=ED=9B=84 9:42, Matt Fleming wrote:
> > On Fri, 18 Jun 2010 13:05:44 +0900, Jaehoon Chung <jh80.chung@samsu=
ng.com> wrote:
> >> This patch is bug fixed..
> >> I think that host->ios.clock(initial clock) will be set lower than=
 400KHz.
> >> But in this code, if host->f_min is higher than 400KHz, print warn=
ing message and set higher than 400KHz.
> >> And We use SDHCI_QUIRK_NONSTANDARD_CLOCK..so using get_min_clock f=
unction.=20
> >> but didn't effect nothing through used get_min_clock function.
> >=20
> > I'm a little confused. What problem are you fixing with this patch?=
 What
> > issue are you seeing? SDHCI_QUIRK_NONSTANDARD_CLOCK is only for sdh=
ci.
> > If this is the old "my card won't initialise at 400kHz" chestnut I =
don't
> > think a solution has ever been agreed upon. The problem was that wh=
ile
> > some cards won't initialise at 400kHz, some controllers will try to
> > initialise at too low a frequency which causes other problems.
> >=20
> > Sascha Hauer explains the reason for setting ios.clock to 400kHz he=
re,
> >=20
> >        http://lkml.org/lkml/2010/1/5/120
> >=20
> > So I think your patch will cause problems.
> >=20
> > Which driver are you using? The driver should have set the f_min va=
lue
> > to be <=3D 400kHz. Maybe it is a good idea to set the value of ios.=
clock
> > to 400kHz if the driver has set a bogus f_min value, we will at lea=
st
> > have a fighting chance of initialising the card (though I would say=
 that
> > the driver was broken, but at least core.c will print a warning).
> >=20
>=20
> when ios.clock is higher than 400KHz, why not change 400KHz?(if 400KH=
z seemed like good value)
> if clock value is higher than 400KHz, i think card can't initialize..=
=2Emaybe

I think this part of your patch is OK.

> when sdhci controller set f_min value(ie, 300KHz), clock changed 400K=
Hz in core.c.
> just this code purpose to print warning message?

Well, the purpose of the code is to set the clock to 400kHz if the valu=
e
of f_min is too low, as having a low value can cause some controllers t=
o
break.
