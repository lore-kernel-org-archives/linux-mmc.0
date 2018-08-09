From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Date: Thu, 9 Aug 2018 15:22:54 +0300
Message-ID: <20180809152254.03b97af0@dhcp-10-21-25-168>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
        <20180809114345.GL21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809114345.GL21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 13:43:45 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> > Implement HS400 enhanced strobe.  
> 
> Can you provide a little more information about what the impact is of
> this? Does this increase throughput? How much?

The eMMC enhanced strobe is a mechanism that can be used instead of the
HS400 tuning procedure. Note that the delay line calibration implemented
later on in this series is Tegra specific and has to be performed
regardless of which type of HS400 tuning mechanism is used.

> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 426f7ea..d81143b 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -43,6 +43,9 @@
> >  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
> >  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> >  
> > +#define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
> > +#define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
> > +
> >  #define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
> >  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
> >  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> > @@ -271,6 +274,22 @@ static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
> >  	}
> >  }
> >  
> > +static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> > +					      struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	u32 reg;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> > +	pr_err("enhanced strobe: %d\n", ios->enhanced_strobe);  
> 
> Left-over debug error?

Yep.

> 
> > +	if (ios->enhanced_strobe)
> > +		reg |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> > +	else
> > +		reg &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);  
> 
> You might want to add blank lines around the if ... else ... block for
> readability.

True.

 -Aapo
