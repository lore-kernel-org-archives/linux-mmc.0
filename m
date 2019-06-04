From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
Date: Tue, 4 Jun 2019 10:18:39 +0800
Message-ID: <CAMz4kuKXqTWfH0d=4hV_+k8ukYhihQP4QcqFQ+jpiQSu21TQ3g@mail.gmail.com>
References: <cover.1558346019.git.baolin.wang@linaro.org> <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
 <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Vincent Guittot <vincent.guittot@linaro.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 3 Jun 2019 at 21:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/05/19 1:12 PM, Baolin Wang wrote:
> > Set the PHY DLL delay for each timing mode, which is used to sample the clock
> > accurately and make the clock more stable.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> One comment, nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index e6eda13..911a09b 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -29,6 +29,8 @@
> >  #define  SDHCI_SPRD_DLL_INIT_COUNT   0xc00
> >  #define  SDHCI_SPRD_DLL_PHASE_INTERNAL       0x3
> >
> > +#define SDHCI_SPRD_REG_32_DLL_DLY    0x204
> > +
> >  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET     0x208
> >  #define  SDHCIBSPRD_IT_WR_DLY_INV            BIT(5)
> >  #define  SDHCI_SPRD_BIT_CMD_DLY_INV          BIT(13)
> > @@ -72,6 +74,24 @@ struct sdhci_sprd_host {
> >       struct clk *clk_2x_enable;
> >       u32 base_rate;
> >       int flags; /* backup of host attribute */
> > +     u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> > +};
> > +
> > +struct sdhci_sprd_phy_cfg {
> > +     const char *property;
> > +     u8 timing;
> > +};
> > +
> > +static const struct sdhci_sprd_phy_cfg sdhci_sprd_phy_cfgs[] = {
> > +     { "sprd,phy-delay-legacy", MMC_TIMING_LEGACY, },
> > +     { "sprd,phy-delay-sd-highspeed", MMC_TIMING_MMC_HS, },
>
> Did you mean MMC_TIMING_SD_HS

Ah, yes, my copy mistake and will fix it in next version.
Thanks for your reviewing and comments.

-- 
Baolin Wang
Best Regards
