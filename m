From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 20/31] ARM: amba: versatile: get rid of private platform
 amba_device initializer
Date: Tue, 24 Jan 2012 15:06:59 +0000
Message-ID: <20120124150659.GK19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmU-0005Fb-9y@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36214 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401Ab2AXPHT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 10:07:19 -0500
Content-Disposition: inline
In-Reply-To: <E1RoAmU-0005Fb-9y@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>

On Fri, Jan 20, 2012 at 09:29:10AM +0000, Russell King - ARM Linux wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-versatile/core.c         |   36 ++++++++++++++++----------------
>  arch/arm/mach-versatile/core.h         |   20 ++++-------------
>  arch/arm/mach-versatile/versatile_pb.c |   10 ++++----
>  3 files changed, 28 insertions(+), 38 deletions(-)

This seems happy enough on a Versatile AB926, although I do get spurious
IRQs from the ethernet chip:

	eth0: spurious interrupt (mask = 0xb3)

This doesn't seem to be the fault of this patch though; I suspect it's
related to the recent VIC changes and removal of MULTI_IRQ_HANDLER
(especially since the ethernet interrupts lives on the secondary
controller).

So for this patch:

Tested-by: Will Deacon <will.deacon@arm.com>

I'll investigate the other problem separately.

Will
