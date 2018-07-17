From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Force correct divider calculation on
 DDR50/52
Date: Tue, 17 Jul 2018 12:08:50 +0300
Message-ID: <20180717120850.774c4e9d@dhcp-10-21-25-168>
References: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
        <16caa6d0-4368-8931-a77c-23fb76bee200@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16caa6d0-4368-8931-a77c-23fb76bee200@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefan Agner <stefan@agner.ch>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 16 Jul 2018 21:03:08 +0100
Jon Hunter <jonathanh@nvidia.com> wrote:

> On 16/07/18 15:34, Aapo Vienamo wrote:
> > Tegra SDHCI controllers require the SDHCI clock divider to be configured
> > to divide the clock by two in DDR50/52 modes. Incorrectly configured
> > clock divider results in corrupted data.
> > 
> > Prevent the possibility of incorrectly calculating the divider value due
> > to clock rate rounding or low parent clock frequency by not assigning
> > host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().
> > 
> > See the comments for further details.
> > 
> > Fixes: a8e326a ("mmc: tegra: implement module external clock change")
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index ddf00166..908b23e 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >  	if (!clock)
> >  		return sdhci_set_clock(host, clock);
> >  
> > +	/*
> > +	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI 
> > +	 * divider to be configured to divided the host clock by two. The SDHC
> > +	 * clock divider is calculated as part of sdhci_set_clock() by
> > +	 * sdhci_calc_clk(). The divider is calculated from host->max_clk and
> > +	 * the requested clock rate.
> > +	 *
> > +	 * By setting the host->max_clk to clock * 2 the divider calculation
> > +	 * will always result in the correct value for DDR50/52 modes,
> > +	 * regardless of clock rate rounding, which may happen if the value
> > +	 * from clk_get_rate() is used.
> > +	 */
> >  	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
> >  	clk_set_rate(pltfm_host->clk, host_clk);
> > -	host->max_clk = clk_get_rate(pltfm_host->clk);
> > +	if (tegra_host->ddr_signaling)
> > +		host->max_clk = host_clk;
> > +	else
> > +		host->max_clk = clk_get_rate(pltfm_host->clk);
> >  
> >  	sdhci_set_clock(host, clock);
> >    
> 
> I see what you are saying, but should we be concerned that we are not
> getting the rate we are requesting in the first place?

The rates themselves aren't as critical as the divider on DDR50/52. It's
true that in most sane configurations we should not hit the cases where
the divider will not get configured correctly if the value from
clk_get_rate() is used.

> Maybe it would help if you could provide a specific example showing a
> case where we request rate X and get Y, and then this leads to a bad
> rate Z later.

There are two possible cases where the divider will get configured
incorrectly: either to divide by one or anything greater than two. I
verified that at least on t124 greater dividers also fail in practice.

One option is that the parent clock is unable to supply a rate low
enough. Lets consider DDR50 mode: we request 100 MHz from the parent
clock and let's say it gets rounded to 104 MHz. In this case we end up
with a divider of four because 104 MHz / 2 <= 50 MHz is false, and the
divider is incremented to the next step. This happens because the
divider is calculated the following manner in sdhci_calc_clk(), where in
this case host->max_clk would be 104 MHz and clock 50 MHz:

	for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
	     div += 2) {
		if ((host->max_clk / div) <= clock)
			break;
	}

With the patch we would get DDR50 mode runinng at 52 MHz and without
the patch all IO to the device would fail.

The less likely option is that divider of one is calculated if
host->max_clk is less than or equal to clock. This would happen if the
parent clock is unable to supply a high enough clock rate. So let's say
we are setting up the clocks for DDR50 and request the parent clock to
supply 100 MHz and we get say 50 MHz instead. In this case originally we
would get I/O errors, but with the patch we end up with at DDR50 mode
where the bus is actually run at 25 MHz.

While at least the later case would most likely be a bug or
misconfiguration, it would be still nice to have a mechanism for
graceful dergadation instead of complete failure.

Another option I considered was verifying the parent clock behaviour
during probe and masking DDR50/52 out from the host capability bits
depending on the results. The problem with that is that the exact rate
requested is determined based on CSD register values read from the MMC
device itself.

It's really unfortunate that we have this quirk in the hardware as
dealing with it in a robust manner results in a fair bit of complexity.
Oh well.

 -Aapo
