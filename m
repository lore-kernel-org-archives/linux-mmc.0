From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Date: Mon, 8 Jul 2013 12:18:39 -0500
Message-ID: <1373303919.8183.164@snotra>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
	<1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:9300
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751874Ab3GHRSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jul 2013 13:18:46 -0400
In-Reply-To: <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
	(from Haijun.Zhang@freescale.com on Mon Jul  8 02:16:04 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, cjb@laptop.org, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> On T4240QDS board controllers has an unusable ADMA engine, so use  
> SDMA instead.
> Also 3.0v is support on T4240QDS board even if the capacity detailed  
> only 1.8v
> support. Without this quirk SD card will declare voltage not support  
> and
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>

...and what?

Why is this board-specific?  Isn't the controller part of the SoC, not  
part of the board?  If it really is board-specific, could you be more  
detailed about why (ideally with an erratum number), and check the  
toplevel board compatible (or get the information from platform code)  
rather than modify the device tree?

-Scott
