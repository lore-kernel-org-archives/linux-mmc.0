From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Date: Wed, 13 Jun 2012 09:39:56 +0200
Message-ID: <47844351.ibBFGBYgKQ@avalon>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com> <20120613011201.GD16686@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120613011201.GD16686@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Wednesday 13 June 2012 10:12:01 Simon Horman wrote:
> On Tue, Jun 12, 2012 at 10:56:09PM +0200, Laurent Pinchart wrote:
> > The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
> > opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
> > MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
> > command flags, and reject SD_IO_SEND_OP_COND only.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/mmc/host/sh_mmcif.c |   14 ++++----------
> >  1 files changed, 4 insertions(+), 10 deletions(-)
> > 
> > Not supporting the MMC_SLEEP_AWAKE command makes system suspend fail if an
> > MMC or eMMC device supporting sleep/wake is connected. The issue has been
> > first noticed on the Armadillo 800 EVA board.
> 
> Hi Laurent,
> 
> Do you have a test-case for this?

echo mem > /sys/power/state on Armadillo 800 EVA was my test case. It failed 
without the patch, and succeeds with it.

> Also, did you check to make sure that the Mackerel still works?

Yes it still works. However, I have no way to test the MMC_SLEEP_AWAKE command 
on the Mackerel board, as my MMC card doesn't support it (on the Armadillo the 
eMMC chip supports the MMC_SLEEP_AWAKE command).

BTW, I wonder whether the current implementation is really the best one. If 
the hardware doesn't support SD/SDIO commands, instead of intercepting 
commands and rejecting the ones used by SD/SDIO at probe time, wouldn't it be 
better for host drivers to tell that they don't support SD and/or SDIO using 
flags in the mmc_host structure ?

-- 
Regards,

Laurent Pinchart

