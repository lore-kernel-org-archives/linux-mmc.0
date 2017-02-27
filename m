From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/4] Documentation: mmc: add mmc-sleep-awake
Date: Mon, 27 Feb 2017 13:04:38 -0600
Message-ID: <20170227190438.m2nnb24qnnjijp5p@rob-hp-laptop>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
 <1487577792-12510-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487577792-12510-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 20, 2017 at 01:33:09PM +0530, Ritesh Harjani wrote:
> mmc-sleep-awake enables CMD5 awake feature
> & partial_init which can help reduce resume
> latency on emmc.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index c7f4a0e..b0df54c 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -53,6 +53,8 @@ Optional properties:
>  - no-sdio: controller is limited to send sdio cmd during initialization
>  - no-sd: controller is limited to send sd cmd during initialization
>  - no-mmc: controller is limited to send mmc cmd during initialization
> +- mmc-sleep-awake: eMMC to support awake by CMD5 partial init to reduce resume
> +  latency.

This is a feature of the controller or card? If a card, this should be 
in a card node probably.

Is there a better name that matches the h/w feature?

Rob

>  
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
> a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
