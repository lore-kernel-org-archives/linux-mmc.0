From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am654
Date: Fri, 30 Nov 2018 08:18:59 +0100
Message-ID: <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129161513.31734-3-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

On 29. 11. 18 17:15, Faiz Abbas wrote:
> The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
> this by a deprecated message.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index e2effe17f05e..1edbb049cccb 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -16,6 +16,10 @@ Required Properties:
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>      - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
> +	Note: This binding has been deprecated and moved to [5].
> +
> +  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> +
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> 

I would prefer if you can extend commit message by description you have
in cover letter which explains reasons. When this is applied and someone
look at git history none will understand from first read why you have
done that.

Thanks,
Michal
