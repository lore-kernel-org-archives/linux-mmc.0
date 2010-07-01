From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for
 MMC1 Controller
Date: Thu, 1 Jul 2010 15:33:43 +0300
Message-ID: <20100701123342.GQ2822@atomide.com>
References: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
 <20100617131520.3b676052.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100617131520.3b676052.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [100617 23:09]:
> On Thu, 17 Jun 2010 20:57:19 +0530 (IST)
> "kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
> 
> > Adding card detect callback function which gives the status of
> > the card .For MMC1 Controller, Card detect interrupt source is
> > twl6030 and card present/absent status is provided by MMCCTRL
> > register of twl6030.
> > 
> > Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c   |   11 +++++--
> >  arch/arm/mach-omap2/hsmmc.c           |    1 +
> >  arch/arm/plat-omap/include/plat/mmc.h |    1 +
> >  drivers/mfd/twl6030-irq.c             |   23 ++++++++++++++++
> >  drivers/mmc/host/omap_hsmmc.c         |   30 ++++++++++++++++++---
> >  include/linux/i2c/twl.h               |   46 +++++++++++++++++++++++++++++++++
> >  6 files changed, 104 insertions(+), 8 deletions(-)
> 
> I assume this depends on "[PATCH v5 1/2] OMAP HSMMC: Adding a Flag to
> determine the type of Card detect"?
> 
> It's all a bit too remote from my (ever-expanding) work area, so I'll
> assume that Tony or someone will look after these.
 
Yeah we'll queue these via the omap patches once everybody is
happy with them.

Regards,

Tony
