From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Fri, 23 Aug 2013 23:12:48 +0900
Message-ID: <52176DE0.4050005@samsung.com>
References: <1377067433-28373-1-git-send-email-yuvaraj.cd@samsung.com>
 <1382155.lZhuLK0WA6@amdc1227>
 <CAKuRcOL7Vs=1em8U6rx=ZBRU8j=0A-WiNK44JrFn6jtVRCns0w@mail.gmail.com>
 <3264029.cracds40W5@flatron>
 <CA+NduCCHe1MR+M52spNC06QHY29z3e6ewiS8KSvw1ROSQDC2zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48204 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab3HWOMl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 10:12:41 -0400
In-reply-to: <CA+NduCCHe1MR+M52spNC06QHY29z3e6ewiS8KSvw1ROSQDC2zg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Cd <yuvaraj.lkml@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>

Hi Yuvaraj,

On 08/23/2013 03:16 PM, Yuvaraj Cd wrote:
> On Fri, Aug 23, 2013 at 4:36 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On Thursday 22 of August 2013 12:24:58 Yuvaraj Kumar wrote:
>>> On Wed, Aug 21, 2013 at 4:00 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>>>> Hi Yuvaraj,
>>>>
>>>> On Wednesday 21 of August 2013 12:13:53 Yuvaraj Kumar C D wrote:
>>>>> This patch adds the device tree node entries for exynos5420 SOC.
>>>>> Exynos5420 has a different version of DWMMC controller,so a new
>>>>> compatible string is used to distinguish it from the prior SOC's.
>>>>
>>>> What are the difference between both versions? Is there a patch adding
>>>> the new compatible to the driver somewhere?
>>>
>>> Exynos5250 has DWMMC controller of IP version 2.41a
>>> Exynos5420 has DWMMC controller of IP version 2.50a
>>> In addition Exynos5420 has Security Management Unit for eMMC.
>>
>> OK. What about my second question?
> Below is the link.
> http://permalink.gmane.org/gmane.linux.kernel.mmc/21060
If you will send the next version,
Could you add the comment about patch has dependency?

Best Regards,
Jaehoon Chung
>>
>>>>> changes since V1:
>>>>>       1.disable node by status = disabled in SOC file
>>>>>       2.enable node by status = okay in board specific file
>>>>
>>>> Ahh, so you fixed this already in this version, thanks. Haven't
>>>> noticed
>>>> this patch at first and commented on previous one. Sorry for the
>>>> noise.
>>>>
>>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>>> ---
>>>>>
>>>>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    2 ++
>>>>>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   38
>>>>>
>>>>> ++++++++++++++++++++ arch/arm/boot/dts/exynos5420.dtsi
>>>>>
>>>>> |   36 +++++++++++++++++++ 3 files changed, 76 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>>> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt index
>>>>> 6d1c098..84cd56f 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>>>>
>>>>> @@ -16,6 +16,8 @@ Required Properties:
>>>>>         specific extensions.
>>>>>
>>>>>       - "samsung,exynos5250-dw-mshc": for controllers with Samsung
>>>>>       Exynos5250
>>>>>
>>>>> specific extensions.
>>>>> +     - "samsung,exynos5420-dw-mshc": for controllers with Samsung
>>>>> Exynos5420 +       specific extensions.
>>>>>
>>>>>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card
>>>>>
>>>>> interface unit (ciu) clock. This property is applicable only for
>>>>> Exynos5 SoC's and diff --git
>>>>> a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>>> b/arch/arm/boot/dts/exynos5420-smdk5420.dts index bafba25..6e65278
>>>>> 100644
>>>>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>>> @@ -31,6 +31,44 @@
>>>>>
>>>>>               };
>>>>>
>>>>>       };
>>>>>
>>>>> +     dwmmc0@12200000 {
>>>>> +             status = "okay";
>>>>> +             num-slots = <1>;
>>>>
>>>> You don't have to specify this property if there is only one slot.
>>>> Also are you sure that this is a board specific property?
>>>
>>> Yes,If num-slots property is not defined dw_mmc driver assumes 1 slot
>>> is available.
>>> I think yes,its a board specific property as number of card slots is
>>> board dependent.
>>>
>>>>> +             broken-cd;
>>>>> +             bypass-smu;
>>>>
>>>> This property doesn't seem to be documented nor used anywhere.
>>>
>>> Sorry. I missed to add in binding document.Will add in next version.
>>
>> Is there a patch adding support for this property to the driver?
> Yes.You can find here http://permalink.gmane.org/gmane.linux.kernel.mmc/21060
>>
>>>>> +             supports-highspeed;
>>>>
>>>> Is it a board specific property?
>>>>
>>>>> +             fifo-depth = <0x80>;
>>>>
>>>> Ditto.
>>>
>>> Ideally this can be move to SOC specific dts.But I am just following
>>> ,already merged smdk5250 board
>>> dts convensions.
>>
>> This means that Exynos5250 board dts files need to be fixed as well.
>>
>>>>> +             card-detect-delay = <200>;
>>>>> +             samsung,dw-mshc-ciu-div = <3>;
>>>>> +             samsung,dw-mshc-sdr-timing = <0 4>;
>>>>> +             samsung,dw-mshc-ddr-timing = <0 2>;
>>>>
>>>> Are the above three properties really board-specific?
>>
>> Hmm?
> I am not sure about this. But Doug Anderson has pointed out these as
> board specific properties.
>>
>> Best regards,
>> Tomasz
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

