From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [EXT] Re: [PATCH] mmc: sdhci-xenon: add gpio hard reset support
Date: Wed, 16 Aug 2017 15:46:53 -0700
Message-ID: <5994CB5D.5080509@marvell.com>
References: <1502749156-22798-1-git-send-email-zjwu@marvell.com>
 <3696b751-68cc-6c11-bb7d-af7d6e6a5681@rock-chips.com>
 <59937848.2040901@marvell.com>
 <b56fc3b4-4fff-0881-2233-8f26a6c8407a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48057 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752517AbdHPWrC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Aug 2017 18:47:02 -0400
In-Reply-To: <b56fc3b4-4fff-0881-2233-8f26a6c8407a@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

Hi ,

On 08/15/2017 05:32 PM, Shawn Lin wrote:
> Hi
>
> On 2017/8/16 6:40, Zhoujie Wu wrote:
>> Hi Shawn,
>
>>> ----------------------------------------------------------------------
>>> Hi
>>>
>>> On 2017/8/15 6:19, Zhoujie Wu wrote:
>>>> On some platforms, like armada3700, SD card need to
>>>> do hard reset by gpio toggling to make it work properly
>>>> after warm reset the board.
>>>
>>> I don't get this that SD card need to do hard reset...
>>>
>>> I assume what you talk about is either for eMMC or a power-cycle
>>> for SD card.
>>
>> The subject of the patch confused you. What I want is a power-cycle 
>> for the SD card. The gpio is  used to enable/disable the vdd power 
>> supply for sd card.
>> Actually on a3700, when warm reset the board, their is no power-cycle 
>> for SD card, which will lead sd card can't response correct ocr and 
>> never set S18A unless a power-cycle.
>> This is the purpose I submit this patch.
>>
>
> Well, if that is the case, I suggest you to use regulator-gpio.
>
> i.e:
>
>        vcc_sd: regulator {
>                 compatible = "regulator-gpio";
>                 regulator-name = "vcc_sd";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>
>                 gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
>         };
>
>     &sdhci {
>         vmmc-supply = <&vcc_sd>;
>     }
>
>

I tried to use the vmmc-supply regulator before I submit this patch, I 
met a issue in this case.
sdhci_set_power_reg will be called instead, and I saw 
mmc_regulator_set_ocr do enabled the regulator, after that SW will set 
0xf to power controller register, but the register is self-cleared to 0 
soon which lead to later cmd timeout all the time.
Have you ever met similar issue before?

>>>
>>>> Add gpio hard reset feature for this purpose.
>>>>
>
>>
>>
>>
>>
>

