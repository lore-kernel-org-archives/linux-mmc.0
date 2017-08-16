From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [EXT] Re: [PATCH] mmc: sdhci-xenon: add gpio hard reset support
Date: Wed, 16 Aug 2017 08:32:09 +0800
Message-ID: <b56fc3b4-4fff-0881-2233-8f26a6c8407a@rock-chips.com>
References: <1502749156-22798-1-git-send-email-zjwu@marvell.com>
 <3696b751-68cc-6c11-bb7d-af7d6e6a5681@rock-chips.com>
 <59937848.2040901@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:47838 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbdHPAcV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 20:32:21 -0400
In-Reply-To: <59937848.2040901@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

Hi

On 2017/8/16 6:40, Zhoujie Wu wrote:
> Hi Shawn,

>> ----------------------------------------------------------------------
>> Hi
>>
>> On 2017/8/15 6:19, Zhoujie Wu wrote:
>>> On some platforms, like armada3700,  SD card need to
>>> do hard reset by gpio toggling to make it work properly
>>> after warm reset the board.
>>
>> I don't get this that SD card need to do hard reset...
>>
>> I assume what you talk about is either for eMMC or a power-cycle
>> for SD card.
> 
> The subject of the patch confused you. What I want is a power-cycle for 
> the SD card. The gpio is  used to enable/disable the vdd power supply 
> for sd card.
> Actually on a3700, when warm reset the board, their is no power-cycle 
> for SD card, which will lead sd card can't response correct ocr and 
> never set S18A unless a power-cycle.
> This is the purpose I submit this patch.
> 

Well, if that is the case, I suggest you to use regulator-gpio.

i.e:

        vcc_sd: regulator {
                 compatible = "regulator-gpio";
                 regulator-name = "vcc_sd";
                 regulator-min-microvolt = <3300000>;
                 regulator-max-microvolt = <3300000>;

                 gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
                 enable-active-high;
         };

	&sdhci {
		vmmc-supply = <&vcc_sd>;
	}
	

>>
>>> Add gpio hard reset feature for this purpose.
>>>

> 
> 
> 
> 

