From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Date: Thu, 13 Nov 2014 09:24:48 +0900
Message-ID: <20141113002446.GB9195@verge.net.au>
References: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
 <87sihoklaj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sihoklaj.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 13, 2014 at 12:15:58AM +0000, Kuninori Morimoto wrote:
> 
> Hi Kaneko-san
> 
> > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > 
> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> (snip)
> > +	if (np && !of_property_read_u32(np, "renesas,clk-rate", &clk_rate)) {
> > +		if (clk_rate) {
> > +			ret = clk_set_rate(host->hclk, clk_rate);
> > +			if (ret < 0)
> > +				dev_err(&pdev->dev,
> > +					"cannot set clock rate: %d\n", ret);
> > +		}
> > +	}
> 
> I guess this is came from BSP, and you have similar
> bindings on sh_mobile_sdhi.c too.
> But, we need to use "standard" method, not BSP original

Hi Morimoto-san,

you are correct in assuming that this patch came from the BSP.

Is your opinion that a) changing the clock rate is good but
b) it needs to be done using a standard method?

If so, is the main change required to use a standard binding string
rather than "renesas,clk-rate"? Is the driver change above needed at all?
