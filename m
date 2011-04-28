From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v3 08/11] mmc: sd: add support for tuning during uhs
 initialization
Date: Thu, 28 Apr 2011 01:02:01 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB81A391@SAUSEXMBP01.amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
 <1303291861-1788-9-git-send-email-arindam.nath@amd.com>
 <DC43BF02-00E5-4090-A472-722156C5E136@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:17375
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751510Ab1D1GCM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 02:02:12 -0400
In-Reply-To: <DC43BF02-00E5-4090-A472-722156C5E136@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Thursday, April 28, 2011 12:15 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; subhashj@codeaurora.org;
> zhangfei.gao@gmail.com; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v3 08/11] mmc: sd: add support for tuning during
> uhs initialization
> 
> 

[...]

> > @@ -1477,12 +1481,146 @@ static int
> sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> > 		return 0;
> > }
> >
> > +static int sdhci_execute_tuning(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host;
> > +	u16 ctrl;
> 	 	u32 ier;
> > +	int tuning_loop_counter = MAX_TUNING_LOOP;
> > +	unsigned long timeout;
> > +	int err = 0;
> > +
> > +	host = mmc_priv(mmc);
> > +
> > +	disable_irq(host->irq);
> > +	spin_lock(&host->lock);
> 
> is this needed ?  I believe we should be locked from the core/ layer.

Yes, this is needed. Please note that sdhci_execute_tuning() is not only invoked during initialization, but also when re-tuning timer expires.

> > +
> > +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +
> > +	/*
> > +	 * Host Controller needs tuning only in case of SDR104 mode
> > +	 * and for SDR50 mode when Use Tuning for SDR50 is set in
> > +	 * Capabilities register.
> > +	 */
> > +	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
> > +	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
> > +	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
> > +		ctrl |= SDHCI_CTRL_EXEC_TUNING;
> > +	else {
> > +		spin_unlock(&host->lock);
> > +		enable_irq(host->irq);
> > +		return 0;
> > +	}
> 
> 
> based on exchanges with SD Host Chair we need to set block size and
> transfer mode.
> Directly wriiting TRANSFER_MODE clears DMA bit.  No DMA is needed for
> SDHCI_INT_DATA_AVAIL
> to be signaled.
> 
> Suggest
> 
> > +	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
> > +	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
> > +	    (host->flags & SDHCI_SDR50_NEEDS_TUNING))) {
> 			ctrl |= SDHCI_CTRL_EXEC_TUNING;
> 			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> SDHCI_BLOCK_SIZE);
> 			sdhci_writew(host, SDHCI_TRNS_READ,
> SDHCI_TRANSFER_MODE);
> 	} else {
> > +		spin_unlock(&host->lock);
> > +		enable_irq(host->irq);
> > +		return 0;
> > +	}
> 

This suggestion looks okay to me.

> 
> > +
> > +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > +
> > +	/*
> > +	 * As per the Host Controller spec v3.00, tuning command
> > +	 * generates Buffer Read Ready interrupt, so enable that.
> > +	 */
> > +	sdhci_unmask_irqs(host, SDHCI_INT_DATA_AVAIL);
> 
> delete line above -- it keeps the other interrupts enabled but we
> should only
> receive the DATA AVAIL interrupt.  We should protect against a bad
> controller
> 
> change to
> 
> >> 	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> >> 	sdhci_clear_set_irqs(host, ier, SDHCI_INT_DATA_AVAIL);
> 
> 
> This will ONLY enable SDHCI_INT_DATA_AVAIL.

Even though the spec clearly mentions that,

"While the tuning sequence is being performed, the Host Controller does not generate interrupts (including Command Complete) except Buffer Read Ready and CMD19 response errors are not indicated."

I think your suggestion would make sense of buggy controllers.

> >
> >
> > +
> > +	/*
> > +	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the
> number
> > +	 * of loops reaches 40 times or a timeout of 150ms occurs.
> > +	 */
> > +	timeout = 150;
> > +	do {
> > +		u16 mode;
> > +		struct mmc_command cmd;
> > +		struct mmc_request mrq;
> > +
> > +		if (!tuning_loop_counter && !timeout)
> > +			break;
> > +
> > +		memset(&cmd, 0, sizeof(struct mmc_command));
> > +		cmd.opcode = MMC_SEND_TUNING_BLOCK;
> > +		cmd.arg = 0;
> > +		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > +
> > +		memset(&cmd.resp, 0, sizeof(cmd.resp));
> > +		cmd.retries = 0;
> > +
> > +		cmd.data = NULL;
> > +		cmd.error = 0;
> > +
> > +		memset(&mrq, 0, sizeof(struct mmc_request));
> > +		mrq.cmd = &cmd;
> > +		host->mrq = &mrq;
> > +
> 
> =====
> > +		/* Make sure DMA Enable is set to 0 before tuning */
> > +		mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> > +		if (mode & SDHCI_TRNS_DMA) {
> > +			mode &= ~SDHCI_TRNS_DMA;
> > +			sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> > +		}
>     this code should be deleted and moved up.

IMO, it should better stay here. Even though there can be no data transfer commands during tuning procedure, but there can still be commands using CMD lines only, so there is a possibility of interleaving. In that case, it's better to program TRANSFER_MODE register every time before sending CMD19. Please consider re-tuning mode 1.

Thanks,
Arindam



