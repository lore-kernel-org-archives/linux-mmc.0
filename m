From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH] mmc: omap_hsmmc: support deferred probing for GPIOs
Date: Thu, 21 Mar 2013 12:39:05 +0100
Message-ID: <1363865945.4115.51.camel@coredoba.hi.pengutronix.de>
References: <1359536837-14874-1-git-send-email-jlu@pengutronix.de>
	 <1360838617.3892.27.camel@coredoba.hi.pengutronix.de>
	 <511CEC76.9020703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60688 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab3CULi5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Mar 2013 07:38:57 -0400
In-Reply-To: <511CEC76.9020703@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Thu, 2013-02-14 at 19:23 +0530, Balaji T K wrote:
> On Thursday 14 February 2013 04:13 PM, Jan L=C3=BCbbe wrote:
> > On Wed, 2013-01-30 at 10:07 +0100, Jan Luebbe wrote:
> >> If the CD/WP-GPIOs are not provided by the SoC's GPIO controller,
> >> we need to handle the case where omap_hsmmc is probed earlier than
> >> the GPIO controller chosen in the device tree.
> >>
> >> Fix this by checking the return value of of_get_named_gpio against
> >> -EPROBE_DEFER and passing it through to the probe function.
> >>
> >> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> >
> > Balaji, since you seem to be the new OMAP HSMMC maintainer, do you =
have
> > any comments on this patch?
>=20
> Looks good to me,
> Acked-by: Balaji T K <balajitk@ti.com>

Chris, would you take this?

Thanks,
Jan
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

