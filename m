From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Tue, 15 Feb 2011 16:18:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102151604410.14920@xanadu.home>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:15554 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BOVSP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 16:18:15 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGO00GVHGHO7WH0@vl-mo-mrz23.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 15 Feb 2011 16:17:49 -0500 (EST)
In-reply-to: <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Tue, 15 Feb 2011, Arindam Nath wrote:

> @@ -1340,11 +1342,76 @@ out:
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host;
> +	u8 pwr;
> +	u16 clk, ctrl;
> +	u32 present_state;
> +	unsigned long flags;
> +
> +	host = mmc_priv(mmc);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	/* Stop SDCLK */
> +	host = mmc_priv(mmc);
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Check whether DAT[3:0] is 0000 */
> +	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	if (!((present_state & SDHCI_DATA_LVL_MASK) >> SDHCI_DATA_LVL_SHIFT)) {
> +		/* Enable 1.8V Signal Enable in the Host Control2 register */
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		ctrl |= SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +		/* Wait for 5ms */
> +		mdelay(5);

You're busy-waiting for 5 ms while holding a spinlock and with 
interrupts masked off.  This is totally unacceptable.

There shouldn't be any other concurrent access to the controller here as 
the 
core code should have claimed the host through mmc_claim_host(), if not 
this is a bug.  So if the only thing you're worried about is some sdhci 
specific interrupts then simply mask interrupts at the controller level, 
do your business including this 5 ms delay using msleep() and _not_ 
mdelay(), and unmask them afterwards.  If this is called in a non 
sleepable context then please make it so.


Nicolas
