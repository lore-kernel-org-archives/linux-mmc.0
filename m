From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Date: Tue, 9 Oct 2018 11:31:57 +0530
Message-ID: <4881900d-c8e5-278f-012f-541ad13ffca8@codeaurora.org>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
 <20180924194412.GA27477@arch>
 <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
 <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
 <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com>
 <20181008065653.GB2550@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008065653.GB2550@tuxbook-pro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Craig <ctatlor97@gmail.com>
Cc: Vijay Viswanath <vviswana@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, riteshh@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi


On 10/8/2018 12:26 PM, Bjorn Andersson wrote:
> On Sun 07 Oct 01:07 PDT 2018, Craig wrote:
>
>> Any updates on this?
>>
> FWIW I used qcom,sdhci-msm-v5 on QCS404 successfully.
>
> Regards,
> Bjorn

The base address and interrupt numbers needs to be updated in your dt.
you can refer the below link to update interrupt number and base address
https://android.googlesource.com/kernel/msm/+/android-msm-wahoo-4.4-oreo-m2/arch/arm/boot/dts/qcom/sdm660.dtsi

>> On 25 September 2018 16:39:33 BST, Craig <ctatlor97@gmail.com> wrote:
>>>
>>> On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti
>>> <vbadigan@codeaurora.org> wrote:
>>>> On 9/25/2018 1:18 AM, Craig Tatlor wrote:
>>>>> What socs have you tested this on?
>>>>> On sdm660 it seems to crash device
>>>>> when writing pwr ctl.
>>>> Hi
>>>> We have tested this on SDM845.
>>>> SDM660 also has SDCC5 controller, so you would need to define
>>>> "qcom,sdhci-msm-v5" in your platform dt.
>>>> Can you confirm if you have defined this?
>>>>
>>> Hi,
>>> Yes my DT entry is as follows
>>>
>>> sdhc_1: sdhci@f9824900 {
Update this address. This could be the reason for the crash that you are 
observing.

>>>      
>>>               
>>> compatible = "qcom,sdhci-msm-v5";
>>>           
>>> reg = <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;
>>>           
>>> interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>>           

Please update this interrupt map aswell.

>>> interrupt-names = "pwr_irq";
>>>           
>>>                                                                        
>>> bus-width = <8>;
>>>           
>>> non-removable;
>>>           
>>>                                                                        
>>> vmmc-supply = <&pm660l_l4>;
>>>           
>>> vqmmc-supply = <&pm660_l8>;
>>>           
>>>                                                                        
>>> pinctrl-names = "default";
>>>           
>>> pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;
>>>           
>>>                                                                        
>>> clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>>           
>>> clock-names = "core", "iface";
>>>           
>>>         };
>>>
>>>> BTW, can you please share few details of the platform that you are
>>>> checking?
>>>> We are not aware of any dev platform based on SDM660. This is just for
>>>> my info
>>> I'm checking on the sony xperia xa2 (pioneer) smartphone.
>>>>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>>>>>> With SDCC5, the MCI register space got removed and the offset/order
>>>> of
>>>>>> several registers have changed. Based on SDCC version used and the
>>>> register,
>>>>>> we need to pick the base address and offset.
>>>>>>
>>>>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm:
>>> Configuring
>>>> IO_PAD support for sdhci-msm"
>>>>>> Changes since RFC:
>>>>>> 	Dropped voltage regulator changes in sdhci-msm
>>>>>> 	Split the "Register changes for sdcc V5" patch
>>>>>> 	Instead of checking mci removal for deciding which base addr to
>>>> use,
>>>>>> 	new function pointers are defined for the 2 variants of sdcc:
>>>>>> 		1) MCI present
>>>>>> 		2) V5 (mci removed)
>>>>>> 	Instead of string comparing with the compatible string from DT
>>>> file,
>>>>>> 	the sdhci_msm_probe will now pick the data associated with the
>>>>>> 	compatible entry and use it to load variant specific address
>>>> offsets
>>>>>> 	and msm variant specific read/write ops.
>>>>>>
>>>>>> Changes since V1:
>>>>>> 	Removed unused msm_reab & msm_writeb APIs
>>>>>> 	Changed certain register addresses from uppercase to lowercase hex
>>>>>> 	letters
>>>>>> 	Removed extra lines and spaces
>>>>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>>>>>> 	one for Documentation and other for the driver changes.
>>>>>>
>>>>>> Changes since V2:
>>>>>> 	Used lower case for macro function defenitions
>>>>>> 	Removed unused function pointers for msm_readb & msm_writeb
>>>>>>
>>>>>>
>>>>>> Sayali Lokhande (3):
>>>>>>     mmc: sdhci-msm: Define new Register address map
>>>>>>     Documentation: sdhci-msm: Add new compatible string for SDCC v5
>>>>>>     mmc: host: Register changes for sdcc V5
>>>>>>
>>>>>> Vijay Viswanath (1):
>>>>>>     mmc: sdhci-msm: Add msm version specific ops and data structures
>>>>>>
>>>>>>    .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>>>>>>    drivers/mmc/host/sdhci-msm.c                       | 511
>>>> ++++++++++++++++-----
>>>>>>    2 files changed, 391 insertions(+), 127 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>>    Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>>>> Center, Inc.
>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>> a
>>>> Linux Foundation Collaborative Project.
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-arm-msm" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Thanks,
>>>> Veera
>> -- 
>> Sent from my Android device with K-9 Mail. Please excuse my brevity.

Thanks,
Veera
