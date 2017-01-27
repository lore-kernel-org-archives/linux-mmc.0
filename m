From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 4/6] arm64: dts: smem enablement for msm8992
Date: Fri, 27 Jan 2017 11:58:31 -0800
Message-ID: <20170127195831.GH8801@codeaurora.org>
References: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
 <1485508205-1904-5-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485508205-1904-5-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, andy.gross@linaro.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On 01/27, Jeremy McNicoll wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> index 13fb6f7..2c05ec7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> +
> +		sfpb_mutex: hwmutex {
> +			compatible = "qcom,sfpb-mutex";
> +			syscon = <&sfpb_mutex_regs 0x0 0x100>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		smem {
> +			compatible = "qcom,smem";
> +			memory-region = <&smem_region>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			hwlocks = <&sfpb_mutex 3>;
> +		};

Move these nodes outside soc node please.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
