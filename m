From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive
 strength config
Date: Thu, 3 Jan 2019 12:35:10 -0600
Message-ID: <CAL_JsqLWqhspMNPeqYvh-_ynej-KmwVW93OeQ3E7ic+XSDXngg@mail.gmail.com>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
 <20181227213353.GA8110@bogus> <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Preetham Chandru <pchandru@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 28, 2018 at 6:08 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Hi Rob,
>
> >> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> >> Tegra210 sdmmc which has pad configuration registers in the pinmux
> >> reigster domain.
> >
> > typo
> >
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6
> >> +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> index 32b4b4e41923..2cecdc71d94c 100644
> >> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> @@ -39,12 +39,16 @@ sdhci@c8000200 {
> >>      bus-width = <8>;
> >>  };
> >>
> >> -Optional properties for Tegra210 and Tegra186:
> >> +Optional properties for Tegra210, Tegra186 and Tegra194:
> >
> >Adding Tegra194, but this patch concerns Tegra210...
> Yes this is mainly part of Tegra210 Patch but pinctrls sdmmc-1v8 and sdmmc-3v3
> also applies for Tegra194 and since it was not mentioned, added Tegra194 as well.
> Does adding Tegra194 in this should come as separate patch?

Same patch is fine, just make the commit message match.

> >
> >>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> >>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> >>    for controllers supporting multiple voltage levels. The order of names
> >>    should correspond to the pin configuration states in pinctrl-0 and
> >>    pinctrl-1.
> >> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable
> >> +for
> >
> >These are in addition to the previous values?
> Yes these are additional pinctrl states for pad drive settings which are in pinmux
> Domain and are applicable during calibration process.

Maybe '-cal' instead of '-drv' since that's the mode they apply to.

Rob
