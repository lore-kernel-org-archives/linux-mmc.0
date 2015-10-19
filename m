From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Mon, 19 Oct 2015 12:54:17 +0200
Message-ID: <CAPDyKFqyXNUS2GwPjVWpoiPxOLNJ3T=FgDLO2NT+pEBGYMR1eQ@mail.gmail.com>
References: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
	<CAPDyKFpwgZSkE+TNehZ1Un=5CfjoEtfvELfrS6t-ZHZPscy3Yg@mail.gmail.com>
	<56243E85.2040202@rock-chips.com>
	<CAPDyKFpkH00roc=Nn067PufmQL59wqsi1c58tdv_UyP-7Gs-vg@mail.gmail.com>
	<5624AC51.9060907@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5624AC51.9060907-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, S?ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>>
>>>>
>>>>> +               ret = phy_power_on(sdhci_arasan->phy);
>>>>
>>>>
>>>>
>>>> This looks a bit weird. Shouldn't you do phy_init() prior
>>>> phy_power_on()?
>>>>
>>>> Similar comment applies to phy_exit() and phy_power_off().
>>>
>>>
>>>
>>> Both are okay. It depends how the phy-driver implement the four
>>> interfaces.
>>>  From my case, power_on for arasan's phy driver firstly enable phy's clk
>>> and
>>> open power-domain, then programme phy internal registers to activate phy.
>>> Without enabling phy's clk and power-domain, we cannot do phy_init since
>>> phy
>>> can't be accessed by CPU.
>>>
>>> But here, I think you are right. It does look a bit weird.
>>> I think the better way is to remove phy_power_on here, and let phy-driver
>>> do
>>> power_on in phy_init internally. Similarly in the remove call.
>>
>>
>> That makes sense to me! I think it would also follow other phy clients
>> use of the phy API.
>>
>> What makes me wonder though is from a power management point of view.
>> *When* do you need to have phy initialized and powered?
>>
>
> Whenever controller need to communicate with card, must init/power_on phy
> firstly.
>
>> 1) For a removable card can leave the phy uninitialised or powered
>> off, but still detect card insertion/removal via GPIO? Is that a valid
>> scenario for you?
>>
>
> Theoretically, it is.  Although my soc don't use phy for removable card, I
> also consider how to handle this case. Should we add a hook
> for sdhci_get_cd, and initialize phy if it's non-removeable device or
> removeable card in slot ? Doesn't seem like a good idea.
>
> Also seems not always work if we just use SDHCI_PRESENT_STATE to detect card
> insertion/removal without phy in active state.

As you SoC don't use removable card, let's just leave this for now.
Thanks for sharing your thoughts.

>
>> 2) Considering the runtime PM case for the sdhci device. Typically you
>> can gate clocks etc at runtime suspend to save power, but what about
>> the phy? Can you power off it in runtime suspend?
>
>
> yes, we can power off it in runtime suspend. So we can append some patches
> later to introduce runtime pm for sdhci-of-arasan?

Yes, that's fine. I would thus expect that you want to do phy power
off/on from the runtime PM callbacks, right!?

If that's the case I think $subject patch should deal with *both* phy
init and phy power on during ->probe().

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
