From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 2/3] Documentation: sdhci-msm: Add entries for passing
 load values
Date: Wed, 25 Jul 2018 11:55:22 -0600
Message-ID: <20180725175522.GA10185@rob-hp-laptop>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
 <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 20, 2018 at 04:16:05PM +0530, Vijay Viswanath wrote:
> The load a particular sdhc controller should request from a regulator
> is device specific and hence each device should individually vote for
> the required load.

"dt-bindings: mmc: ..." for the subject.

> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..ee34f28 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,6 +26,11 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional properties:
> +- <supply>-current-level - specifies load levels for supply during BUS_ON
> +			and BUS_OFF states in power irq. Should be specified in
> +			pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> +			Units uA.

This should probably be a common regulator property (or maybe one exists 
already).

It is missing vendor prefix and unit suffix as-is.

Rob
