From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression for non-eMMC cards with commit fa550189?
Date: Tue, 29 May 2012 06:03:13 -0700
Message-ID: <20120529130312.GE12766@atomide.com>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
 <20120529125024.GM9577@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13530 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2E2NDS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 May 2012 09:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20120529125024.GM9577@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120529 05:56]:
> Hi,
> 
> On Tue, May 29, 2012 at 05:47:32AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [120529 00:46]:
> > > 
> > > Can you enable debugging on menelaus so we see what the driver is doing ?
> > > 
> > > I believe that to change the VMMC's supply voltage you need to turn off
> > > the regulator, meaning LDO_CTRL7[1:0] = 0b00.
> > 
> > Looks like it's some kind of race between the slots that now gets triggered
> > in the omap driver.
> > 
> > Commenting out the second slot in the board file fixes things. I tried adding
> > a mutex to protect the sequence between POWER_UP and POWER_ON, but no luck yet.
> > 
> > Also adding printk statements here and there makes it work again.
> 
> does this help ?

Thanks does not seem to help.

Tony
