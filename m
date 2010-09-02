From: Matt Fleming <matt@console-pimps.org>
Subject: Re: MMC patches in-flight.
Date: Thu, 2 Sep 2010 06:50:23 +0100
Message-ID: <20100902055023.GA6733@console-pimps.org>
References: <m3tym9xbwx.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:38983 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026Ab0IBFu0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 01:50:26 -0400
Content-Disposition: inline
In-Reply-To: <m3tym9xbwx.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, Sep 01, 2010 at 07:49:02PM -0400, Chris Ball wrote:
> Hi,
> 
> Here's an attempt to summarize the state of MMC patches submitted to
> linux-mmc@ that haven't been merged.  Feel free to correct anything,
> especially if you have a patch that you think is waiting to be merged
> that I've listed without "->", or that I haven't listed at all.
> Please also consider reviewing any patches in the "review" state.
> Thanks!
> 
> Patch author   | Patch subject                                | Next step

[...]

> Yusuke Goda    | tmio_mmc: Revise a limit of the data size    | resubmit

This patch is actually now called,

"[PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode" and it's in
the testing phase.
