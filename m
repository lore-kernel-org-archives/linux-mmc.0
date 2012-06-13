From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Wed, 13 Jun 2012 09:42:01 +0200
Message-ID: <1563726.iOzzD8v7Ct@avalon>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com> <20120613011712.GF16686@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120613011712.GF16686@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Wednesday 13 June 2012 10:17:12 Simon Horman wrote:
> On Tue, Jun 12, 2012 at 11:29:35PM +0200, Laurent Pinchart wrote:
> > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > width. When the mmc core requests the driver to power off the card, we
> > inform runtime PM, that the controller can be suspended. This can lead
> > to the MSTP clock being turned off.
> > 
> > Writing to any 16-bit hardware registers with the MSTP clock off leads
> > to timeouts and errors being printed to the kernel log. This can occur
> > both when stopping the MMC clock and when configuring the bus width.
> > 
> > To fix this, stop the MMC clock before calling put_runtime_pm(), and
> > skip bus width configuration when power is off.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Hi Laurent,
> 
> could you let me know if there is a (simple :) way for me to exercise this?

Without the patch suspending the Armadillo board to RAM produces a "timeout 
waiting for SD bus idle" message. Make sure you apply the "mmc: sh_mmcif: 
Support MMC_SLEEP_AWAKE command" patch first, or suspending the board will 
fail completely.

-- 
Regards,

Laurent Pinchart

