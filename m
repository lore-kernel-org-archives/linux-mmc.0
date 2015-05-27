From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: sdhci(imx6): misbehaves while installing debian jessie, "Got
 data interrupt 0x00100000"
Date: Wed, 27 May 2015 10:59:03 +0100
Message-ID: <20150527095903.GR2067@n2100.arm.linux.org.uk>
References: <20150519222320.GM2067@n2100.arm.linux.org.uk>
 <CAPDyKFqR3NwBd9O40BPzHG7Y4wyyJwgdB4NsA_GUO=YEyqFSXQ@mail.gmail.com>
 <20150526150122.GP2067@n2100.arm.linux.org.uk>
 <CAPDyKFp57ucUa5r+6RW1hDS2tci+xerc27ga5eoSwO6Wq57gig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45835 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbE0J7Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2015 05:59:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp57ucUa5r+6RW1hDS2tci+xerc27ga5eoSwO6Wq57gig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 27, 2015 at 11:44:59AM +0200, Ulf Hansson wrote:
> [...]
> 
> >> Though, the side-effect you are describing isn't very nice. Even if it
> >> doesn't solve you problem, perhaps we should discuss about converting
> >> from wait_for_completion() to wait_for_completion_timeout(), when the
> >> mmc core waits for the host driver to return the result for the
> >> request.
> >>
> >> I guess the tricky part is to find a decent value for the "timeout".
> >
> > There's two issues which would need solving for that:
> >
> > 1. The only sane timeout is one which will never trigger under normal
> >    operating circumstances, and abnormal load conditions.
> 
> Perhaps we could have the timeout calculated per request?
> 
> By using the current bus-speed and bus-width we can calculate the
> available bandwidth. Obviously we need to also account for overhead
> both at host and card side. Probably that overhead is taken from "best
> guesses", not sure.
> 
> Finally considering the amount of data for the request, we can
> calculate a value for the timeout.

The MMC specs already have this: cards specify exactly that in the
data.  However, that doesn't stop a card being buggy and supplying
incorrect values (hey, it works for Windows, ship it!)

The host is responsible for that part already (many hosts need to
have that programmed.)  So it doesn't make sense to use this.

What we're after here is something rather different: failure of the
host itself.  That should be a much longer timeout, one which we can
be sure will never trigger unless something has definitely gone wrong.
That's why I'd suggest something along the lines of ATA, around 60 to
120 seconds.  If the host has been dead for that long, it's definitely
dead.

(I know ATA's timeout very well, each time I put my very old Thinkpad
into standby mode, its APM talks to the drive, which then upsets Linux,
triggering that timeout... because it has disabled BM-DMA in one of the
control registers without Linux knowing.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
