From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Date: Thu, 9 Aug 2018 15:56:38 +0300
Message-ID: <20180809155638.23f96e61@dhcp-10-21-25-168>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
        <20180809124616.GV21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809124616.GV21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 14:46:16 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> > Implement polling with 10 ms timeout for automatic pad drive strength
> > calibration.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 7d98455..c8ff267 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> > @@ -50,6 +51,9 @@
> >  #define SDHCI_AUTO_CAL_START			BIT(31)
> >  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> >  
> > +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> > +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> > +
> >  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
> >  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
> >  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> > @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
> >  
> >  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
> >  {
> > -	u32 val;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > +	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> > +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> >    
> 
> I know this is preexisting, but I want to make sure we cover this so we
> don't run into this down the road: do these bits automatically clear on
> calibration completion? Can we run these multiple times and get
> everything properly calibrated?

The TRM states in the pad auto-calibration procedure description that
this bit should not be cleared.

 -Aapo
