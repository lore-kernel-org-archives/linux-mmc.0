From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
Date: Sun, 18 Nov 2018 14:44:07 -0800
Message-ID: <20181118224407.GO53235@atomide.com>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
 <20181118222043.GA23485@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181118222043.GA23485@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Andrzej Zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [181118 22:22]:
> Aaro,
> 
> On Sun, Nov 18, 2018 at 10:19:19PM +0200, Aaro Koskinen wrote:
> > Since v2.6.22 or so there has been reports [1] about OMAP MMC being
> > broken on OMAP15XX based hardware (OMAP5912 and OMAP310). The breakage
> > seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
> > omap to use MMC_POWER_ON") that changed clock enabling to be done
> > on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
> > the hardware doesn't seem to like it and the MMC just stops responding.
> > Fix by memorizing the power mode and do the init only when necessary.
> 
> I'm going to use this patch as an argument against anybody complaining
> kernel bugs do not get fixed. People just need to teach themselves to
> be patient.

Yup, good to have more usable devices :) And thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
