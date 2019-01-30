From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V11 1/4] dt-bindings: mmc: Add supports-cqe property
Date: Wed, 30 Jan 2019 09:51:56 -0600
Message-ID: <20190130155156.GA31692@bogus>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Jan 2019 11:30:51 -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for MMC hosts.
> 
> This property is used to identify the specific host controller
> supporting command queue.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
>  [V11]: Same as V10
>  [V10]: This patch version moves supports-cqe property from vendor
> 	specific MMC property to common MMC property.
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
