From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Mon, 8 Jul 2013 17:27:50 -0300
Message-ID: <20130708202749.GA2596@localhost>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
 <20130707201309.GA5429@localhost>
 <20130708074606.GD16635@arwen.pp.htv.fi>
 <20130708195828.GA28218@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60559 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3GHU1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 16:27:45 -0400
Content-Disposition: inline
In-Reply-To: <20130708195828.GA28218@kahuna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nishanth Menon <nm@TI.COM>
Cc: Felipe Balbi <balbi@TI.COM>, Balaji T K <balajitk@TI.COM>, a-bindra@TI.COM, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org

On Mon, Jul 08, 2013 at 02:58:28PM -0500, Nishanth Menon wrote:
> On 10:46-20130708, Felipe Balbi wrote:
> > On Sun, Jul 07, 2013 at 05:13:10PM -0300, Ezequiel Garcia wrote:
> > > Hi guys,
> > >=20
> > > On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> > > > On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > > > > From: Amarinder Bindra <a-bindra@ti.com>
> > > > >
> > > > > OMAP's hs_mmc driver is also used for OMAP5 MMC controller op=
eration.
> > > > > Considering that the device tree entries are already there fo=
r this,
> > > > > allow the driver to be built when only OMAP5 is enabled.
> > > > > This allows MMC root filesystems to be available in "OMAP5 on=
ly"
> > > > > configurations.
> > > > >
> > > > > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > > > > Acked-by: Felipe Balbi <balbi@ti.com>
> > > > > Acked-by: Nishanth Menon <nm@ti.com>
> > > >=20
> > > > Looks good to me,
> > > > Acked-by: Balaji T K <balajitk@ti.com>
> > > >=20
> > >=20
> > > I came across this same issue while trying MMC patches on AM3xx,
> > > which is nor OMAP3 neither OMAP4.
> > >=20
> > > Now, looking at the driver I don't see any OMAP-specific bits
> > > (welcome to the multiplatform world ;-) so I think we can just
> > > remove the 'depends' line. Something like this:
> >=20
> > frankly speaking, this driver should be deleted and all users shoul=
d be
> > moved to sdhci. OMAP's HSMMC controller is compatible with SDHCI ex=
cept
> > for a couple quirks which can be easily worked around.

@Felipe:
Do you mind giving me some hints about this quirks? I'm not too familia=
r
with these drivers.

> Do we take that as a NAK to this specific patch?
>=20
> I am not complaining about the future migration to a solution that is
> much more generic and scalable, but having fixes for current problems
> should'nt be ignored IMHO.
>=20

Of course.

> How about a depends on CONFIG_ARCH_OMAP2PLUS instead? will that solve
> our pains with all OMAP2+ usin this?

Yes, I think that using ARCH_OMAP2PLUS should do. FWIW, until we have
sdhci ready to replace omap_hsmmc, we have no choice but to apply such
a patch.

@Nishant, Balaji: Can you take care of resending this?

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
