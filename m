From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v2 2/4] mmc: tmio, renesas-sdhi: add complete to
 DMA ops
Date: Mon, 19 Jun 2017 13:58:39 +0200
Message-ID: <20170619115839.GC20088@verge.net.au>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-3-git-send-email-horms+renesas@verge.net.au>
 <20170617150105.esceda3kiavhmu5x@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170617150105.esceda3kiavhmu5x@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Jun 17, 2017 at 05:01:05PM +0200, Wolfram Sang wrote:
> On Fri, Jun 16, 2017 at 11:58:52AM +0200, Simon Horman wrote:
> > Add complete to DMA ops to allow DMAC implementation dependent
> > handling of DMA completion.
> > 
> > Also implement the operation for SDHI.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Codewise, I am all fine with this patch. There is one naming, however:
> 
> > +	void (*complete)(struct tmio_mmc_host *host);
> 
> I'd rather call it 'dataend'. For internal DMAC, it is the same. But for
> SYS-DMAC there is difference between DATAEND and DMA_COMPLETE. This is
> exactly the reason we have commit 52ad9a8e854ca1 ("mmc: tmio: ensure end
> of DMA and SD access are in sync").
> 
> Basically, something like %s/complete/dataend/g would do it for me...

Sure, I will change this.

'compete' seemed like a nice name but I accept your reasoning above.
