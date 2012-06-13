From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Date: Wed, 13 Jun 2012 10:12:01 +0900
Message-ID: <20120613011201.GD16686@verge.net.au>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 12, 2012 at 10:56:09PM +0200, Laurent Pinchart wrote:
> The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
> opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
> MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
> command flags, and reject SD_IO_SEND_OP_COND only.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/mmc/host/sh_mmcif.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> Not supporting the MMC_SLEEP_AWAKE command makes system suspend fail if an MMC
> or eMMC device supporting sleep/wake is connected. The issue has been first
> noticed on the Armadillo 800 EVA board.

Hi Laurent,

Do you have a test-case for this?
Also, did you check to make sure that the Mackerel still works?
