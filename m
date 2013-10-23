From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 1/7] mmc: sdhci: clear auto cmd setting bits for no
 data cmds
Date: Wed, 23 Oct 2013 13:54:04 +0800
Message-ID: <20131023055402.GA14667@shlinux2.ap.freescale.net>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
 <1382365627-26816-2-git-send-email-b29396@freescale.com>
 <20131023023325.GB2839@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:26931
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751025Ab3JWGLZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 02:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20131023023325.GB2839@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, wsa@the-dreams.de, ulf.hansson@linaro.org

On Wed, Oct 23, 2013 at 10:33:28AM +0800, Shawn Guo wrote:
> On Mon, Oct 21, 2013 at 10:27:01PM +0800, Dong Aisheng wrote:
> > The auto cmd settings bits should be cleared before sending new commands
> > or we may receive command timeout error for normal commands due to wrongly
> > pre-sent auto cmd.
> > 
> > e.g. we receive CMD13 timeout error due to ACMD23 is wrongly enabled
> > by former data commands.
> > 
> > mmc2: new high speed DDR MMC card at address 0001
> > mmcblk1: mmc2:0001 SEM08G 7.39 GiB
> > mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
> > mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
> > mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
> >  mmcblk1: p1 p2 p3 p4 < p5 p6 p7 >
> > mmc2: Timeout waiting for hardware interrupt.
> >  mmcblk1boot1: unknown partition table
> > mmc2: Timeout waiting for hardware interrupt.
> >  mmcblk1boot0: unknown partition table
> > 
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a21a710..f868e9b 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -898,6 +898,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >  	u16 mode;
> >  	struct mmc_data *data = cmd->data;
> >  
> > +	/* clear Auto CMD settings for no data CMDs */
> > +	mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> > +	sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_CMD12 |
> > +			SDHCI_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
> > +
> 
> IMO, it will be more readable if we move the code into the if-clause
> of (data == NULL), something like:
> 
> 	if (data == NULL) {
> 		/* clear Auto CMD settings for no data CMDs */
> 		mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> 		mode &= SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_AUTO_CMD23;
> 		sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> 	}
> 

I'm fine with it.
Will change to:

if (data == NULL) {
	/* clear Auto CMD settings for no data CMDs */
	mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
	mode &= ~(SDHCI_TRNS_AUTO_CMD12 | SDHCI_TRNS_AUTO_CMD23);
	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
	return;
}

Regards
Dong Aisheng

> Shawn
> 
> >  	if (data == NULL)
> >  		return;
> >  
> > -- 
> > 1.7.2.rc3
> > 
> > 

