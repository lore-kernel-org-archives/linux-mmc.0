From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am65
Date: Tue, 18 Dec 2018 09:54:28 -0600
Message-ID: <20181218155428.GA7670@bogus>
References: <20181207081119.29162-1-faiz_abbas@ti.com>
 <20181207081119.29162-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207081119.29162-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

On Fri, 7 Dec 2018 13:41:18 +0530, Faiz Abbas wrote:
> Commit 26a4f38d1316 ("dt-bindings: mmc: sdhci-of-arasan: Add new
> compatible for AM654 MMC PHY") added a new compatible for supporting
> controllers on TI's AM65x SOCs. It turns out that the controller is
> not compatible with the arasan driver's phy and consumer model as it
> requires some phy registers for core sdhci functionality. This calls
> for the binding to branch out to a new driver.
> 
> Therefore, add a deprecated message for the ti,am654-sdhci-5.1 binding.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
