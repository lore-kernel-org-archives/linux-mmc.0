From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 2/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported
 strings
Date: Fri, 13 Sep 2019 15:36:11 +0100
Message-ID: <5d7ba95c.1c69fb81.edf8e.6556@mx.google.com>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-3-git-send-email-ppvk@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1567774037-2344-3-git-send-email-ppvk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pradeep P V K <ppvk@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 06, 2019 at 06:17:17PM +0530, Pradeep P V K wrote:
> Add Bus bandwidth voting supported strings for qcom-sdhci controller.

What is bus bandwidth voting?

> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..8255d92 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -39,6 +39,25 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +* Following bus parameters are required for bus bw voting:
> +- interconnects: Pairs of phandles and interconnect provider specifier
> +		 to denote the edge source and destination ports of
> +		 the interconnect path. Please refer to
> +		 Documentation/devicetree/bindings/interconnect/
> +		 for more details.
> +- interconnect-names: List of interconnect path name strings sorted in the same
> +		order as the interconnects property. Consumers drivers will use
> +		interconnect-names to match interconnect paths with interconnect
> +		specifiers. Please refer to Documentation/devicetree/bindings/
> +		interconnect/ for more details.

How many? What are the strings?

> +- qcom,msm-bus,name: string describing the bus path
> +- qcom,msm-bus,num-cases: number of configurations in which sdhc can operate in
> +- qcom,msm-bus,num-paths: number of paths to vote for
> +- qcom,msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples for 2

ib and ab are what? Didn't we just add interconnect bindings for 
expressing bandwidth?

> +				num-paths) The number of these entries *must*
> +				be same as num-cases.

Are all these properties SDHCI specific or can we expect to get these 
for *all* the QCom blocks?

> +
>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -56,6 +75,19 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +		interconnects = <&qnoc 50 &qnoc 512>,
> +				<&qnoc 1 &qnoc 544>;
> +		interconnect-names = "sdhc-ddr","cpu-sdhc";
> +		qcom,msm-bus,name = "sdhc1";
> +		qcom,msm-bus,num-cases = <3>;
> +		qcom,msm-bus,num-paths = <2>;
> +		qcom,msm-bus,vectors-KBps =
> +		/* No Vote */
> +		<0 0>, <0 0>,
> +		/* 50 MB/s */
> +		<130718 200000>, <133320 133320>,
> +		/* 200 MB/s */
> +		<1338562 4096000>, <1338562 4096000>;
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> -- 
> 1.9.1
> 
