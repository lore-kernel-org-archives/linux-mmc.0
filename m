From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Date: Thu, 9 Aug 2018 15:02:26 +0300
Message-ID: <20180809150226.64657f56@dhcp-10-21-25-168>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
        <20180809114922.GN21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809114922.GN21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 13:49:22 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> > Add the HS400 DQS trim value for Tegra186 SDMMC4.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > index 6e9ef26..9e07bc6 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > @@ -313,6 +313,7 @@
> >  		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
> >  		nvidia,default-tap = <0x5>;
> >  		nvidia,default-trim = <0x9>;
> > +		nvidia,dqs-trim = <63>;
> >  		status = "disabled";
> >  	};
> >    
> 
> Isn't this technically dependent on the board layout and as such would
> belong in the board DTS file? Or does this value work on all existing
> Tegra186 platforms?

This value is specified as part of the controller initialization
sequence in the TRM. I've understood that this (and other tap and trim)
value(s) are used for compensating the propagation delay differences
that are caused by the internal SoC layout.

 -Aapo
