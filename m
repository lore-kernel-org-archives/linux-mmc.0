From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 02/40] dt-bindings: mmc: tegra: Add pad voltage control
 properties
Date: Thu, 9 Aug 2018 19:36:13 +0300
Message-ID: <20180809193613.5327fc95@dhcp-10-21-25-168>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
        <20180809121500.GP21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809121500.GP21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 14:15:00 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:31:52PM +0300, Aapo Vienamo wrote:
> > Document the pinctrl bindings used by the SDHCI driver to reconfigure
> > pad voltages on controllers supporting multiple voltage levels.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > index 9bce578..90c214d 100644
> > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > @@ -38,3 +38,25 @@ sdhci@c8000200 {
> >  	power-gpios = <&gpio 155 0>; /* gpio PT3 */
> >  	bus-width = <8>;
> >  };
> > +
> > +Optional properties for Tegra210 and Tegra186:
> > +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> > +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> > +  for controllers supporting multiple voltage levels. The order of names
> > +  should correspond to the pin configuration states in pinctrl-0 and
> > +  pinctrl-1.  
> 
> Do we also want "sdmmc-off" to allow SDMMC pads to be powered down when
> the slot or card is not used?

I don't see a real need for it, at least not in the context of this
series which aims to implement support for HS200 and UHS signaling. I
guess it could be added later if there's an actual case for it, where
turning off the pad would result in measureable change in total power
consumption.

 -Aapo

> > +
> > +Example:
> > +sdhci@700b0000 {
> > +	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> > +	reg = <0x0 0x700b0000 0x0 0x200>;
> > +	interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
> > +	clock-names = "sdhci";
> > +	resets = <&tegra_car 14>;
> > +	reset-names = "sdhci";
> > +	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> > +	pinctrl-0 = <&sdmmc1_3v3>;
> > +	pinctrl-1 = <&sdmmc1_1v8>;
> > +	status = "disabled";
> > +};
> > -- 
> > 2.7.4
> >   
