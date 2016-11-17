From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 05/16] dt-bindings: sdhci-msm: Add xo property
Date: Thu, 17 Nov 2016 15:03:52 -0800
Message-ID: <20161117230352.GO25626@codeaurora.org>
References: <20161116191335.GH25626@codeaurora.org>
 <1479343623-31163-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbcKQXDz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 18:03:55 -0500
Content-Disposition: inline
In-Reply-To: <1479343623-31163-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, andy.gross@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

On 11/17, Ritesh Harjani wrote:
> Add "xo" property which is tcxo clock.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 485483a..4e61086 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -17,6 +17,7 @@ Required properties:
>  	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
>  	"core"	- SDC MMC clock (MCLK) (required)
>  	"bus"	- SDCC bus voter clock (optional)
> +	"xo" - TCXO clock (optional)

Seems everything else is tabbed before the dash. Otherwise,

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
