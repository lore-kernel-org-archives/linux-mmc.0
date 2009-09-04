From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: MMC driver support on OMAP4
Date: Fri, 4 Sep 2009 12:33:47 -0700
Message-ID: <20090904193347.GD15715@atomide.com>
References: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com> <20090904121912.4b4e2b5a.akpm@linux-foundation.org> <FCCFB4CDC6E5564B9182F639FC35608702F9B8A526@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59877 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbZIDTd6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2009 15:33:58 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9B8A526@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [090904 12:24]:
> Andrew/Kishore
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andrew
> >Morton
> >Sent: Friday, September 04, 2009 2:19 PM
> >
> >On Wed, 2 Sep 2009 18:54:36 +0530 (IST)
> >"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
> >
> >> This Patch adds basic support for all 5 MMC controllers on OMAP4.
> >>
> >> -Kishore
> >>
> >> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> >> ---
> >> This patch doesn't include mmc-regulator support
> >>
> >
> >This looks like an ARM patch more than an MMC patch.  I grabbed it as
> >an MMC thing but hopefully someone else will grab it for a more
> >appropriate tree.
> 
> A patch split is required:
> 
> >>  arch/arm/mach-omap2/devices.c          |   42 +++++++++++++++++++++++++++++----
> >>  arch/arm/plat-omap/include/mach/irqs.h |    2 +
> >>  arch/arm/plat-omap/include/mach/mmc.h  |    9 ++++++-
> 
> These files will go through linux-omap -> arm: to RMK
> 
> >>  drivers/mmc/host/Kconfig               |    6 ++--
> >>  drivers/mmc/host/omap_hsmmc.c          |   10 +++++++
> >>  5 files changed, 60 insertions(+), 9 deletions(-)
> 
> These files can go through Andrew.

No need to split it IMHO, it's best to merge it all together
via Andrew's MMC queue as it should not conflict with other
arch/arm/*omap* stuff.

Acked-by: Tony Lindgren <tony@atomide.com>
