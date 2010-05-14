From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/5] OMAP4 HSMMC: Adding hsmmc support to board file
Date: Fri, 14 May 2010 23:05:08 +0100
Message-ID: <20100514220508.GC7185@flint.arm.linux.org.uk>
References: <12490.10.24.255.17.1273781497.squirrel@dbdmail.itg.ti.com> <20100514215651.GI3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60844 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab0ENWF0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 May 2010 18:05:26 -0400
Content-Disposition: inline
In-Reply-To: <20100514215651.GI3428@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, paul@pwsan.com, adrian.hunter@nokia.com

On Fri, May 14, 2010 at 02:56:51PM -0700, Tony Lindgren wrote:
> * kishore kadiyala <kishore.kadiyala@ti.com> [100513 13:06]:
> > Support for MMC1 & MMC2 controllers is added to the board file.
> > Also includes configuration of MMC1 Card detect initially.
> 
> This patch does not seem to apply, I don't know where you're getting
> the sdp4430_vmmc_supply in this patch?
> 
> I suggest you forget about the card detect patches for now and
> first produce a minimal set of patches to get the MMC working
> for board-4430sdp.c. The card detect patches should be applied
> only after board-4430sdp.c works for MMC. And we're running out
> of time for this merge window.

Absolutely - we _really_ _really_ _really_ need to get MMC usable
on the 4430SDP for this merge window - don't care about the card
detection provided the system can find a MMC card which is left
plugged in.

To do this makes the overall 4430SDP more usable than it currently
is with mainline kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
