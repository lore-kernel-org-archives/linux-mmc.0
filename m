From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: OMAP MSDI: fix broken PIO mode
Date: Mon, 27 Aug 2012 18:42:42 -0400
Message-ID: <873938yn19.fsf@octavius.laptop.org>
References: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57227 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab2H0Wmz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 18:42:55 -0400
In-Reply-To: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 24 Aug 2012 06:00:18 +0000 (UTC)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, Carlos Aguiar <carlos.aguiar@indt.org.br>, tony@atomide.com, Juha =?utf-8?B?WXJqw7Zsw6Q=?= <juha.yrjola@nokia.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Aug 24 2012, Paul Walmsley wrote:
> After commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0 ("mmc:
> omap_hsmmc: remove private DMA API implementation"), the Nokia N800
> here stopped booting:
>
> [    2.086181] Waiting for root device /dev/mmcblk0p1...
> [    2.324066] Unhandled fault: imprecise external abort (0x406) at 0x00000000
> [    2.331451] Internal error: : 406 [#1] ARM
> [    2.335784] Modules linked in:
> [    2.339050] CPU: 0    Not tainted  (3.6.0-rc3 #60)
> [    2.344146] PC is at default_idle+0x28/0x30
> [    2.348602] LR is at trace_hardirqs_on_caller+0x15c/0x1b0
>
> ...
>
> This turned out to be due to memory corruption caused by long-broken
> PIO code in drivers/mmc/host/omap.c.  (Previously, this driver had
> been using DMA; but the above commit caused the MMC driver to fall
> back to PIO mode with an unmodified Kconfig.)
>
> The PIO code, added with the rest of the driver in commit
> 730c9b7e6630f786fcec026fb11d2e6f2c90fdcb ("[MMC] Add OMAP MMC host
> driver"), confused bytes with 16-bit words.  This bug caused memory
> located after the PIO transfer buffer to be corrupted with transfers
> larger than 32 bytes.  The driver also did not increment the buffer
> pointer after the transfer occurred.  This bug resulted in data
> corruption during any transfer larger than 64 bytes.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Yuck.  Thanks for tracking that down, Paul -- pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
