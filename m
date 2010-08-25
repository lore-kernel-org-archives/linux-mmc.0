From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Wed, 25 Aug 2010 22:52:08 +0100
Message-ID: <20100825225208.02a906f7@linux-g6p1.site>
References: <4C33DFF0.3040804@renesas.com>
	<20100708144647.1e77364b.akpm@linux-foundation.org>
	<4C3BD041.3020705@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:46359 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab0HYVwL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2010 17:52:11 -0400
In-Reply-To: <4C3BD041.3020705@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Tue, 13 Jul 2010 11:32:33 +0900
Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> Hi Andrew
> 
> Andrew Morton wrote:
> > On Wed, 07 Jul 2010 11:01:20 +0900
> > Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
> > 
> >> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> >> ---
> >>  drivers/mmc/host/tmio_mmc.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> >> index ee7d0a5..cac1c97 100644
> >> --- a/drivers/mmc/host/tmio_mmc.c
> >> +++ b/drivers/mmc/host/tmio_mmc.c
> >> @@ -661,7 +661,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
> >>  		 data->blksz, data->blocks);
> >>
> >>  	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
> >> -	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> >> +	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> >>  		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
> >>  		       mmc_hostname(host->mmc), data->blksz);
> >>  		return -EINVAL;
> > 
> > Again, please provide a suitable description for this change.
> I think the data size is not limited by MMC_BUS_WIDTH_x.
> I confirmed that data transmission of 2Byte was performed without a problem.

This patch hasn't been picked up. I'm assuming that's because Andrew is
still unhappy with the changelog.

Andrew, how about something like,

"When running in 4-bit bus width mode, it is entirely possible to
transfer data in block sizes of 2 bytes and larger. Relax the
conditional check to allow 2-byte data block transfers which were
previously disallowed."

Yusuke, have I interpreted your changelog correctly? Also note that
your patch should remove the comment above the conditional that says,
"Hardware cannot perform 1 and 2 byte requests in 4 bit mode".
