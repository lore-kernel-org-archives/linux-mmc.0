From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Thu, 13 May 2010 12:49:22 -0700
Message-ID: <20100513194922.GD3428@atomide.com>
References: <1267984078-6036-1-git-send-email-darkstar6262@gmail.com>
 <20100513192934.GB3428@atomide.com>
 <20100513124121.753689ce.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58540 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514Ab0EMTtb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2010 15:49:31 -0400
Content-Disposition: inline
In-Reply-To: <20100513124121.753689ce.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>

* Andrew Morton <akpm@linux-foundation.org> [100513 12:36]:
> On Thu, 13 May 2010 12:29:35 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Cory Maccarrone <darkstar6262@gmail.com> [100307 09:44]:
> > > From: Marek Belisko <marek.belisko@open-nandra.com>
> > > 
> > > The omap850 and omap730 use 16-bit registers instead of 32-bit, requiring
> > > a modification of the register addresses in the mmc-omap driver.  To resolve
> > > this, a bit shift is performed on base register addresses, either by 1 or 2
> > > bits depending on the CPU in use.  This yields the correct registers for
> > > each CPU.
> > > 
> > > Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> > > Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Can you please queue this patch too? Ben's comments in this thread
> > were for the i2c-omap, not for this MMC patch. We've had this patch
> > in the omap tree for testing for quite a while now.
> > 
> > The patch is also available in at:
> > 
> > https://patchwork.kernel.org/patch/83971/
> > 
> > with the direct link to the mbox being:
> > 
> > https://patchwork.kernel.org/patch/83971/mbox/
> 
> I already have that, as mmc-omap-add-support-for-16-bit-and-32-bit-registers.patch

OK, thanks. I should have checked your queue first.

Tony
