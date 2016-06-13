From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 01/11] phy: rockchip-emmc: Increase lock time allowance
Date: Mon, 13 Jun 2016 16:07:13 -0700
Message-ID: <CAD=FV=X-318tAquybtdKz6Uqs0ZCMEzP5ZB9zrFUa8qSF8+_Eg@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-2-git-send-email-dianders@chromium.org> <3e19ff54-ee4a-c208-e137-1c0f8022f6b3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3e19ff54-ee4a-c208-e137-1c0f8022f6b3-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Shawn,

On Mon, Jun 13, 2016 at 12:58 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> On 2016/6/8 6:44, Douglas Anderson wrote:
>>
>> Previous PHY code waited a fixed amount of time for the DLL to lock at
>> power on time.  Unfortunately, the time for the DLL to lock is actually
>> a bit more dynamic and can be longer if the card clock is slower.
>>
>> Instead of waiting a fixed 30 us, let's now dynamically wait until the
>> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
>> the card clock is at the super slow 100 kHz.
>>
>
> mmc stack limit the min freq to 200k when initializing the card.

Are you certain?  In "drivers/mmc/core/core.c" I see:

static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };

In ID mode if 400kHz, 300kHz, 200kHz all fail then it will try 100kHz.


> So 5ms is enough, but it's ok to set the max timeout to 10ms as we
> can break out if locked.

Right, it's OK to error on the long side since it is really a pretty
serious error if the DLL doesn't lock and delaying tens of
milliseconds in this case is not a huge deal.


>> On its own, this change makes the PHY power on code a little more
>> robust.  Before this change the PHY was relying on the eMMC code to make
>> sure the PHY was only powered on when the card clock was set to at least
>> 50 MHz before, though this reliance wasn't documented anywhere.
>>
>> This change will be even more useful in future changes where we actually
>> need to be able to wait for a DLL lock at slower clock speeds.
>>
>> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  drivers/phy/phy-rockchip-emmc.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/phy/phy-rockchip-emmc.c
>> b/drivers/phy/phy-rockchip-emmc.c
>> index a69f53630e67..8336053aea5c 100644
>> --- a/drivers/phy/phy-rockchip-emmc.c
>> +++ b/drivers/phy/phy-rockchip-emmc.c
>> @@ -85,6 +85,7 @@ static int rockchip_emmc_phy_power(struct
>> rockchip_emmc_phy *rk_phy,
>>  {
>>         unsigned int caldone;
>>         unsigned int dllrdy;
>> +       unsigned long timeout;
>>
>>         /*
>>          * Keep phyctrl_pdb and phyctrl_endll low to allow
>> @@ -137,15 +138,25 @@ static int rockchip_emmc_phy_power(struct
>> rockchip_emmc_phy *rk_phy,
>>                                    PHYCTRL_ENDLL_MASK,
>>                                    PHYCTRL_ENDLL_SHIFT));
>>         /*
>> -        * After enable analog DLL circuits, we need an extra 10.2us
>> -        * for dll to be ready for work. But according to testing, we
>> -        * find some chips need more than 25us.
>> +        * After enabling analog DLL circuits docs say that we need 10.2
>> us if
>> +        * our source clock is at 50 MHz and that lock time scales
>> linearly
>> +        * with clock speed.  If we are powering on the PHY and the card
>> clock
>> +        * is super slow (like 100 kHZ) this could take as long as 5.1 ms.
>
>
> 5.1ms is by calculation or test?

By calculation.

>>> 10.2 us * (50000000 Hz / 100000 Hz)
5100.0 us, or 5.1 ms

I'll add clarification to the comment.


-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
