From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 11/15] wireless: wl1271: introduce platform device support
Date: Wed, 11 Aug 2010 00:21:30 +0300
Message-ID: <AANLkTincjpb4_c13AAx-HoZ5xsdunRGkVeO1P5EJegX1@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com> <4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com> <AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com> <alpine.LFD.2.00.1007061316010.6020@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46165 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab0HJVVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 17:21:50 -0400
In-Reply-To: <alpine.LFD.2.00.1007061316010.6020@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Roger Quadros <roger.quadros@nokia.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>

On Tue, Jul 6, 2010 at 8:42 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Another function pair would be needed instead, which would do almost
> like the suspend/resume code is already doing. =A0Something like:
>
> /*
> =A0* Indicate to the core SDIO layer that we're not requiring that th=
e
> =A0* function remain powered. =A0If all functions for the card are in=
 the
> =A0* same "no power" state, then the host controller can remove power=
 from
> =A0* the card. =A0Note: the function driver must preserve hardware st=
ates if
> =A0* necessary.
> =A0*/
> int sdio_release_power(struct sdio_func *func);
>
> /*
> =A0* Indicate to the core SDIO layer that we want power back for this
> =A0* SDIO function. =A0The power may or may not actually have been re=
moved
> =A0* since last call to sdio_release_power(), so the function driver =
must
> =A0* not assume any preserved state at the hardware level and re-perf=
orm
> =A0* all the necessary hardware config. =A0This function returns 0 wh=
en
> =A0* power is actually restored, or some error code if this cannot be
> =A0* achieved. =A0One error reason might be that the card is no longe=
r
> =A0* available on the bus (was removed while powered down and card
> =A0* detection didn't trigger yet).
> =A0*/
> int sdio_claim_power(struct sdio_func *func);
>
> That's it. =A0When the network interface is down and the hardware is =
not
> needed, you call sdio_release_power(). =A0When the request to activat=
e the
> network interface is received, you call sdio_claim_power() and config=
ure
> the hardware appropriately. =A0If sdio_claim_power() returns an error=
,
> then you just return an error to the network request, and eventually =
the
> driver's remove method will be called if this is indeed because the c=
ard
> was removed.
>

After playing with this a little, I am getting convinced that the way
to go here is to add runtime pm support to MMC/SDIO.

It just fits perfectly into this model:

Runtime PM already takes care of usage count per device (so it would
tell if an SDIO function is idle), takes into account parent-child
relationships (so if all SDIO functions are idle, it would
automatically send an idle request to the card device), doesn't break
existing drivers (drivers needs to explicitly enable it), play along
nicely with the system suspend/resume, etc..

I'm going to split the patches to two:
- first half would be basic wl1271 support for omap/zoom. it's pretty
straight forward and can probably already go thru.
- second half would be adding runtime PM to SDIO/MMC. I'll post some
initial patches to set off a discussion.

Thanks,
Ohad.
