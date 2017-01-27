From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 1/6] dt-bindings: qcom: clk: Add missing binding for
 SDCHI enablement on Nexus 5X/6P
Date: Thu, 26 Jan 2017 16:24:48 -0800
Message-ID: <20170127002448.GB8801@codeaurora.org>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
 <1485250588-24698-2-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485250588-24698-2-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On 01/24, Jeremy McNicoll wrote:
> AHB clock branch is needed in order to enable SDHCI
> on msm899(2/4).
> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---

Please cc linux-clk on clk patches (it helps my filters).


>  include/dt-bindings/clock/qcom,gcc-msm8994.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
> index 8fa535b..df47da0 100644
> --- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
> +++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
> @@ -133,5 +133,6 @@
>  #define GCC_USB30_MOCK_UTMI_CLK			115
>  #define GCC_USB3_PHY_AUX_CLK			116
>  #define GCC_USB_HS_SYSTEM_CLK			117
> +#define GCC_SDCC1_AHB_CLK			118
>  

Is there a driver patch too? Or just the #define addition.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
