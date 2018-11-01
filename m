From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for sdcdc10 DLL
Date: Thu, 1 Nov 2018 17:24:36 +0530
Message-ID: <d4dfd853-d926-3e83-ff9d-8f44b66eb521@codeaurora.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
 <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
 <20181012204848.GA30953@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012204848.GA30953@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 10/13/2018 2:18 AM, Rob Herring wrote:
> On Mon, Oct 08, 2018 at 06:55:37PM +0530, Veerabhadrarao Badiganti wrote:
>> On the SDHC-MSM controllers which makes use of sdcdc10 variant DLLs,
>> the DLL configuration needs to be restored whenever controller clocks
>> are gated. This new compatible string denotes the sdhc-msm controller
>> variant which uses sdcdc10 DLL.
> What is sdcdc10 DLL?
>
> Seems like a work-around to not having SoC specific compatible strings.

Will update this to SOC specific compatible string.

>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 3720385..49b0a43 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -6,7 +6,11 @@ and the properties used by the sdhci-msm driver.
>>   Required properties:
>>   - compatible: Should contain:
>>   		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>> +		"qcom,sdhci-msm-v4-sdcdc10" for sdcc versions < 5.0 and
>> +		which makes use of sdcdc10 variant DLLs.
>>   		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
>> +		"qcom,sdhci-msm-v5-sdcdc10" for sdcc versions >= 5.0 and
>> +		which makes use of sdcdc10 variant DLLs.
>>   		For SDCC version 5.0.0, MCI registers are removed from SDCC
>>   		interface and some registers are moved to HC. New compatible
>>   		string is added to support this change - "qcom,sdhci-msm-v5".
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>

Thanks
Veera
