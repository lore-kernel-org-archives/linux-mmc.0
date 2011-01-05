From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
Date: Wed, 5 Jan 2011 22:44:23 +0000
Message-ID: <20110105224423.GA13209@void.printf.net>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de> <1293628874-8140-2-git-send-email-arnd@arndnet.de> <20110105212223.GJ9198@void.printf.net> <4D24F124.9000303@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48554 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1AEWoZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 17:44:25 -0500
Content-Disposition: inline
In-Reply-To: <4D24F124.9000303@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org

Hi Arnd,

On Wed, Jan 05, 2011 at 11:31:00PM +0100, Arnd Hannemann wrote:
> Hmm, I could not reproduce this.
> delayed_reset_work should not be in the #ifdef TMIO_MMC_DMA #endif scope.
> And it isn't according to the patch.
> 
> I tried with mmc-next last commit "549bad416ef62f09711cb22e77adff029e27ce07".
> The patch would apply with some fuzz, but compilation without CONFIG_TMIO_MMC_DMA=y works.

Oops, my apologies -- I mishandled the fuzz.  The patch is fine as-is.
I've pushed it to mmc-next now.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
