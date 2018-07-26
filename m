From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 02/10] dt-bindings: mmc: tegra: Add nvidia,only-1-8-v
 property
Date: Thu, 26 Jul 2018 15:05:55 +0200
Message-ID: <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26.07.2018 14:19, Aapo Vienamo wrote:
> Add a property to mark controllers which operate at a 1.8 V fixed I/O
> voltage.
> 
> This feature of the hardware needs to be signaled this way because it
> cannot be probed at runtime or reliably derived from other properties.

Is this really needed? Can we not use vqmmc to determine which voltage
the controller runs on?

There is already some precedence in the SDHCI core to determine which
voltage levels are supported:
https://lkml.org/lkml/2018/7/5/342

--
Stefan

> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214d..95010cf 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -45,6 +45,8 @@ Optional properties for Tegra210 and Tegra186:
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- nvidia,only-1-8-v : The presence of this property indicates that the
> +  controller operates at a 1.8 V fixed I/O voltage.
>  
>  Example:
>  sdhci@700b0000 {
