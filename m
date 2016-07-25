From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/3] phy: rockchip-emmc: Be tolerant to card clock of 0 in
 power on
Date: Mon, 25 Jul 2016 11:27:21 +0530
Message-ID: <5795AA41.7070604@ti.com>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
 <1467049167-14628-3-git-send-email-dianders@chromium.org>
 <5773D1FD.8020601@ti.com>
 <CAD=FV=U_-8HJRjWa8ktT=7tmM5RB4OVnDce-Bv2teDibYfbCeA@mail.gmail.com>
 <CAPDyKFqPHB2O=-hDxVda-h04WS9xYpJ3MyzH8bk5Fc4ogTfB5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcGYF6E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 01:58:04 -0400
In-Reply-To: <CAPDyKFqPHB2O=-hDxVda-h04WS9xYpJ3MyzH8bk5Fc4ogTfB5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ulf,

On Saturday 23 July 2016 03:09 PM, Ulf Hansson wrote:
> On 29 June 2016 at 17:18, Doug Anderson <dianders@chromium.org> wrote:
>> Kishon,
>>
>> On Wed, Jun 29, 2016 at 6:49 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Hi,
>>>
>>> On Monday 27 June 2016 11:09 PM, Douglas Anderson wrote:
>>>> It's possible that there are some reasons to turn the PHY on while the
>>>> clock is 0.  In this case we just won't wait for the DLL to lock.
>>>>
>>>> This is a bit of a stopgap until we figure out exactly when we're
>>>> supposed to wait for the DLL to lock and when we're supposed to power
>>>> cycle the PHY.
>>>>
>>>> Note: this patch should help with suspend/resume where the system will
>>>> try to turn the PHY back on when the clock is 0.
>>>>
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>>  drivers/phy/phy-rockchip-emmc.c | 59 ++++++++++++++++++++++++++---------------
>>>>  1 file changed, 37 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
>>>> index 9dce958233a0..a2aa6aca7dec 100644
>>>> --- a/drivers/phy/phy-rockchip-emmc.c
>>>> +++ b/drivers/phy/phy-rockchip-emmc.c
>>>> @@ -88,15 +88,36 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>>>>       unsigned int caldone;
>>>>       unsigned int dllrdy;
>>>>       unsigned int freqsel = PHYCTRL_FREQSEL_200M;
>>>> +     unsigned long rate;
>>>>       unsigned long timeout;
>>>>
>>>> -     if (rk_phy->emmcclk != NULL) {
>>>> -             unsigned long rate = clk_get_rate(rk_phy->emmcclk);
>>>> +     /*
>>>> +      * Keep phyctrl_pdb and phyctrl_endll low to allow
>>>> +      * initialization of CALIO state M/C DFFs
>>>> +      */
>>>> +     regmap_write(rk_phy->reg_base,
>>>> +                  rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>>>> +                  HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
>>>> +                                PHYCTRL_PDB_MASK,
>>>> +                                PHYCTRL_PDB_SHIFT));
>>>> +     regmap_write(rk_phy->reg_base,
>>>> +                  rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>>>> +                  HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
>>>> +                                PHYCTRL_ENDLL_MASK,
>>>> +                                PHYCTRL_ENDLL_SHIFT));
>>>> +
>>>> +     /* Already finish power_off above */
>>>> +     if (on_off == PHYCTRL_PDB_PWR_OFF)
>>>> +             return 0;
>>>> +
>>>> +     rate = clk_get_rate(rk_phy->emmcclk);
>>>> +
>>>> +     if (rate != 0) {
>>>>               unsigned long ideal_rate;
>>>>               unsigned long diff;
>>>>
>>>>               switch (rate) {
>>>> -             case 0 ... 74999999:
>>>> +             case 1 ... 74999999:
>>>>                       ideal_rate = 50000000;
>>>>                       freqsel = PHYCTRL_FREQSEL_50M;
>>>>                       break;
>>>> @@ -127,25 +148,6 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>>>>       }
>>>>
>>>>       /*
>>>> -      * Keep phyctrl_pdb and phyctrl_endll low to allow
>>>> -      * initialization of CALIO state M/C DFFs
>>>> -      */
>>>> -     regmap_write(rk_phy->reg_base,
>>>> -                  rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>>>> -                  HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
>>>> -                                PHYCTRL_PDB_MASK,
>>>> -                                PHYCTRL_PDB_SHIFT));
>>>> -     regmap_write(rk_phy->reg_base,
>>>> -                  rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>>>> -                  HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
>>>> -                                PHYCTRL_ENDLL_MASK,
>>>> -                                PHYCTRL_ENDLL_SHIFT));
>>>> -
>>>> -     /* Already finish power_off above */
>>>> -     if (on_off == PHYCTRL_PDB_PWR_OFF)
>>>> -             return 0;
>>>> -
>>>> -     /*
>>>>        * According to the user manual, calpad calibration
>>>>        * cycle takes more than 2us without the minimal recommended
>>>>        * value, so we may need a little margin here
>>>> @@ -183,6 +185,19 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>>>>                    HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
>>>>                                  PHYCTRL_ENDLL_MASK,
>>>>                                  PHYCTRL_ENDLL_SHIFT));
>>>> +
>>>> +     /*
>>>> +      * We turned on the DLL even though the rate was 0 because we the
>>>> +      * clock might be turned on later.  ...but we can't wait for the DLL
>>>> +      * to lock when the rate is 0 because it will never lock with no
>>>> +      * input clock.
>>>> +      *
>>>> +      * Technically we should be checking the lock later when the clock
>>>> +      * is turned on, but for now we won't.
>>>> +      */
>>>> +     if (rate == 0)
>>>> +             return 0;
>>>
>>> Why not return initially from rockchip_emmc_phy_power if the clock rate is '0'.
>>> Are there other functions to lock the DLL apart from phy_power?
>>
>> Yeah, it's a big ugly right now.  This ugliness is really needed
>> because of <https://patchwork.kernel.org/patch/9201035/> because:
>>
>> 1. We power on the PHY at probe time and the card clock is in an
>> unknown state at that time.  It will be reported as 0 right now, but
>> it may or may not actually be 0.
>>
>> 2. We don't have an easy way to call back into the PHY when we
>> actually set the clock to a low rate (like 400kHz) for ID mode.
>> Before this series I tried to power the PHY off and on for every clock
>> change, but apparently that was causing problems.
>>
>>
>> As talked about in <https://patchwork.kernel.org/patch/9201035/>, I
>> think the right answer is to figure out how to get the common clock
>> framework notifications to happen for the card clock and then remove
>> the wholesale PHY power off / power on for every clock change.  The
>> PHY itself can register for the clock change notifications and figure
>> out how much or how little to do on every clock change.
>>
>> Unfortunately, as also discussed in the other patch, it's not trivial
>> to do this because I think it requires surgery on the main SDHCI
>> driver to change the way it deals with the card clock.  I'm not sure I
>> have time for this delicate surgery right now and I'm hoping that
>> perhaps Shawn will be able to help figure something out (maybe?) or I
>> can try coming back to it later.
>>
>>
>> In any case, I think a wholesale revert of my previous 150 MHz series
>> probably puts us in a worse state than we started with, so I was just
>> proposing reverting the one patch.  Once we do that, this PHY patch
>> helps keep us in a sane state (keeps suspend/resume working).
>>
>>
>> -Doug
> 
> Doug, Kishon,
> 
> Did you agree on how to move forward with this change?

I think still few things are not very clear especially on what should be
handled in PHY when the clock rate changes or if any new PHY APIs are required
to handle any clock changes etc..
But since this actually gets MMC working in rockchip, I'd be okay to merge this
now. Though I'd expect this to be refined in the future release cycles.

FWIW:
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
