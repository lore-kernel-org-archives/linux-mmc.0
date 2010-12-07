From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH V2 1/3] mmc: add support for H/W clock gating of SD
 controller
Date: Tue, 07 Dec 2010 13:23:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012071319530.10437@xanadu.home>
References: <4DB58728-19A4-4ECC-979B-A3EF1F880382@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20437 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab0LGSXp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:23:45 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LD2009CKLQQCKB0@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 07 Dec 2010 13:23:14 -0500 (EST)
In-reply-to: <4DB58728-19A4-4ECC-979B-A3EF1F880382@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>

On Tue, 7 Dec 2010, Philip Rakity wrote:

> 
> This code extends software clock gating in the MMC layer by adding the ability
> to indicate that the SD controller supports hardware clock gating.
> 
> Hardware clock gating is enabled by setting the MMC capability
> MMC_CAP_HW_CLOCK_GATING in the SD driver.
> 
> eg: host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING
> 
> The approach follows the suggestion of Nico Pitre.
> 
> SD/MMC/eMMC cards use dynamic clocks
> SDIO uses continuous clocks to properly detect SDIO card interrupts
> 
> The code has been tested using marvell linux for MMP2.  The Marvell
> controller support H/W clock gating.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Mark F. Brown <markb@marvell.com>

There is one needless change in your patch:

> @@ -178,10 +181,13 @@ void mmc_host_clk_gate(struct mmc_host *host)
>  {
>  	unsigned long flags;
>  
> +	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
> +		return;
> +
>  	spin_lock_irqsave(&host->clk_lock, flags);
>  	host->clk_requests--;
>  	if (mmc_host_may_gate_card(host->card) &&
> -	    !host->clk_requests)
> +		!host->clk_requests)

The second line of the if() was properly aligned before.

Other than that...

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
