From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Thu, 24 Sep 2015 00:12:27 +0200
Message-ID: <CAPDyKFpwaqE59k0L_vL9soxsHbadT-taUY0=akiu=6BRM1aW5w@mail.gmail.com>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
	<CAPDyKFqgHwb7a+wbO_mB6NLGrYtQvTqeeHWhfaz_LX_DoMdmpA@mail.gmail.com>
	<55FADA29.4000005@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37212 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbbIWWM2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 18:12:28 -0400
Received: by wicfx3 with SMTP id fx3so88926208wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 15:12:27 -0700 (PDT)
In-Reply-To: <55FADA29.4000005@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: =Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 17 September 2015 at 17:20, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2015/9/17 19:44, Ulf Hansson wrote:
>>
>> On 14 September 2015 at 08:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>
>>> This patch adds Generic PHY access for sdhci-of-arasan. Driver
>>> can get PHY handler from dt-binding, and power-on/init the PHY.
>>> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
>>> Currently, it's just mandatory for arasan,sdhci-5.1.
>>
>>
>> I am trying to understand how a PHY can be used together with a
>> MMC/SD/SDIO controller. Normally the card connector doesn't hold any
>> intelligence, so I wonder if PHY is correctly used here.
>>
>> Could you try to explain, HW-wise, what role the PHY has for you?
>>
>
> Thanks for comment, Ulf.
>
> It's the first time we introduce phy into mmc subsystem,also it's my first
> time to use phy for emmc in real Soc.
> so definitely we need to discuss it deliberately.
>
> From my view, phy is an active-power, differential sampling and more
> well-designed analog *IO component* for ultra-highspeed device to guarantee
> its signal integrity, like USB, UFS, DDR-RAM,MIPI and so on.
>
> (1)Firstly it contains DLL to generate delayline and phase for sampling data
> from mmc devices. When sdhci controller executes tuning and sends out tuning
> sequence, and PHY can auto change its delayline and phase
> in order to test if this "sample timing" is okay. If not, CRC err is
> generate back to the controller. Then after SDHCI tune timing for 40 times,
> also PHY have scanned all the "sample windows" by trying different delayline
> and phase combination, and finally auto-select the best sample timing for
> the "sample windows". And sdhci HOST CONTROL
> 2 Register[6:7] is controlled by PHY in my case.
>
> (2)Then phy can programming source/sink impedance to avoid signal reflex.
> Given that JEDEC has come to HS533(highspeed 533MHz), this function is
> imperative to be implemented just like the role of ODT for DDR-RAM's PHY.
>
> (3)Phy is integrated with diff pull-up/down resistance value and open-drain
> type for HW design.
>
> (4)Phy can also have some enable-bit to decide whether all mmc
> signal(clk/data/cmd/strobe) can output to the devices or not.

Thanks for elaborating. It seems like using phy is justified in your case.

>
>
> For the card, even for host controller itself, phy can just be regarded as a
> need-to-do-something-before-used GPIO.
> So, before we start initializing card, we need to power up PHY, enable clk
> for it and configure all the stuffs. Also we need to power down it for
> power-saving when into suspend. That's all we need to do and that's all the
> generic phy framework had provided by four interface:
> phy_init/phy_exit/phy_power_on/phy_power_off.
>
>
> Sincerely welcome any comments here to make things better. :)
>
>

I will get back to your patch and review it in detail as soon as can.

Kind regards
Uffe
