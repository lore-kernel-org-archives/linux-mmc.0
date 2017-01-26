From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH V3 1/6] dt-bindings: qcom: clk: Add missing binding for
 SDCHI enablement on Nexus 5X/6P
Date: Thu, 26 Jan 2017 16:58:14 -0500
Message-ID: <32dcb31c-d102-3ea5-0951-835a3275df40@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
 <1485250588-24698-2-git-send-email-jeremymc@redhat.com>
 <20170127002448.GB8801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170127002448.GB8801@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2017-01-26 7:24 PM, Stephen Boyd wrote:
> On 01/24, Jeremy McNicoll wrote:
>> AHB clock branch is needed in order to enable SDHCI
>> on msm899(2/4).
>>
>> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
>> ---
>
> Please cc linux-clk on clk patches (it helps my filters).
>

duly noted and added!


>
>>  include/dt-bindings/clock/qcom,gcc-msm8994.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
>> index 8fa535b..df47da0 100644
>> --- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
>> +++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
>> @@ -133,5 +133,6 @@
>>  #define GCC_USB30_MOCK_UTMI_CLK			115
>>  #define GCC_USB3_PHY_AUX_CLK			116
>>  #define GCC_USB_HS_SYSTEM_CLK			117
>> +#define GCC_SDCC1_AHB_CLK			118
>>
>
> Is there a driver patch too? Or just the #define addition.
>

This was split up as I believe I was told that we need to separate
the dt-bindings from the other code.  Or should we combine them when
dealing with clocks?

The other part of this change looks just fine in my inbox.
Unfortunately that is the only place it got sent to. My bad.....
NAK.

Remember kids, cut twice measure once.

I'll send a V4 shortly.



-jeremy
