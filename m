From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: tegra: Add pinctrl for SDMMC
 drive strengths
Date: Tue, 15 Jan 2019 14:05:04 -0600
Message-ID: <20190115200504.GA16841@bogus>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Jan 2019 14:46:01 -0800, Sowjanya Komatineni wrote:
> Add pinctrls for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc.
> 
> Tegra210 sdmmc has pad configuration registers in pinmux register
> domain and handled thru pinctrl to pinmux device node.
> 
> Tegra186 and Tegra194 has pad configuration register with in the
> SDMMC register domain itself and are handles thru drive strength
> properties in sdmmc device node.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
