From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2 v2] ARM: shmobile: lager: add gpio/fixed regulator for SDHI
Date: Wed, 20 Nov 2013 11:57:11 +0100
Message-ID: <1745725.K7bPWgBA4v@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <9182336.4KdqZZkpGQ@avalon> <87pppv8qx4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87pppv8qx4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Tuesday 19 November 2013 23:37:32 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > > >  #include <linux/platform_data/rcar-du.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/phy.h>
> > > > > 
> > > > > +#include <linux/regulator/driver.h>
> > > > 
> > > > I might be mistaken, but is this header really needed ?
> > > 
> > > Unfortunately, the compile will error without it.
> > > regulator_xxx / REGULATOR_XXX need it
> > 
> > I believe you should include regulator/machine.h instead of
> > regulator/driver.h.
> 
> This is the result.
> What is your opinion ?
> 
> --- with regulator/machine.h --------
>   CC      arch/arm/mach-shmobile/board-lager.o
> In file included from
> /opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lage
> r.c:36:0:
> /opt/usr/src/WORK/morimoto/gitlinux/linux/include/linux/regulator/gpio-regu
> lator.h:83:22: error: field 'type' has incomplete type
> /opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lage
> r.c:208:1: error: 'REGULATOR_VOLTAGE' undeclared here (not in a function)
> 
> --- with regulator/driver.h ------
>   CC      arch/arm/mach-shmobile/board-lager.o
> (no error)

I believe the enum regulator_type definition should be moved out of 
regulator/driver.h, but that's out of scope of this patch set, so I'm fine 
with including regulator/driver.h for now.

-- 
Regards,

Laurent Pinchart

