From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] generic runtime pm callbacks
Date: Mon, 6 Sep 2010 15:59:51 +0100
Message-ID: <20100906145951.GI10367@rakim.wolfsonmicro.main>
References: <20100906132241.GH8381@sirena.org.uk>
 <Pine.LNX.4.44L0.1009061025300.14908-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33105 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751321Ab0IFO7y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 10:59:54 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1009061025300.14908-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Mon, Sep 06, 2010 at 10:30:05AM -0400, Alan Stern wrote:

> The real issue with USB interfaces is that they are only logical
> sub-devices; they can't be power-managed separately from their parent.  
> Indeed, the runtime_suspend and runtime_resume callbacks for interfaces
> always return 0 immediately without doing anything, and the
> runtime_idle callback always calls pm_runtime_suspend.


> So why not tell the PM core about this behavior?  Let's put a
> "no_callbacks" flag in dev_pm_info.  When this flag is set the core
> won't bother invoking the runtime callbacks; it can always assume
> success.  More importantly, an asynchronous request may never need to
> use the workqueue:

...

> Does that look like what you're talking about?

That'd cover my use case, though it would still be nice to have the
flexibility to just omit individual callbacks in the same way that it's
possible to do so with regular suspend and resume (eg, if you only have
to restore some state after the bus has suspended your device).
