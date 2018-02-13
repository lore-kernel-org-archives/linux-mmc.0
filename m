From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 12:47:55 +0100
Message-ID: <20180213114754.mq2zcm5f5bzs5azz@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180207222630.r3axjxia3mflk5qk@ninjato>
 <20180208113702.3kf2nsk7cdmfp7ve@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208113702.3kf2nsk7cdmfp7ve@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 08, 2018 at 12:37:03PM +0100, Simon Horman wrote:
> On Wed, Feb 07, 2018 at 11:26:30PM +0100, Wolfram Sang wrote:
> > 
> > > * [PATCH] clk: renesas: rcar-gen3: Fix SD divider setting
> > 
> > I tried to address this one before:
> > 
> > [PATCH 0/3] clk: renesas: rcar-gen3-cpg: updates to SD divider table
> > 
> > but this had problems with H3 ES1.0 :(
> > 
> > I haven't yet compared the above dependency patch with what I did back
> > then. Will need to do that hopefully tomorrow. But as I read it, it
> > worked fine for you on H3 ES1.0?
> 
> Yes, it seemed to, though my memory of the testing is not fresh at this point.

I've done some more testing. This seems to work on:

* H3 ES1.0 / Salvator-X
* M3W ES1.0 / Salvator-X
* H3 ES2.0 / Salvator-XS
