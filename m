From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] Race fixes in sdhci
Date: Wed, 27 Apr 2011 22:04:00 +0100
Message-ID: <20110427210400.GA30875@opensource.wolfsonmicro.com>
References: <20110427132329.GA21499@opensource.wolfsonmicro.com>
 <BANLkTint2cr6vFwBGX1RCTYyvrTc0if=yA@mail.gmail.com>
 <m3y62vl954.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44906 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756844Ab1D0VDx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 17:03:53 -0400
Content-Disposition: inline
In-Reply-To: <m3y62vl954.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

On Wed, Apr 27, 2011 at 04:41:27PM -0400, Chris Ball wrote:

> No, I think Mark's saying there's a race of:

> * the successful completion interrupt fires, and

> * the host timer fires to signify timeout due to *lack* of an interrupt
>   (via sdhci_timeout_timer()).  i.e., the completion interrupt fires
>   very close to the timeout period.

> Both cases call tasklet_schedule(&host->finish_tasklet), and if you
> manage to schedule a tasklet while it's already running, it runs again
> after it completes -- but during the first run we set host->mrq->cmd to
> NULL, so then it oopses on the second run.

Yes, exactly - that's what I saw through code inspection.  I haven't
actually seen this directly and analysed enough to understand a
particular race, I just looked at the fixes that we are carrying in our
tree and looked at the code sufficiently to determine that the fixes
addressed an issue I could identify.

> We could consider taking Mark's first patch and also adding to the top:

Ben's patch.

>         /*
>          * If we get scheduled twice concurrently, this tasklet will
>          * be run again afterwards but without any active request.
>          */
>         if (!host->mrq)
>                 return;

> .. and pushing to .39 with a stable@ tag.

Yes, that's a broader way of writing Dimitris' patch.  The issue isn't
concurrent *schedules* - they will just fall out into a single queue for
the task - it's that the tasklet can be rescheduled while it's running.
