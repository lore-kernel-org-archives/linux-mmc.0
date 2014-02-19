From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH RFC 03/31] mmc: sdio_irq: rework sdio irq handling
Date: Tue, 18 Feb 2014 22:40:33 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402182233590.17677@knanqh.ubzr>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIP-0006li-SO@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:24596 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbaBSDkf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 22:40:35 -0500
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1800IDT4VMA1D2@VL-VM-MR004.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 18 Feb 2014 22:40:34 -0500 (EST)
In-reply-to: <E1WFmIP-0006li-SO@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On Tue, 18 Feb 2014, Russell King wrote:

> Rather than the SDIO support spawning it's own thread for handling card
> interrupts, use the generic IRQ infrastructure for this, triggering it
> from the host interface's interrupt handling directly.
> 
> This avoids a race between the parent thread waiting to receive an
> interrupt response from the card, and the slow startup from the sdio
> irq thread, which can occur as a result of high system load (eg, while
> udev is running.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> =-DO NOT APPLY-=
>  drivers/mmc/core/sdio_irq.c | 41 +++++++++++++++++++++++++++++++----------
>  include/linux/mmc/host.h    |  3 +++
>  2 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index aaa90460ed23..f23d73993dc6 100644
> =-DO NOT APPLY-= a/drivers/mmc/core/sdio_irq.c
> =+DO NOT APPLY+= b/drivers/mmc/core/sdio_irq.c
> @@ -90,6 +90,15 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  	return ret;
>  }
>  
> =+DO NOT APPLY+=void sdio_run_irqs(struct mmc_host *host)
> =+DO NOT APPLY+={
> =+DO NOT APPLY+=	mmc_claim_host(host);
> =+DO NOT APPLY+=	host->sdio_irq_pending = true;
> =+DO NOT APPLY+=	process_sdio_pending_irqs(host);
> =+DO NOT APPLY+=	mmc_release_host(host);
> =+DO NOT APPLY+=}
> =+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdio_run_irqs);
> =+DO NOT APPLY+=

Could you please dispense with those obnoxious "DO NOT APPLY" strings 
all over the place?  That makes patch review very annoying.


Nicolas
