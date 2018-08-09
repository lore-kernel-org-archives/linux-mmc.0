From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 4/8] mmc: tegra: Implement HS400 delay line calibration
Date: Thu, 9 Aug 2018 15:29:18 +0300
Message-ID: <20180809152918.4a3e7060@dhcp-10-21-25-168>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
        <20180809114805.GM21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809114805.GM21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 13:48:05 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 05:00:00PM +0300, Aapo Vienamo wrote:
> > Implement HS400 specific delay line calibration procedure.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)  
> 
> Should this be before the previous patch in order to make sure the
> calibration is performed as soon as the feature is available. This is
> counting beans I guess, but it is technically possible for someone to
> get everything up to patch 3/8 and then get the corresponding changes
> in the DTS files to enable the mode and then have HS400 enabled without
> this calibration.

True.

> 
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index d81143b..d0b68b7 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -56,6 +56,12 @@
> >  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
> >  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> >  
> > +#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
> > +#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
> > +
> > +#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
> > +#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
> > +
> >  #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
> >  #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> >  
> > @@ -584,6 +590,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> >  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> >  }
> >  
> > +static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
> > +{
> > +	u32 reg;
> > +	int err;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
> > +	reg |= SDHCI_TEGRA_DLLCAL_CALIBRATE;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);  
> 
> Is this self-clearing? Or do we need to clear it manually in order for
> a subsequent calibration procedure to succeed?

Yes, the TRM states that this bit should not be cleared by software.

 -Aapo
