From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 03/40] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
Date: Mon, 13 Aug 2018 13:24:48 -0600
Message-ID: <20180813192448.GA15903@rob-hp-laptop>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1533924522-1037-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924522-1037-4-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 10, 2018 at 09:08:05PM +0300, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to be
> programmed before executing automatic pad drive strength calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
