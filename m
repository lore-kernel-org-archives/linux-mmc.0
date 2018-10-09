From: Craig <ctatlor97@gmail.com>
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Date: Tue, 09 Oct 2018 07:15:40 +0100
Message-ID: <5A5AEF0D-6996-410E-962C-43B9944F0E28@gmail.com>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org> <20180924194412.GA27477@arch> <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org> <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com> <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com> <20181008065653.GB2550@tuxbook-pro> <4881900d-c8e5-278f-012f-541ad13ffca8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4881900d-c8e5-278f-012f-541ad13ffca8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vijay Viswanath <vviswana@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, riteshh@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org



On 9 October 2018 07:01:57 BST, Veerabhadrarao Badiganti <vbadigan@codeaur=
ora=2Eorg> wrote:
>Hi
>
>
>On 10/8/2018 12:26 PM, Bjorn Andersson wrote:
>> On Sun 07 Oct 01:07 PDT 2018, Craig wrote:
>>
>>> Any updates on this?
>>>
>> FWIW I used qcom,sdhci-msm-v5 on QCS404 successfully=2E
>>
>> Regards,
>> Bjorn
>
>The base address and interrupt numbers needs to be updated in your dt=2E
>you can refer the below link to update interrupt number and base
>address
>https://android=2Egooglesource=2Ecom/kernel/msm/+/android-msm-wahoo-4=2E4=
-oreo-m2/arch/arm/boot/dts/qcom/sdm660=2Edtsi
They look correct, driver only uses pwr irq and the actual reg field is fi=
ne, just node name wrong, which wouldn't cause issues=2E
>>> On 25 September 2018 16:39:33 BST, Craig <ctatlor97@gmail=2Ecom>
>wrote:
>>>>
>>>> On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti
>>>> <vbadigan@codeaurora=2Eorg> wrote:
>>>>> On 9/25/2018 1:18 AM, Craig Tatlor wrote:
>>>>>> What socs have you tested this on?
>>>>>> On sdm660 it seems to crash device
>>>>>> when writing pwr ctl=2E
>>>>> Hi
>>>>> We have tested this on SDM845=2E
>>>>> SDM660 also has SDCC5 controller, so you would need to define
>>>>> "qcom,sdhci-msm-v5" in your platform dt=2E
>>>>> Can you confirm if you have defined this?
>>>>>
>>>> Hi,
>>>> Yes my DT entry is as follows
>>>>
>>>> sdhc_1: sdhci@f9824900 {
>Update this address=2E This could be the reason for the crash that you
>are=20
>observing=2E
>
>>>>     =20
>>>>              =20
>>>> compatible =3D "qcom,sdhci-msm-v5";
>>>>          =20
>>>> reg =3D <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;
>>>>          =20
>>>> interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>>>          =20
>
>Please update this interrupt map aswell=2E
>
>>>> interrupt-names =3D "pwr_irq";
>>>>          =20
>>>>                                                                   =20
>  =20
>>>> bus-width =3D <8>;
>>>>          =20
>>>> non-removable;
>>>>          =20
>>>>                                                                   =20
>  =20
>>>> vmmc-supply =3D <&pm660l_l4>;
>>>>          =20
>>>> vqmmc-supply =3D <&pm660_l8>;
>>>>          =20
>>>>                                                                   =20
>  =20
>>>> pinctrl-names =3D "default";
>>>>          =20
>>>> pinctrl-0 =3D <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;
>>>>          =20
>>>>                                                                   =20
>  =20
>>>> clocks =3D <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>>>          =20
>>>> clock-names =3D "core", "iface";
>>>>          =20
>>>>         };
>>>>
>>>>> BTW, can you please share few details of the platform that you are
>>>>> checking?
>>>>> We are not aware of any dev platform based on SDM660=2E This is just
>for
>>>>> my info
>>>> I'm checking on the sony xperia xa2 (pioneer) smartphone=2E
>>>>>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>>>>>>> With SDCC5, the MCI register space got removed and the
>offset/order
>>>>> of
>>>>>>> several registers have changed=2E Based on SDCC version used and
>the
>>>>> register,
>>>>>>> we need to pick the base address and offset=2E
>>>>>>>
>>>>>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm:
>>>> Configuring
>>>>> IO_PAD support for sdhci-msm"
>>>>>>> Changes since RFC:
>>>>>>> 	Dropped voltage regulator changes in sdhci-msm
>>>>>>> 	Split the "Register changes for sdcc V5" patch
>>>>>>> 	Instead of checking mci removal for deciding which base addr to
>>>>> use,
>>>>>>> 	new function pointers are defined for the 2 variants of sdcc:
>>>>>>> 		1) MCI present
>>>>>>> 		2) V5 (mci removed)
>>>>>>> 	Instead of string comparing with the compatible string from DT
>>>>> file,
>>>>>>> 	the sdhci_msm_probe will now pick the data associated with the
>>>>>>> 	compatible entry and use it to load variant specific address
>>>>> offsets
>>>>>>> 	and msm variant specific read/write ops=2E
>>>>>>>
>>>>>>> Changes since V1:
>>>>>>> 	Removed unused msm_reab & msm_writeb APIs
>>>>>>> 	Changed certain register addresses from uppercase to lowercase
>hex
>>>>>>> 	letters
>>>>>>> 	Removed extra lines and spaces
>>>>>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into
>two,
>>>>>>> 	one for Documentation and other for the driver changes=2E
>>>>>>>
>>>>>>> Changes since V2:
>>>>>>> 	Used lower case for macro function defenitions
>>>>>>> 	Removed unused function pointers for msm_readb & msm_writeb
>>>>>>>
>>>>>>>
>>>>>>> Sayali Lokhande (3):
>>>>>>>     mmc: sdhci-msm: Define new Register address map
>>>>>>>     Documentation: sdhci-msm: Add new compatible string for SDCC
>v5
>>>>>>>     mmc: host: Register changes for sdcc V5
>>>>>>>
>>>>>>> Vijay Viswanath (1):
>>>>>>>     mmc: sdhci-msm: Add msm version specific ops and data
>structures
>>>>>>>
>>>>>>>    =2E=2E=2E/devicetree/bindings/mmc/sdhci-msm=2Etxt          |   =
7 +-
>>>>>>>    drivers/mmc/host/sdhci-msm=2Ec                       | 511
>>>>> ++++++++++++++++-----
>>>>>>>    2 files changed, 391 insertions(+), 127 deletions(-)
>>>>>>>
>>>>>>> --=20
>>>>>>>    Qualcomm India Private Limited, on behalf of Qualcomm
>Innovation
>>>>> Center, Inc=2E
>>>>>>> Qualcomm Innovation Center, Inc=2E is a member of Code Aurora
>Forum,
>>>> a
>>>>> Linux Foundation Collaborative Project=2E
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-arm-msm" in
>>>>>>> the body of a message to majordomo@vger=2Ekernel=2Eorg
>>>>>>> More majordomo info at=20
>http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml
>>>>> Thanks,
>>>>> Veera
>>> --=20
>>> Sent from my Android device with K-9 Mail=2E Please excuse my brevity=
=2E
>
>Thanks,
>Veera

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
