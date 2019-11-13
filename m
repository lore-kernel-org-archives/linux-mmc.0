From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC-v2 1/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote
 supported strings
Date: Wed, 13 Nov 2019 15:16:52 +0200
Message-ID: <8d7f2a2f-1312-8983-4e58-80dc6939154c@linaro.org>
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
 <1573220319-4287-2-git-send-email-ppvk@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573220319-4287-2-git-send-email-ppvk@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pradeep P V K <ppvk@codeaurora.org>, adrian.hunter@intel.com, robh+dt@kernel.org, ulf.hansson@linaro.org, asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, sboyd@kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, agross@kernel.org, linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Pradeep,

Thanks for the patch!

On 8.11.19 г. 15:38 ч., Pradeep P V K wrote:
> Add Bus bandwidth voting supported strings for qcom-sdhci controller.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..22fb140 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -39,6 +39,25 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +* Following bus parameters are required for bus bw voting:

"bus bw voting" sounds a bit vague to me. I would say instead:

The following DT properties are required for interconnect bandwidth scaling.

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

Please describe here what there are two paths are for sdhc and how they are
expected to be named. You already responded to this question, so please include
this information here.
Hint: Refer to the Documentation for how we described it for other subsystems.

> +- msm-bus,name: string describing the bus path
> +- msm-bus,num-cases: number of configurations in which sdhc can operate in
> +- msm-bus,num-paths: number of paths to vote for
> +- msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples for 2
> +				num-paths) The number of these entries *must*
> +				be same as num-cases.

If it has to be in DT, could we use this [1] instead of the above? The patches
are not merged yet, but this might be the direction we want to go.

Thanks,
Georgi

[1] http://lore.kernel.org/r/20190807223111.230846-1-saravanak@google.com

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
> +		msm-bus,name = "sdhc1";
> +		msm-bus,num-cases = <3>;
> +		msm-bus,num-paths = <2>;
> +		msm-bus,vectors-KBps =
> +		/* No Vote */
> +		<0 0>, <0 0>,
> +		/* 50 MB/s */
> +		<130718 200000>, <133320 133320>,
> +		/* 200 MB/s */
> +		<1338562 4096000>, <1338562 4096000>;
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> 
