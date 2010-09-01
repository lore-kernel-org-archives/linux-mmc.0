From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround
 powered resume
Date: Wed, 1 Sep 2010 16:56:46 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307D2F41840@SC-VEXCH1.marvell.com>
References: <1279763215-17574-1-git-send-email-bzhao@marvell.com>
	<m339tz6agq.fsf@pullcord.laptop.org>
 <AANLkTinSO-SMyXCv3r-p5TOgWSkyyrSSe3KJX5V=7kHW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:55025 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0IBAAL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 20:00:11 -0400
In-Reply-To: <AANLkTinSO-SMyXCv3r-p5TOgWSkyyrSSe3KJX5V=7kHW@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>

Hi Michal,

Thanks for your comment.

> -----Original Message-----
> From: Micha=B3 Miros=B3aw [mailto:mirqus@gmail.com]
> Sent: Wednesday, September 01, 2010 11:40 AM
> To: Chris Ball
> Cc: Bing Zhao; linux-mmc@vger.kernel.org; Nicolas Pitre; Andrew Morto=
n
> Subject: Re: [PATCH] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround=
 powered resume
>=20
> 2010/8/27 Chris Ball <cjb@laptop.org>:
> > Any comments on this patch from the list?
> >
> > From: Bing Zhao <bzhao@marvell.com>
> > Date: Wed, 21 Jul 2010 18:46:55 -0700
> >
> > Marvell 8686/8688 device will not respond to re-probe attemps
> > in powered resume, if the card is in sleep mode.
> > The added MMC_PM_SKIP_RESUME_PROBE flag is checked so that
> > call to mmc_sdio_init_card() can be skipped.
> [patch cut]
>=20
> Simplified SDIO spec v.2.00 (section 6.14 - Bus State Diagram)
> suggests, that initialization commands (CMD5, CMD3) are not accepted
> in CMD state. As the card stays in that state on powered suspend (no
> resetting CMD52 nor power cycle is issued) then reinitialization
> should be entirely skipped on resume unless the power was lost betwee=
n
> suspend and resume (or card was temporarily removed from the slot).

With that said, skipping initialization on powered resume is needed in =
general. We can just check MMC_PM_KEEP_POWER flag to skip the card init=
ialization.

I will send the updated patch.

Regards,

Bing

>=20
> Best Regards,
> Micha=B3 Miros=B3aw
