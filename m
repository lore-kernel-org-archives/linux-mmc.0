From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Date: Fri, 11 Jan 2019 10:11:20 -0600
Message-ID: <20190111161120.GA6491@bogus>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2 Jan 2019 12:57:52 -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.
> Pad drive strengths for Tegra186 and Later are
> part of SDMMC device node itself.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
