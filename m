From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] initialise DMA engine before MMC
Date: Mon, 21 Jun 2010 13:40:30 +0900
Message-ID: <20100621044030.GC29997@linux-sh.org>
References: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 07, 2010 at 01:16:36PM +0200, Guennadi Liakhovetski wrote:
> To use DMA engine based DMA with MMC in a non-modular build, the DMA 
> engine has to initialise before MMC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Dan, any objections to this?
