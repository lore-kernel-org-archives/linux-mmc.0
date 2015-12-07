From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: fix racy probe cleanup
Date: Mon, 7 Dec 2015 16:46:24 +0000
Message-ID: <20151207164623.GT8644@n2100.arm.linux.org.uk>
References: <E1a5tlb-0000UY-81@rmk-PC.arm.linux.org.uk>
 <CAPDyKFr6qMJAPW7WMXD--Dhy32iJ8iOmfOS2wXCPWFq7B891yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60146 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbbLGQqc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2015 11:46:32 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr6qMJAPW7WMXD--Dhy32iJ8iOmfOS2wXCPWFq7B891yA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Dec 07, 2015 at 05:10:29PM +0100, Ulf Hansson wrote:
> On 7 December 2015 at 12:15, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > MMC probe cleanup is racy: consider the following sequence:
> >
> > - mmc_alloc_host()
> > - mmc_gpio_request_cd()
> > - some failure
> > - mmc_free_host()
> >
> > mmc_gpio_request_cd() registers a handler for the card detect GPIO
> > signal, and if this is triggered, it can queue the delayed work in
> 
> mmc_gpio_request_cd() requests the GPIO, but doesn't request the IRQ.
> Instead that's delayed until mmc_add_host() is called.
> 
> > struct mmc_host.  mmc_free_host() then frees the mmc_host structure
> > with the still queued delayed work, which will then cause the timer
> > subsystem to touch free'd memory, potentially oopsing the kernel.
> 
> Because of the above, I don't think this can happen..
> 
> ...unless there are some specific cases when hosts dealing with
> registering the GPIO CD irq themselves, is that so?

This is over a year old, and I forget the details now.  I'll drop the
patch for now.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
