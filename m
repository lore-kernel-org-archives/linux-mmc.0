From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/24] mmc: sdhci: command response CRC error handling
Date: Sat, 2 Jan 2016 12:25:09 +0000
Message-ID: <20160102122508.GW8644@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <E1aAypl-00016T-IM@rmk-PC.arm.linux.org.uk>
 <568285C4.9070909@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35774 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbcABMZY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2016 07:25:24 -0500
Content-Disposition: inline
In-Reply-To: <568285C4.9070909@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

On Tue, Dec 29, 2015 at 03:08:20PM +0200, Adrian Hunter wrote:
> On 21/12/15 13:40, Russell King wrote:
> > When we get a response CRC error on a command, it means that the
> > response we received back from the card was not correct.  It does not
> > mean that the card did not receive the command correctly.  If the
> 
> Pedantically, if the timeout bit is set as well (CMD line conflict),
> it does mean the card did not receive the command, so it should be coded
> that way.

Good catch, the SDHCI spec contains a table which describes the CRC and
timeout bit states, though it's not quite as you describe above...
CRC and timeout indicates a command line conflict at some point.

> > Fix this by handing a response CRC error slightly differently: record
> > the failure of the data initiating command, but allow the remainder of
> > the request to be processed normally.  This is safe as core MMC checks
> 
> "processed normally" confused me at first because it sounded like you are
> ignoring the error.  Not sure why you have a much better explanation in the
> cover email than here.

They're written at different times?  I don't accept your comment though -
"record the failure" _clearly_ does not mean that we're ignoring the error.

> > the status of all commands and data transfer phases of the request.
> 
> MMC core is not the only initiator of requests, but it is safe because the
> command error takes precedence by design.
> 
> Also you don't explain why it is better to continue rather than attempt to
> send a stop command and clean up the request properly.  It looks simpler and
> less racy, but if that is the reason then it seems worth saying so.

This patch results from the analysis of failures seen on iMX6 hardware,
where the card has entered data mode, and started to send its data.
Right now, this screws up the next command.

> > If the card does not initiate a data transfer, then we should time out
> > according to the data transfer parameters.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/mmc/host/sdhci.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 86310b162304..3e718e465a1b 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2340,6 +2340,23 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
> >  		else
> >  			host->cmd->error = -EILSEQ;
> >  
> > +		/*
> > +		 * If this command initiates a data phase and a response
> > +		 * CRC error is signalled, the card can start transferring
> > +		 * data - the card may have received the command without
> > +		 * error.  We must not terminate the request early.
> 
> This is misleading.  We could terminate the request early if we cleaned it
> up.  You should say here why it is better to continue.

That is _not_ misleading, it is entirely accurate.  What the code
currently does when it encounters a CRC error is it terminates the
_request_ early.  The _request_ being "struct mmc_request" - and
it terminates it _without_ sending a STOP command.

Resetting the host controller does not influence what state the card
is in.

So what happens at the moment is that we send a command which initiates
a data phase from the card.  The card responds with a valid response,
and starts sending data to the host.  The host incorrectly receives
the card response with a CRC error.

At this point, the code decides that it had a failure, queues the
finish tasklet, which resets the SDHCI controller, leaving the card
transmitting data to the host, potentially endlessly.  The driver
reports to the MMC layer that the mmc_request is complete, and we
get the next request to process.

We try sending the next request to the card, but the card is still
sending data to the host...  That's the problem here.

Yes, sending a STOP command is one solution, but that's a far bigger
change, one which is likely to be far more buggy based on the fact
that the driver can send the STOP automatically.

> 
> > +		 *
> > +		 * If the card did not receive the command, the data phase
> > +		 * will time out.
> > +		 *
> > +		 * FIXME: we also need to clean up the data phase if any
> > +		 * command fails, not just the data initiating command.
> 
> This FIXME is too vague.  Please give at least one example of what
> needs fixing.

I don't remember anymore, sorry.  I'll delete the fixme. :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
