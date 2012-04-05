From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap4: hsmmc: fix module re-insertion
Date: Thu, 5 Apr 2012 15:14:59 -0700
Message-ID: <20120405221458.GH3785@atomide.com>
References: <1331222320-31370-1-git-send-email-balajitk@ti.com>
 <20120405221136.GG3785@atomide.com>
 <87sjgh7rnr.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15447 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab2DEWPC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Apr 2012 18:15:02 -0400
Content-Disposition: inline
In-Reply-To: <87sjgh7rnr.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

* Chris Ball <cjb@laptop.org> [120405 15:17]:
> Hi Tony,
> 
> On Thu, Apr 05 2012, Tony Lindgren wrote:
> > * Balaji T K <balajitk@ti.com> [120308 07:27]:
> >> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
> >> Addng the offset to platform_device resource structure
> >> increments the start address for every insmod operation.
> >> MMC command fails on re-insertion as module due to incorrect register base.
> >> Fix this by updating the ioremap base address only.
> >
> > Any news on getting this fix merged during the -rc cycle?
> >
> > This is pretty important fix for anybody wanting to reload
> > the omap_hsmmc.ko module..
> 
> It's in my fixes branch, planning on sending that to Linus tomorrow.

OK thanks for the update.

Tony
