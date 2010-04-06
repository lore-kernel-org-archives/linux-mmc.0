From: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: Is anyone working on SD/MMC driver for i.MX35 ?
Date: Tue, 6 Apr 2010 11:12:21 +0200
Message-ID: <20100406091220.GA2036@bluebox.local>
References: <20100401125739.GE2045@bluebox.local>
 <20100401132017.GA30804@buzzloop.caiaq.de>
 <20100401132234.GG2045@bluebox.local>
 <20100402012932.GE13989@pengutronix.de>
 <20100405182103.GB3316@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:36494 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab0DFJMi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Apr 2010 05:12:38 -0400
Content-Disposition: inline
In-Reply-To: <20100405182103.GB3316@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "Hans J. Koch" <hjk@linutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@caiaq.de>, John Ogness <jogness@linutronix.de>

On Mon, Apr 05, 2010 at 10:21:03PM +0400, Anton Vorontsov wrote:
> On Fri, Apr 02, 2010 at 03:29:32AM +0200, Wolfram Sang wrote:
> > On Thu, Apr 01, 2010 at 03:22:35PM +0200, Hans J. Koch wrote:
> > > On Thu, Apr 01, 2010 at 03:20:17PM +0200, Daniel Mack wrote:
> > > > On Thu, Apr 01, 2010 at 02:57:40PM +0200, Hans J. Koch wrote:
> > > > > I need to get the MMC interface of an i.MX35 to work in the near future.
> > > > > To avoid duplicate work, I'd like to know if anybody already started
> > > > > work on this.
> > > > 
> > > > Is the controller very different from the one which is already supported
> > > > for MX31?
> > > 
> > > Yep. Completely different beast. Unfortunately.
> > 
> > (CCing linux-mmc)
> > 
> > And it is a mess, really :(
> > 
> > The kernel already has an esdhc-driver (and Anton already worked around a
> > number of hardware-bugs), but is tied into an of-driver because the core was
> > also used on PowerPC. There, it utilizes a 32-bit-byte-swaper which is not
> > needed on ARM. So, one has to rip all that out, generalize the sdhc-platform
> > support (possibly also abstract the quirk support) and make sure nothing
> > breaks.
> 
> FYI, there is sdhci-pltfm driver, + some patches to add
> quirks support:
> 
> http://lkml.org/lkml/2010/3/16/337
> 
> These patches are already in the -mm tree.

Thanks a lot for all your hints! Will have a deeper look at that.

Thanks,
Hans
