From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: mmc: tegra: Add nvidia,only-1-8-v
 property
Date: Mon, 30 Jul 2018 17:24:41 -0600
Message-ID: <20180730232441.GA17560@rob-hp-laptop>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
 <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
 <20180727110555.1b7ad97d@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727110555.1b7ad97d@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Stefan Agner <stefan@agner.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 27, 2018 at 11:05:55AM +0300, Aapo Vienamo wrote:
> On Thu, 26 Jul 2018 15:05:55 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
> > On 26.07.2018 14:19, Aapo Vienamo wrote:
> > > Add a property to mark controllers which operate at a 1.8 V fixed I/O
> > > voltage.
> > > 
> > > This feature of the hardware needs to be signaled this way because it
> > > cannot be probed at runtime or reliably derived from other properties.  
> > 
> > Is this really needed? Can we not use vqmmc to determine which voltage
> > the controller runs on?
> > 
> > There is already some precedence in the SDHCI core to determine which
> > voltage levels are supported:
> > https://lkml.org/lkml/2018/7/5/342
> 
> This property is introduced to solve a slightly different issue. The
> thing is that supplying a fixed voltage SDHCI controller from a variable
> regulator is still a valid configuration. Which means that testing the
> capabilities of the regulator doesn't actually describe the SDHCI
> controller itself.

The regulator constraints should reflect this. The constraints aren't 
the capabilities of the regulator, but the limits on what it is 
supplying.

> 
> In practice this property is used to communicate whether pad
> reconfiguration and voltage switching needs to be performed or not. This
> cannot be determined from the absence or presence of the pinctrl
> properties either because they naturally won't be there on older dtbs.
> 
> The logic behind this goes like this: if this property is present,
> there's no need to perform pad or regulator reconfiguration and UHS
> modes can be enabled. If this property is missing then valid pinctrl and
> regulator properties are required to enable UHS signaling. This is
> implemented in tegra_sdhci_is_uhs_valid() in "[PATCH v2 03/10] mmc:
> tegra: Reconfigure pad voltages during voltage switching"
> 
>  -Aapo
