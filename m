From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 04/14] ARM: dts: Add xo_clock to sdhc nodes on qcom
 platforms
Date: Mon, 14 Nov 2016 12:01:15 -0800
Message-ID: <20161114200115.GL5177@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-5-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479103248-9491-5-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 11/14, Ritesh Harjani wrote:
> Add xo_clock to sdhc clock node on all qcom platforms.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi   | 14 ++++++++------
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 14 ++++++++------
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 ++++++----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi |  9 +++++----
>  4 files changed, 27 insertions(+), 20 deletions(-)
> 

Is there an update to
Documentation/devicetree/bindings/mmc/sdhci-msm.txt as well?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
