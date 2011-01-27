From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMCI: don't read command response when invalid
Date: Thu, 27 Jan 2011 12:19:01 +0000
Message-ID: <20110127121901.GB25968@n2100.arm.linux.org.uk>
References: <20110111163502.GJ11039@n2100.arm.linux.org.uk> <20110111163556.GA18746@n2100.arm.linux.org.uk> <20110111232025.GA25752@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46080 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab1A0MWO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jan 2011 07:22:14 -0500
Content-Disposition: inline
In-Reply-To: <20110111232025.GA25752@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 11, 2011 at 11:20:26PM +0000, Chris Ball wrote:
> Hi,
> 
> On Tue, Jan 11, 2011 at 04:35:56PM +0000, Russell King - ARM Linux wrote:
> > Don't read the command response from the registers when either the
> > command timed out (because there was no response from the card) or
> > the checksum on the response was invalid.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/mmc/host/mmci.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 5630228..040de4f 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -394,15 +394,15 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >  
> >  	host->cmd = NULL;
> >  
> > -	cmd->resp[0] = readl(base + MMCIRESPONSE0);
> > -	cmd->resp[1] = readl(base + MMCIRESPONSE1);
> > -	cmd->resp[2] = readl(base + MMCIRESPONSE2);
> > -	cmd->resp[3] = readl(base + MMCIRESPONSE3);
> > -
> >  	if (status & MCI_CMDTIMEOUT) {
> >  		cmd->error = -ETIMEDOUT;
> >  	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
> >  		cmd->error = -EILSEQ;
> > +	} else {
> > +		cmd->resp[0] = readl(base + MMCIRESPONSE0);
> > +		cmd->resp[1] = readl(base + MMCIRESPONSE1);
> > +		cmd->resp[2] = readl(base + MMCIRESPONSE2);
> > +		cmd->resp[3] = readl(base + MMCIRESPONSE3);
> >  	}
> >  
> >  	if (!cmd->data || cmd->error) {
> 
> Thanks, pushed to mmc-next and queued as a .38 fix.

FYI, I've now merged this into the ARM devel tree for the time being so
it doesn't get forgotten - which means it'll appear in linux-next at some
point if it isn't already there.  (Mainly so I don't have to keep on
adding the patch.)

Once you push it into mainline, I'll drop my copy.
