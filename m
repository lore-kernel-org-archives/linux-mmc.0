From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/24] mmc: sdhci: command response CRC error handling
Date: Tue, 26 Jan 2016 13:35:27 +0000
Message-ID: <20160126133526.GM10826@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <E1aAypl-00016T-IM@rmk-PC.arm.linux.org.uk>
 <568285C4.9070909@intel.com>
 <20160102122508.GW8644@n2100.arm.linux.org.uk>
 <568A5672.4080402@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36788 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbcAZNfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:35:51 -0500
Content-Disposition: inline
In-Reply-To: <568A5672.4080402@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

On Mon, Jan 04, 2016 at 01:24:34PM +0200, Adrian Hunter wrote:
> On 02/01/16 14:25, Russell King - ARM Linux wrote:
> > On Tue, Dec 29, 2015 at 03:08:20PM +0200, Adrian Hunter wrote:
> >> On 21/12/15 13:40, Russell King wrote:
> >>> When we get a response CRC error on a command, it means that the
> >>> response we received back from the card was not correct.  It does not
> >>> mean that the card did not receive the command correctly.  If the
> >>
> >> Pedantically, if the timeout bit is set as well (CMD line conflict),
> >> it does mean the card did not receive the command, so it should be coded
> >> that way.
> > 
> > Good catch, the SDHCI spec contains a table which describes the CRC and
> > timeout bit states, though it's not quite as you describe above...
> > CRC and timeout indicates a command line conflict at some point.
> 
> In the case of CMD line conflict, the host controller aborts the command, so
> presumably there will not be any data timeout.  Will you change it?

Of course, I think that's what I implied above, because CRC + timeout
does *not* mean that we had a CRC error.

> >>> +		/*
> >>> +		 * If this command initiates a data phase and a response
> >>> +		 * CRC error is signalled, the card can start transferring
> >>> +		 * data - the card may have received the command without
> >>> +		 * error.  We must not terminate the request early.
> >>
> >> This is misleading.  We could terminate the request early if we cleaned it
> >> up.  You should say here why it is better to continue.
> > 
> > That is _not_ misleading, it is entirely accurate.  What the code
> > currently does when it encounters a CRC error is it terminates the
> > _request_ early.  The _request_ being "struct mmc_request" - and
> > it terminates it _without_ sending a STOP command.
> 
> Sure, but the person reading the comment not should have to know the history
> of the code to interpret it.  But it is not a big thing - the comment could
> just be:
> 
> 	We must not terminate early because we don't bother to clean up.

I think that "we don't bother to clean up" is ambiguous.  We do clean
up the request - and that's part of the problem.  We clear out the
drivers state, reset the host controller command and data paths, and
tear down DMA mappings and the like leaving the card in data transfer
mode.

In this particular case (of a tuning command) I don't believe a stop
command would be expected (it's not a multi-block read.)

In any case, I think the original comment describes what we're doing,
the only change I'll make is to replace "request" with "mmc_request"
which should solve your confusion.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
