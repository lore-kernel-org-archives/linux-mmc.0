From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
Date: Fri, 12 Oct 2018 09:55:16 -0500
Message-ID: <20181012145516.GA10205@bogus>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 08, 2018 at 06:48:58PM +0530, Veerabhadrarao Badiganti wrote:
> From: Vijay Viswanath <vviswana@codeaurora.org>
> 
> The load a particular sdhc controller should request from a regulator
> is device specific and hence each device should individually vote for
> the required load.
> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..cb22178 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,10 @@ Required properties:
>  	"xo"	- TCXO clock (optional)
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
> +					BUS_OFF states in power irq. Should be specified in
> +					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> +					Units uA.

Seems like something that should be common?
