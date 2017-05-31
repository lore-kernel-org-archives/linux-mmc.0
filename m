From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
Date: Wed, 31 May 2017 21:56:12 +0200
Message-ID: <20170531195611.GE22266@verge.net.au>
References: <20170530090346.19088-1-wsa+renesas@sang-engineering.com>
 <20170530200218.q4s2dlrxusrdgpm2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530200218.q4s2dlrxusrdgpm2@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 30, 2017 at 10:02:18PM +0200, Wolfram Sang wrote:
> On Tue, May 30, 2017 at 11:03:46AM +0200, Wolfram Sang wrote:
> > Most registers need to wait until the command is completed, not
> > necessarily until the bus is free. At least, R-Car 2+ SoCs can signal
> > that via the CBSY bit, so let's use it there instead of SCLKDIVEN to
> > save a little bit of delay.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> > 
> > Tested with a Renesas Lager board (H2). Moved big files around across different
> > SD cards, re- inserted cards multiple times. All worked fine.
> > 
> > @Dirk: can you do some additional testing for your use case? That would be much
> > appreciated!
> 
> OK, since Dirk told me he'll need some more time to test it anyhow and
> Simon meanwhile sent some cleanup patches, I'll simply post an updated
> version of this patch once Simon's cleanup patches hit mmc/next. I think
> this will be easiest.

Thanks, sorry for the clash - we seem to often hit the SDHI driver
at about the same time.
