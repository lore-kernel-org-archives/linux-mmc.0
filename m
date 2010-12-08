From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH 2/5] mmc: msm_sdcc: Add prog done interrupt support
Date: Wed, 08 Dec 2010 11:40:13 +0530
Message-ID: <1291788613.21924.36.camel@stummala-linux.in.qualcomm.com>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
	 <1291719316-23948-2-git-send-email-stummala@codeaurora.org>
	 <1291746437.8000.11.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35982 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0LHGKR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 01:10:17 -0500
In-Reply-To: <1291746437.8000.11.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

Hi Daniel,

On Tue, 2010-12-07 at 10:27 -0800, Daniel Walker wrote:
> On Tue, 2010-12-07 at 16:25 +0530, Sahitya Tummala wrote:
> > Enable prog done interrupt for stop command(CMD12) that is sent
> > after a multi-block write(CMD25). The PROG_DONE bit is set when
> > the card has finished its programming and is ready for next data.
> 
> What's the benefit ? It looks like there is one, but please describe it.

After every write request the card will be polled for ready status
using CMD13. For a multi-block write(CMD25) before sending CMD13,
stop command (CMD12) will be sent.  If we enable prog done interrupt
for CMD12, then CMD13 polling can be avoided. The prog done interrupt
means that the card is done with its programming and is ready for
next request. I will this to commit text also.

> >  	if (status & (MCI_CMDSENT | MCI_CMDRESPEND | MCI_CMDCRCFAIL |
> > -	              MCI_CMDTIMEOUT) && host->curr.cmd) {
> > +		MCI_CMDTIMEOUT | MCI_PROGDONE) && host->curr.cmd) {
> 
> Add a line break here instead of weird spacing.

Will fix it in V2.

> >  		msmsdcc_do_cmdirq(host, status);
> >  	}
> >  
> > diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
> > index 996990d..ac79ed9 100644
> > --- a/drivers/mmc/host/msm_sdcc.h
> > +++ b/drivers/mmc/host/msm_sdcc.h
> > @@ -138,7 +138,7 @@
> >  #define MCI_IRQENABLE	\
> >  	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
> >  	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
> > -	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK)
> > +	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|MCI_PROGDONEMASK)
> >  
> >  /*
> >   * The size of the FIFO in bytes.
> > @@ -245,6 +245,8 @@ struct msmsdcc_host {
> >  	struct mmc_command	*cmd_cmd;
> >  	u32			cmd_c;
> >  
> > +	unsigned int prog_scan;
> > +	unsigned int prog_enable;
> 
> These need to be bool, and you need to use true and false instead of 1
> and 0.

Will fix it in V2.

Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

