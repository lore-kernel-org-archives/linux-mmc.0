From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Date: Thu, 9 Aug 2018 17:06:04 +0300
Message-ID: <20180809170604.4353fe1b@dhcp-10-21-25-168>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
        <20180809113609.GI21639@ulmo>
        <20180809144515.06089abe@dhcp-10-21-25-168>
        <20180809134648.GD21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809134648.GD21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 15:46:48 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Aug 09, 2018 at 02:45:15PM +0300, Aapo Vienamo wrote:
> > On Thu, 9 Aug 2018 13:36:09 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:  
> > > > Document HS400 DQS trim value device tree property.
> > > > 
> > > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > index 3c7960a..7d294f3 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
> > > >    trimmer value for non-tunable modes.
> > > >  - nvidia,default-trim : Specify the default outbound clock trimmer
> > > >    value.
> > > > +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > > >  
> > > >    Notes on the pad calibration pull up and pulldown offset values:
> > > >      - The property values are drive codes which are programmed into the
> > > > @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
> > > >      - The values are programmed to the Vendor Clock Control Register.
> > > >        Please refer to the reference manual of the SoC for correct
> > > >        values.
> > > > +    - The DQS trim values are only used on controllers which support
> > > > +      HS400 timing.    
> > > 
> > > One of these additions says "DQS trim values", the other says "DQS trim
> > > value". It is unclear from the above how many values there are. I think
> > > this should be more explicit. Also, I don't see why the note about which
> > > controllers the DQS trim value(s) applies to is in a separate paragraph.
> > > Couldn't it be moved to the property description?  
> > 
> > It's a single value. The plural form is a mistake.
> >   
> > > Also, I think the bindings should specify which generations of Tegra do
> > > support HS400. Where else are people supposed to find that information?  
> > 
> > This property is under the "Optional properties for Tegra210 and
> > Tegra186" section and it only applies for the said generations.  
> 
> What's the point of specifying that they are only used on controllers
> which support HS400? Are you saying that only a subset of the SDHCI
> controllers on Tegra210 and Tegra186 support HS400?

Yes, on Tegra210 and Tegra186 only SDMMC4 supports HS400.

 -Aapo
