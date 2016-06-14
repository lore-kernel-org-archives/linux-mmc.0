From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 09/11] phy: rockchip-emmc: Set phyctrl_frqsel based on
 card clock
Date: Mon, 13 Jun 2016 17:45:57 -0700
Message-ID: <CAD=FV=VN-sNSjkZp_BTEn=uCdOmdTLk7+5AvF8U+7j908Ynycw@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-10-git-send-email-dianders@chromium.org> <937cbbc5-f9dc-bdf0-c46a-c7e814b9b373@rock-chips.com>
 <CAD=FV=VA6vmfzHEOZwAFJvNXRDhPmf+bX-Jw1eFboOdP6kD3dg@mail.gmail.com> <036b0349-8343-f5de-7215-5a0843ebc6a9@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <036b0349-8343-f5de-7215-5a0843ebc6a9-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Shawn,

On Mon, Jun 13, 2016 at 5:24 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>>> From the public Arasan datasheet they seem to indicate +/- 15 MHz is
>>
>> sane.  Does that sound OK?  Presuming that all of your numbers
>> (50/100/150/200) are centers, that means that we could support clock
>> rates of:
>>
>> 35 MHz - 65 MHz
>> 85 MHz - 115 MHz
>> 135 MHz - 165 MHz
>> 185 MHz - 200 MHz
>>
>>
>> So how about if we add a warning for things that are outside of those
>> ranges?  ...except no warning for < 35 MHz since presumably we're not
>> using high speed modes when the DLL is that slow and so we're OK.
>
>
> a warning should be ok.
> If we ask 150M, but PLL only provide 175M maybe, then should we
> fallback it to 150M or promote it to 200M when setting?

I made it a warning in V2 but still picked the closest reasonable
value.  See what you think.  The PHY really isn't in control of this
clock, so the warning is the best it can do.  Presumably someone
designing a system with this PHY in it would see the warning an
realize that they should make SDHCI run at more reasonable rates...

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
