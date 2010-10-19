From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: sdhci_dumpregs: allow private information to be
	dumped on error
Date: Tue, 19 Oct 2010 21:04:45 +0100
Message-ID: <20101019200445.GB28424@void.printf.net>
References: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com> <20101019194724.GC31336@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52430 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab0JSUEt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Oct 2010 16:04:49 -0400
Content-Disposition: inline
In-Reply-To: <20101019194724.GC31336@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Tue, Oct 19, 2010 at 09:47:24PM +0200, Wolfram Sang wrote:
> On Tue, Oct 19, 2010 at 11:27:22AM -0700, Philip Rakity wrote:
> > Our controller has private registers that are useful to see on error.
> > define a new host->ops to allow these registers to be printed
> > 
> > Signed-off-by: Philip Rakity <prakity@marvell.com>
> 
> I wonder if we really need such a thing in the mainline kernel? It is probably
> used for debugging the driver?

There's another question:  why merge a patch that adds a hook that isn't
used by anything currently in the kernel?  Should we wait until this is
accompanied by a print_private_info() implementation in a mainline
driver, rather than adding it proactively?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
