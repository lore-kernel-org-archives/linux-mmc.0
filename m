From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc sdhci i.MX5: make mmc cards work
Date: Mon, 20 Feb 2012 19:41:46 +0100
Message-ID: <20120220184146.GZ3852@pengutronix.de>
References: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
 <20120220063132.GA19668@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42647 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2BTSlt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 13:41:49 -0500
Content-Disposition: inline
In-Reply-To: <20120220063132.GA19668@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

On Mon, Feb 20, 2012 at 02:31:36PM +0800, Shawn Guo wrote:
> I do not have a mmc card to test the patch, but I tested it and
> confirmed it does not break anything about SD support.
> 
> On Fri, Feb 17, 2012 at 11:51:49AM +0100, Sascha Hauer wrote:
> > On i.MX53 we have to write a special SDHCI_CMD_ABORTCMD to the
> 
> Is this i.MX53 only?

Don't know. I don't think I have ever explicitely tested MMC cards on
!i.MX53 boards.

> 
> > SDHCI_TRANSFER_MODE register during a MMC_STOP_TRANSMISSION
> > command. This works for SD cards. However, with MMC cards
> > the MMC_SET_BLOCK_COUNT command is used instead, but this needs
> > the same handling. Fix MMC cards by testing for the
> > MMC_SET_BLOCK_COUNT command aswell. Tested on a custom i.MX53
> > board with a Transcend MMC+ card and eMMC.
> > 
> I did not find the similar handling in FSL internal tree, but I think
> that FSL QA team should have tested it with MMC/eMMC card.

Which kernel did they test this on? The mmc core uses the
MMC_SET_BLOCK_COUNT command since v3.0-rc1. Earlier kernels
probably worked.

Sascha

> 
> Regards,
> Shawn
> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index d601e41..cd35dc4 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -269,7 +269,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
> >  		imx_data->scratchpad = val;
> >  		return;
> >  	case SDHCI_COMMAND:
> > -		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
> > +		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
> > +			host->cmd->opcode == MMC_SET_BLOCK_COUNT)
> >  			&& (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
> >  			val |= SDHCI_CMD_ABORTCMD;
> >  
> > -- 
> > 1.7.9
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
