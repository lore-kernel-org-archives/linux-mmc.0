From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/5] mmc: tmio: improve checkpatch cleanness
Date: Wed, 31 May 2017 21:58:18 +0200
Message-ID: <20170531195818.GF22266@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
 <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
 <20170530195852.7r63hmfbbrwae6kt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530195852.7r63hmfbbrwae6kt@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, May 30, 2017 at 09:58:52PM +0200, Wolfram Sang wrote:
> On Tue, May 30, 2017 at 02:50:53PM +0200, Simon Horman wrote:
> > Trivial updates to improve checkpatch cleanness.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Wow, all of them! When I reviewed your DMA refactoring patches, I meant
> to fix only the whitespace issues which were affecting your patches. But
> okay, it is a good timing to fix all of those, because of the said DMA
> refactoring work, the BSP patches won't fit anymore anyhow, so upporting
> them will not become significantly harder.
> 
> And while I don't agree with all of checkpatch suggestions, this patch
> increases code readability for sure. I guess, what I am saying is:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> and
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> I moved big files around two SD cards attached simultaneously to two
> card slots on my Renesas Lager (H2).
> 
> > -	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
> > +	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) &&
> > +	    !host->force_pio) {
> >  		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
> >  		bool done = false;
> 
> Let me give just one example where I think the 80 char limit doesn't
> help readability. But no need to fix IMO; as I said, most of the stuff
> is really helpful.

Yeah, I'm a bit dubious about some of checkpatch's warnings too.
