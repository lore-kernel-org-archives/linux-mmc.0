From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Date: Fri, 18 Jan 2019 07:32:51 -0800
Message-ID: <20190118153251.GT5544@atomide.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
 <20190116132747.GB11050@ulmo>
 <20190116154717.GQ5544@atomide.com>
 <fab3147f-10e3-51b0-6f58-a1aff751f4be@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fab3147f-10e3-51b0-6f58-a1aff751f4be@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190118 10:54]:
> Tony,
> 
> On 16/01/19 9:17 PM, Tony Lindgren wrote:
> > * Thierry Reding <thierry.reding@gmail.com> [190116 13:28]:
> >> On Tue, Jan 15, 2019 at 05:28:36PM +0100, Thomas Petazzoni wrote:
> >>> The SDHCI core is know properly checking for the state of a WP GPIO,
> >>
> >> "know" -> "now"
> >>
> >>> so there is no longer any need for the sdhci-omap code to implement
> >>> ->get_ro() using mmc_gpio_get_ro().
> >>>
> >>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> >>> ---
> >>> Note: this patch has only been compiled tested, as I don't have the
> >>> hardware to test it.
> >>> ---
> >>>  drivers/mmc/host/sdhci-omap.c | 1 -
> >>>  1 file changed, 1 deletion(-)
> >>
> >> I can't runtime test this myself, but it certainly looks like this would
> >> do the right thing because it calls the core now call the very same
> >> function as this used to, so:
> >>
> >> Reviewed-by: Thierry Reding <treding@nvidia.com>
> >>
> >> Adding Tony and linux-omap for a slightly wider audience and hopefully
> >> find someone to test this on. For reference, the whole series is here:
> >>
> >> 	https://patchwork.kernel.org/project/linux-mmc/list/?series=66905
> > 
> > Thanks Kishon can you please review and test?
> > 
> 
> I can help with testing once Thomas posts a v2.

OK great thanks!

Tony
