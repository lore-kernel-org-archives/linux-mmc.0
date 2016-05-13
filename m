From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Fri, 13 May 2016 12:31:57 +0900
Message-ID: <20160513033156.GG24529@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
 <20160512165005.GC13121@katana>
 <20160513022809.GD24529@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160513022809.GD24529@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 13, 2016 at 11:28:11AM +0900, Simon Horman wrote:
> On Thu, May 12, 2016 at 06:50:05PM +0200, Wolfram Sang wrote:
> > Hi Simon,
> > 
> > nice you got it working with upstream! Thanks. It still looks a bit too
> > much like BSP code, though, so we need to clean it up. I found 'git log
> > --grep=tuning drivers/mmc/host' to be useful to get an idea of current
> > best practices.
> > 
> > > +	bool (*inquiry_tuning)(struct tmio_mmc_host *host);
> > 
> > Do we really need this? I'd think the core will check that tuning only
> > gets called when needed.
> 
> Thanks, I'll look into that and in general updating the approach taken
> to tuning to reflect that currently taken in mainline.

[...]

> > Note to self: this is copied from sdhci.c
> 
> It also seems to be copied from an old version of sdhci.c.
> So at the very least there seem some updates to be incorporated. 

On closer inspection I don't think that the loop in sdhci_execute_tuning()
implements the correct logic for the R-Car SCC. I'll look into reworking
it accordingly.
