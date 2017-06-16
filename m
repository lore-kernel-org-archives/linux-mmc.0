From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v2 1/2] mmc: tmio: improve checkpatch cleanness
Date: Fri, 16 Jun 2017 11:20:10 +0200
Message-ID: <20170616092010.GB6032@verge.net.au>
References: <1497553214-12914-1-git-send-email-horms+renesas@verge.net.au>
 <1497553214-12914-2-git-send-email-horms+renesas@verge.net.au>
 <20170616081445.tqlhod5znrqnxtc3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616081445.tqlhod5znrqnxtc3@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 16, 2017 at 10:14:45AM +0200, Wolfram Sang wrote:
> Hi Simon,
> 
> > * Don't add bogus ',' after KERN_DEBUG
> 
> Well...
> 
> > @@ -127,16 +127,17 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
> >  
> >  #define STATUS_TO_TEXT(a, status, i) \
> >  	do { \
> > -		if (status & TMIO_STAT_##a) { \
> > -			if (i++) \
> > -				printk(" | "); \
> > -			printk(#a); \
> > +		if ((status) & TMIO_STAT_##a) { \
> > +			if ((i)++) \
> > +				printk(KERN_DEBUG " | "); \
> > +			printk(KERN_DEBUG, #a); \
> 
> ...still there.

Oops.

> > @@ -349,13 +350,22 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
> >  	}
> >  
> >  	switch (mmc_resp_type(cmd)) {
> > -	case MMC_RSP_NONE: c |= RESP_NONE; break;
> > +	case MMC_RSP_NONE:
> > +		c |= RESP_NONE;
> > +		break;
> >  	case MMC_RSP_R1:
> >  	case MMC_RSP_R1_NO_CRC:
> > -			   c |= RESP_R1;   break;
> > -	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
> > -	case MMC_RSP_R2:   c |= RESP_R2;   break;
> > -	case MMC_RSP_R3:   c |= RESP_R3;   break;
> > +		c |= RESP_R1;
> > +		break;
> > +	case MMC_RSP_R1B:
> > +		c |= RESP_R1B;
> > +		break;
> > +	case MMC_RSP_R2:
> > +		c |= RESP_R2;
> > +		break;
> > +	case MMC_RSP_R3:
> > +		c |= RESP_R3;
> > +		break;
> 
> Very personal, I'd prefer the old way but I don't insist.
> 
> > -			 * Disable auto CMD12 at IO_RW_EXTENDED and SET_BLOCK_COUNT
> > -			 * when doing multiple block transfer
> > +			 * Disable auto CMD12 at IO_RW_EXTENDED and
> > +			 * SET_BLOCK_COUNT when doing multiple block
> > +			 * transfer
> 
> I'd think 'transfer' can go to the previous line?
> 
> >  			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
> > -			    (cmd->opcode == SD_IO_RW_EXTENDED || host->mrq->sbc))
> > +			    (cmd->opcode == SD_IO_RW_EXTENDED ||
> > +			     host->mrq->sbc))
> 
> Another subjective taste thingie ;)
> 
> > -		dev_warn_once(&host->pdev->dev,
> > -		      "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
> > +		dev_warn_once(&host->pdev->dev, "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
> 
> Dito.
> 
> What kind of tests did you run with these?

I checked that Lager boots and that I/O speeds are as expected using dd.
