From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date: Mon, 21 Jan 2019 08:31:34 -0600
Message-ID: <20190121143134.GA18401@bogus>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <20190121104333.GD16756@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121104333.GD16756@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 21, 2019 at 11:43:33AM +0100, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:03:50AM -0800, Sowjanya Komatineni wrote:
> > Add supports-cqe optional property for Tegra SDMMC.
> > 
> > Tegra186 and Tegra194 supports HW Command queue only
> > on SDMMC4 controller. This property is used to identify
> > command queue support controller in the tegra sdhci driver.
> > 
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > index 32b4b4e41923..fb14c2c8d7ee 100644
> > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > @@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
> >  - nvidia,default-trim : Specify the default outbound clock trimmer
> >    value.
> >  - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > +- supports-cqe : The presence of this property indicates that the
> > +  corresponding controller supports HW command queue feature.
> > +  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
> > +  controller supports HW Command Queue with eMMC device.
> 
> Hi Rob,
> 
> are you okay with the property name for this. I'm wondering if it should
> have a vendor prefix or not, but I suspect that something like this may
> be needed for other vendors as well, so not having a vendor prefix could
> be warranted in this case.

Seems likely. Please document with common MMC properties in that case.

Rob
