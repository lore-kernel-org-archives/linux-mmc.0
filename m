From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] MMC: error handling improvements
Date: Sat, 19 Feb 2011 15:00:06 +0000
Message-ID: <20110219150006.GH29493@n2100.arm.linux.org.uk>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk> <8yaoc6c7tan.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36683 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab1BSPAV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Feb 2011 10:00:21 -0500
Content-Disposition: inline
In-Reply-To: <8yaoc6c7tan.fsf@huya.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Feb 15, 2011 at 03:49:04PM -0800, David Brown wrote:
> On Tue, Feb 15 2011, Russell King - ARM Linux wrote:
> 
> > This patch is for RFC only; it needs splitting up somewhat.  However, I
> > wanted to get it out there for some comment.
> 
> Just for kicks, I applied this and ran it on an MSM target (8x50).  It
> seems to cause lots of:
> 
>   mmc0: Data timeout
>   mmc0: Controller has been re-initialized
>   ...
>   mmc0: Data CRC error
> 
> and I can post more if you would find them interesting.  Eventually the
> MSM mmc driver derefernces a null pointer in the interrupt code.

That doesn't look right.  If resetting the MMC controller results in all
state being lost, it presumably means the card gets powered down too.
If that happens, the card needs to be reinitialized from scratch again,
and I don't see how that happens in this driver.

Nothing in this patch should cause data timeouts to appear where they
weren't already appearing before the patch - the patch only changes
what happens after an error occurs, so you must already be encountering
errors on the interface before you applied this patch.
