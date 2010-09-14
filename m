From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Tue, 14 Sep 2010 15:21:36 +0100
Message-ID: <20100914152136.082acc02@linux.intel.com>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
	<20100913173940.20345.66285.stgit@localhost.localdomain>
	<20100914142129.GF2629@pengutronix.de>
	<20100914144057.0d13f843@linux.intel.com>
	<20100914144512.GH2629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20192 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab0INPGY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 11:06:24 -0400
In-Reply-To: <20100914144512.GH2629@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Tue, 14 Sep 2010 16:45:12 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> On Tue, Sep 14, 2010 at 02:40:57PM +0100, Alan Cox wrote:
> > On Tue, 14 Sep 2010 16:21:29 +0200
> > Wolfram Sang <w.sang@pengutronix.de> wrote:
> > 
> > > On Mon, Sep 13, 2010 at 06:39:41PM +0100, Alan Cox wrote:
> > > > Coding style fixes
> > > > 
> > > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > > 
> > > Shouldn't this be folded into the patch which initially creates
> > > sdhci-intel-mid.c?
> > 
> > The work was done later and the signoffs are not the same. In the
> > ideal world - yes of course. I can redo them this way if you want
> > but it'll probably be about a month.
> 
> I would indeed prefer to first have minimal changes to the
> mmc/sdhci-core and then have the final version of sdhci-intel-mid.c
> put on top of that (also applies to patch 4/7). Less error prone and
> easier to review. Yet, I am not the one who is picking up the patches.
> 
> (BTW can't you just combine SoB if you fold patches?)

Ok will have a look at that next month and will also split the host
ops patches into a patch to add them and a patch to use them.


Alan
