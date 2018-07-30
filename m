From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: mmc: tegra: Add pad voltage
 control properties
Date: Mon, 30 Jul 2018 17:22:02 -0600
Message-ID: <20180730232202.GA14378@rob-hp-laptop>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532607560-11253-2-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 26, 2018 at 03:19:11PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
