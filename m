From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mmc: Add DQS trim value to Tegra
 SDHCI
Date: Mon, 13 Aug 2018 13:26:32 -0600
Message-ID: <20180813192632.GA28960@rob-hp-laptop>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
 <1533924845-1466-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924845-1466-2-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 10, 2018 at 09:13:58PM +0300, Aapo Vienamo wrote:
> Document HS400 DQS trim value device tree property.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
