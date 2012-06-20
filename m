From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Date: Wed, 20 Jun 2012 15:42:38 +0900
Message-ID: <20120620064238.GH20030@verge.net.au>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20120613011201.GD16686@verge.net.au>
 <47844351.ibBFGBYgKQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47844351.ibBFGBYgKQ@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 13, 2012 at 09:39:56AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 13 June 2012 10:12:01 Simon Horman wrote:
> > On Tue, Jun 12, 2012 at 10:56:09PM +0200, Laurent Pinchart wrote:
> > > The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
> > > opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
> > > MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
> > > command flags, and reject SD_IO_SEND_OP_COND only.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/mmc/host/sh_mmcif.c |   14 ++++----------
> > >  1 files changed, 4 insertions(+), 10 deletions(-)
> > > 
> > > Not supporting the MMC_SLEEP_AWAKE command makes system suspend fail if an
> > > MMC or eMMC device supporting sleep/wake is connected. The issue has been
> > > first noticed on the Armadillo 800 EVA board.
> > 
> > Hi Laurent,
> > 
> > Do you have a test-case for this?
> 
> echo mem > /sys/power/state on Armadillo 800 EVA was my test case. It failed 
> without the patch, and succeeds with it.

I'm not having much luck with or without your patch.

# echo mem > /sys/power/state
echo: write error: No such device

I am using 3.5-rc3. With the armadillo default config + EXT3 + SUSPEND.
Perhaps I am missing some options?

> > Also, did you check to make sure that the Mackerel still works?
> 
> Yes it still works. However, I have no way to test the MMC_SLEEP_AWAKE command 
> on the Mackerel board, as my MMC card doesn't support it (on the Armadillo the 
> eMMC chip supports the MMC_SLEEP_AWAKE command).
> 
> BTW, I wonder whether the current implementation is really the best one. If 
> the hardware doesn't support SD/SDIO commands, instead of intercepting 
> commands and rejecting the ones used by SD/SDIO at probe time, wouldn't it be 
> better for host drivers to tell that they don't support SD and/or SDIO using 
> flags in the mmc_host structure ?

I don't have any strong thoughts on this but your approach
does sound interesting.
