From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Fri, 13 May 2016 11:28:11 +0900
Message-ID: <20160513022809.GD24529@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
 <20160512165005.GC13121@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33917 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcEMC2P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2016 22:28:15 -0400
Content-Disposition: inline
In-Reply-To: <20160512165005.GC13121@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

On Thu, May 12, 2016 at 06:50:05PM +0200, Wolfram Sang wrote:
> Hi Simon,
> 
> nice you got it working with upstream! Thanks. It still looks a bit too
> much like BSP code, though, so we need to clean it up. I found 'git log
> --grep=tuning drivers/mmc/host' to be useful to get an idea of current
> best practices.
> 
> > +	bool (*inquiry_tuning)(struct tmio_mmc_host *host);
> 
> Do we really need this? I'd think the core will check that tuning only
> gets called when needed.

Thanks, I'll look into that and in general updating the approach taken
to tuning to reflect that currently taken in mainline.

> > -static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
> > +static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
> >  {
> >  	struct mmc_data *data;
> >  	spin_lock(&host->lock);
> > @@ -529,6 +558,9 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
> >  	if (!data)
> >  		goto out;
> >  
> > +	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
> > +	    stat & TMIO_STAT_TXUNDERRUN)
> > +		data->error = -EILSEQ;
> >  	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
> >  		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
> >  		bool done = false;
> > @@ -577,8 +609,6 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
> >  		goto out;
> >  	}
> >  
> > -	host->cmd = NULL;
> > -
> >  	/* This controller is sicker than the PXA one. Not only do we need to
> >  	 * drop the top 8 bits of the first response word, we also need to
> >  	 * modify the order of the response for short response command types.
> > @@ -598,14 +628,16 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
> >  
> >  	if (stat & TMIO_STAT_CMDTIMEOUT)
> >  		cmd->error = -ETIMEDOUT;
> > -	else if (stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC)
> > +	else if ((stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC) ||
> > +		 stat & TMIO_STAT_STOPBIT_ERR ||
> > +		 stat & TMIO_STAT_CMD_IDX_ERR)
> >  		cmd->error = -EILSEQ;
> >  
> >  	/* If there is data to handle we enable data IRQs here, and
> >  	 * we will ultimatley finish the request in the data_end handler.
> >  	 * If theres no data or we encountered an error, finish now.
> >  	 */
> > -	if (host->data && !cmd->error) {
> > +	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
> >  		if (host->data->flags & MMC_DATA_READ) {
> >  			if (host->force_pio || !host->chan_rx)
> >  				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
> > @@ -666,7 +698,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
> >  	/* Data transfer completion */
> >  	if (ireg & TMIO_STAT_DATAEND) {
> >  		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
> > -		tmio_mmc_data_irq(host);
> > +		tmio_mmc_data_irq(host, status);
> >  		return true;
> >  	}
> 
> I wonder if the changes to this tmio_mmc_*_irq are a seperate patch?
> I'd think they need a seperate description.

Yes, I think so.

Looking over this its not entirely clear that they are limited in
usefulness to tuning.

> > @@ -753,6 +785,157 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
> >  	return 0;
> >  }
> >  
> > +#define TMIO_MMC_MAX_TUNING_LOOP 40
> > +
> > +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > +{
> 
> I'd think we can use mmc_send_tuning() from the mmc core here in here.

Yes, having looked over mainline I think that seems likely.

> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +	struct mmc_ios *ios = &mmc->ios;
> > +
> > +	unsigned long timeout, val;
> > +	unsigned long *tap;
> > +	int tuning_loop_counter = TMIO_MMC_MAX_TUNING_LOOP;
> > +	int ret, timeleft;
> > +
> > +	struct mmc_request mrq = {NULL};
> > +	struct mmc_command cmd = {0};
> > +	struct mmc_data data = {0};
> > +	struct scatterlist sg;
> > +	u8 *data_buf;
> > +	unsigned int num, tm = CMDREQ_TIMEOUT;
> > +	unsigned long flags;
> > +
> > +	if ((ios->timing != MMC_TIMING_UHS_SDR50 &&
> > +	     ios->timing != MMC_TIMING_UHS_SDR104) ||
> > +	    (host->inquiry_tuning && !host->inquiry_tuning(host)) ||
> > +	    host->done_tuning || !host->init_tuning)
> > +		return 0;
> > +
> > +	num = host->init_tuning(host);
> > +
> > +	tap = kmalloc(num * 2, GFP_KERNEL);
> > +	if (tap == NULL) {
> > +		ret = -ENOMEM;
> > +		goto err_tap;
> > +	}
> > +
> > +	data_buf = kmalloc(64, GFP_KERNEL);
> > +	if (data_buf == NULL) {
> > +		ret = -ENOMEM;
> > +		goto err_data;
> > +	}
> > +
> > +	val = 0;
> > +
> > +	/*
> > +	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
> > +	 * of loops reaches 40 times or a timeout of 150ms occurs.
> > +	 */
> 
> Note to self: this is copied from sdhci.c

It also seems to be copied from an old version of sdhci.c.
So at the very least there seem some updates to be incorporated. 


