From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 6/6] dt-bindings: mmc: sdhci-msm: Add clk scaling dt
 parameters
Date: Tue, 29 Oct 2019 11:36:59 -0500
Message-ID: <20191029163659.GC1057@bogus>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <1571668177-3766-7-git-send-email-rampraka@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571668177-3766-7-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Prakash Gupta <rampraka@codeaurora.org>
Cc: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 21, 2019 at 07:59:37PM +0530, Ram Prakash Gupta wrote:
> Adding clk scaling dt parameters.
> 
> Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..afaf88d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -39,6 +39,21 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional properties:
> +- devfreq,freq-table - specifies supported frequencies for clock scaling.
> +	Clock scaling logic shall toggle between these frequencies based
> +	on card load. In case the defined frequencies are over or below
> +	the supported card frequencies, they will be overridden
> +	during card init. In case this entry is not supplied,
> +	the driver will construct one based on the card
> +	supported max and min frequencies.
> +	The frequencies must be ordered from lowest to highest.

This should be common. Surely we already have something?

> +
> +- scaling-lower-bus-speed-mode - Few hosts can support DDR52 mode at the
> +	same lower system voltage corner as high-speed mode. In such
> +	cases, it is always better to put it in DDR  mode which will
> +	improve the performance without any power impact.

The description sounds like a boolean. Why the string? What are possible 
values?

Also needs a 'qcom' vendor prefix.

> +
>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -56,6 +71,10 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +
> +		devfreq,freq-table = <50000000 200000000>;
> +		scaling-lower-bus-speed-mode = "DDR52"
> +
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> -- 
> 1.9.1
> 
