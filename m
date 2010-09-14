From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Tue, 14 Sep 2010 17:41:25 +0100
Message-ID: <20100914174125.387f4b29@linux.intel.com>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
	<20100913173940.20345.66285.stgit@localhost.localdomain>
	<20100914142129.GF2629@pengutronix.de>
	<20100914144057.0d13f843@linux.intel.com>
	<20100914144512.GH2629@pengutronix.de>
	<20100914165743.GA19431@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39261 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab0INR0m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 13:26:42 -0400
In-Reply-To: <20100914165743.GA19431@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

> into 2.6.37, which is worth trying for.  I like Wolfram's suggested 
> patchset format.  Alan, do you feel comfortable re-doing this in time
> for some testing before the merge window opens, or should I help?

Redoing it shouldn't be a problem, getting testing of the MID bits
will slow it down a fair bit. I'm not in a huge rush - I need to get
the SFI device patches merged before an upstream kernel will actually
be useful on a MID device.

> The big question seems to be whether the approach the patchset takes
> -- moving from quirks to hooks, extending sdhci.c without creating a 
> full driver, and the initial choice of overridable hooks -- makes
> sense.  I'd be happy to hear everyone's thoughts on that.

I'd rather see that discussion happen and then redo the MID patches to
match whatever turns out to suit a more generalised set of driver
tidyups this way than push it in ASAP.

That also fits my timetable better as I've got an exam coming up early
October and other stuff to push before I run off and hide revising.
