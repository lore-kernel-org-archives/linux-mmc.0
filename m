From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/6] Add support of inverting power control and some
 minor cleanup
Date: Thu, 11 Aug 2016 19:08:38 +0900
Message-ID: <9227304b-4d2e-66e1-743a-8d06f2a10ce1@samsung.com>
References: <CGME20160807013720epcas1p235628058a90efa6f0062b03a4b2e4284@epcas1p2.samsung.com>
 <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
 <ee997311-3964-8623-a431-c9a5add7f991@samsung.com>
 <cc785e09-6b33-d451-3d11-728bee3668a5@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42870 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870AbcHKKIq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2016 06:08:46 -0400
In-reply-to: <cc785e09-6b33-d451-3d11-728bee3668a5@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

Hi Shawn,

On 08/09/2016 10:49 AM, Shawn Lin wrote:
> Hi,
> 
> On 2016/8/8 18:24, Jaehoon Chung wrote:
>> Hi Shawn,
>>
>> On 08/07/2016 10:33 AM, Shawn Lin wrote:
>>> By default, dw_mmc outputs high level voltage to indicate powering
>>> up the card and outputs low level vcltage to indicate powering
>>> off the card. But that is not always correct. The power io should
>>> be able to control different kind of hw components to supply or
>>> cutoff power to the card. We have boards that need this patchset
>>> to make the power control correct. Meanwhile let's expose it to
>>> DT for board-specific usage.
>>
>> I have a question for this patch-set. Does DWMMC IP support to invert ON/OFF at Power Enable register?
> 
> No.
> 
>> Hmm..Well, if use the DW_MMC_CARD_PWR_INVERT, it should also be the similar behavior with Quirks.
> 
> yup, it makes the power control more complicated than before. :(
> 
>>
>> Other flags are related with dwmmc IP. But this flag (DW_MMC_CARD_PWR_INVERT) is not related with IP side.
>> I understood why you needs to add this flag..Is rockchip designed to invert the power controlling?
> 
> We don't invert the power controlling but our customers do.
> The HW componet looks like some discrete LDOs which enable the related
> power supply when outputing low voltage from pwren..

Is it related with PWREN register?
I'm checking the TRM for PWREN register..

"Optional feature; ports can be used as general-purpose outputs."

Does it use the ports as GPIO?

> 
>>
>> But it's not general case. We can discuss about this.
> 
> I have a solution which is to add gpio power control for slot-gpio of
> mmc core. once finished, we could add pwr_cap_invert just like what we
> did for cd/wp invert control..

I'm not sure that it's right that add the gpio power control into mmc core.
slot-gpio? i think it can use the regulator framework with gpio.
I don't have a lot knowledge of power, but it might be controlled whether active is low or high.
So i think it doesn't need to add for entire mmc controller.

Best Regards,
Jaehoon Chung

> 
> Then we could remove PWREN from the default state of
> pinctrl inside the sdmmc dt node, and let dwmmc request gpio power
> control stuff after paring the property for pwr_cap_invert..
> 
> More over, it well fit for all mmc host's requirement of gpio
> power control and inverted control if they want it. :)
> 
> 
> That should be legit for us?
> If it sounds ok to you and Ulf, I will come up with a RFC one for
> community to comment it.:)
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>>
>>> Changes in v2:
>>> - fix copy-paste err and typo
>>>
>>> Shawn Lin (6):
>>>   dt-bindings: rockchip-dw-mshc: add description of
>>>     rockchip,power-invert
>>>   mmc: dw_mmc: cleanup power setting of set_ios callback
>>>   mmc: dw_mmc: split out dw_mci_set_power
>>>   mmc: dw_mmc: split out dw_mci_set_power_reg
>>>   mmc: dw_mmc: support inverted power control
>>>   mmc: dw_mmc-rockchip: add parsing of power control from DT
>>>
>>>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   6 +
>>>  drivers/mmc/host/dw_mmc-rockchip.c                 |   8 ++
>>>  drivers/mmc/host/dw_mmc.c                          | 134 ++++++++++++---------
>>>  drivers/mmc/host/dw_mmc.h                          |   1 +
>>>  4 files changed, 90 insertions(+), 59 deletions(-)
>>>
>>
>>
>>
>>
> 
> 

