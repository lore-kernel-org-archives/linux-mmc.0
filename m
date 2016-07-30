From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH 2/3] mmc: sunxi: Set the 'New Timing'
 register for 8 bits DDR transfers
Date: Sat, 30 Jul 2016 12:19:03 +0200
Message-ID: <9414aab0-ac2b-01c2-e16b-8f7394ea7b68@redhat.com>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
 <20160729191730.GG6215@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbcG3KTI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Jul 2016 06:19:08 -0400
In-Reply-To: <20160729191730.GG6215@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: maxime.ripard@free-electrons.com, Jean-Francois Moine <moinejf@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com

Hi,

On 29-07-16 21:17, Maxime Ripard wrote:
> On Thu, Jul 21, 2016 at 11:26:55AM +0200, Jean-Francois Moine wrote:
>> On Thu, 21 Jul 2016 10:56:15 +0200
>> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>>
>>> On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
>>>> The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
>>>> register is set.
>>>
>>> What does that mode brings to the table?
>>
>> From my tests, the eMMC of the Banana Pi M3 (A83T) cannot work when the
>> new mode is not used.
>>
>>>>
>>>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>>>> ---
>>>> Note about the 'new timing mode'.
>>>>
>>>> This patch assumes that, when the new mode is used, the clock driver
>>>> sets the mode select in the MMC clock and multiplies the clock rate
>>>> by 2:
>>>> - MMC side:
>>>>   - with a timing 8 bits DDR at 50MHz, the MMC driver calls
>>>>     clk_set_rate() with a rate 50*2 = 100MHz,
>>>> - clock side:
>>>>   - the clock driver sets the hardware MMC clock to 100*2 = 200MHz,
>>>>   - setting the 'mode select' of the hardware MMC clock divides the
>>>>     rate by 2,
>>>> - MMC side:
>>>>   - setting the MMC clock divider register to 1 divides the rate by 2.
>>>> So, the final rate is 50MHz.
>>>
>>> What happens if you actually want to set it to 100MHz?
>>
>> There is no SDXC_CLK_100M in the mainline driver, and 100MHz is asked
>> only for 8 bits DDR at 50MHz.
>
> You're missing the point.
>
> clk_set_rate is supposed to apply a rate as close as possible as
> requested, there's no reason why you would request a rate twice as
> high as need.

On all SoCs which support it, requesting DDR-8bit needs a twice as high
clock as the mmc base clock (due to the DDR).

If you look at the current code you will see that what actually happens
is that we pass twice as high clock as the mmc-subsys asks for to
clk_set_rate and set the controllers *internal* divider to 2 (instead of
the usual 1), this is not new and not introduced by Jean-Francois' patch.

All Jean-Francois' patch adds is the setting of the new SDXC_REG_NTSR
reg msb bit when we do this. Note no changes to the clock rate calculations
are made. If this fixes the eMMC on A83T boards this seems like a good
patch to me, but IMHO we should only write the SDXC_REG_NTSR on the A83t
and not everywhere as Jean-Francois' patch does.

Jean-Francois, can you submit a v2 of your patch and make the writing of
SDXC_REG_NTSR depend on a new sun8i-a83t-mmc compatible ?

Also you should probably drop the bits about the clock stuff from the
commit message as that just seems to confuse people.

Regards,

Hans
