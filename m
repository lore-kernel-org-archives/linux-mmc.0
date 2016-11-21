From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v8 04/16] ARM: dts: Add xo to sdhc clock node on qcom
 platforms
Date: Mon, 21 Nov 2016 12:00:32 +0530
Message-ID: <7fe256e5-aaad-e087-0c7a-34a39060379b@codeaurora.org>
References: <1479312052-22396-5-git-send-email-riteshh@codeaurora.org>
 <1479343419-29326-1-git-send-email-riteshh@codeaurora.org>
 <20161118035619.GA6400@hector>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161118035619.GA6400@hector>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org



On 11/18/2016 9:26 AM, Andy Gross wrote:
> On Thu, Nov 17, 2016 at 06:13:39AM +0530, Ritesh Harjani wrote:
>> Add xo entry to sdhc clock node on all qcom platforms.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8084.dtsi   | 16 ++++++++++------
>>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 16 ++++++++++------
>>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 ++++++----
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi |  9 +++++----
>>  4 files changed, 31 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> index 39eb7a4..f756cbb 100644
>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> @@ -182,13 +182,13 @@
>>  	};
>>
>>  	clocks {
>> -		xo_board {
>> +		xo_board: xo_board {
>>  			compatible = "fixed-clock";
>>  			#clock-cells = <0>;
>>  			clock-frequency = <19200000>;
>>  		};
>>
>> -		sleep_clk {
>> +		sleep_clk: sleep_clk {
>>  			compatible = "fixed-clock";
>>  			#clock-cells = <0>;
>>  			clock-frequency = <32768>;
>> @@ -416,8 +416,10 @@
>>  			reg-names = "hc_mem", "core_mem";
>>  			interrupts = <0 123 0>, <0 138 0>;
>>  			interrupt-names = "hc_irq", "pwr_irq";
>> -			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>> -			clock-names = "core", "iface";
>> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&xo_board 0>;
>
> With clock-cells = <0>, this should be <&xo_board>
Ok, done.
>
> Somehow this passes the dtc compiler.  But it is still incorrect.  Please fix
> all instances of this to use the correct number of cells in the xo_board
> references.
Sure.
>
>
> Andy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
