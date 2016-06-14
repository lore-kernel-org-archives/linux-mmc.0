From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 04/11] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
Date: Tue, 14 Jun 2016 08:59:15 +0800
Message-ID: <da1c9ae9-71d9-6e9d-7b9f-08485ee9178e@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-5-git-send-email-dianders@chromium.org>
 <f5dcc018-bd60-87a7-798b-efc261e443dd@rock-chips.com>
 <CAD=FV=UzGZmwGTthqqO5Skxj5f0wsS5VKr4gYP2i9SUyGqvbjg@mail.gmail.com>
 <47a2dcd9-9c3c-8fde-2be0-40e305c25e8d@rock-chips.com>
 <CAD=FV=UL5tU8RWtHF=-pE8SA0jUcBsqQDOU0BrruXOF7yGh5xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=UL5tU8RWtHF=-pE8SA0jUcBsqQDOU0BrruXOF7yGh5xg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/6/14 8:43, Doug Anderson =E5=86=99=E9=81=93:
> Hi,
>
> On Mon, Jun 13, 2016 at 5:14 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>=
 wrote:
>>>> It's broken when reading capabilities reg on RK3399 platform
>>>> which means you should get it via clk framework. But you should co=
nsider
>>>> the non-broken case.
>>>
>>>
>>> I'm afraid I don't understand.  Can you elaborate?  Are you saying =
if
>>> things weren't broken then we wouldn't have to ask the common clock
>>> framework for this?  Where would we get this value?
>>
>>
>>
>> I mean bascially we should get baseclk from capabilities register[15=
:8]
>> (offset 0x40@sdhci), namely EMMCCORE_CAP on TRM. Only when you get 0=
x0
>> from there, can you consider to get it from clock framework.
>
> Ah, got it!
>
> I guess I would be super surprised if an SoC implemented
> register[15:8] but still then required you to manually copy that valu=
e
> to corecfg_baseclkfreq.  Presumably nobody would be crazy enough to
> try to measure the clock rate in the SDHCI driver, so this would
> probably only be non-zero where the SDHCI clock is totally fixed.
> ...in that case probably the SoC designer would also put a default
> value in corecfg_baseclkfreq that matched (and maybe even make
> corecfg_baseclkfreq read-only?).

yes, you could see some others similar capabilities case like
timeoutclkfreq or preset value, etc. SDHCI hope Soc designer to
implement them within the controller but not mandatory.

>
> Even in the case that an SoC designer didn't put a value into
> corecfg_baseclkfreq that matched register[15:8], it seems very likely
> that the rate returned from the clk_get_rate() would match.
>
> I guess what I'm saying is that, to me, it seems like my patch isn't
> broken in any real systems.  If we ever find a system that needs this
> behavior in the future, we can add it.  Until then, it seems like my
> patch would be fine.  Do you agree?

I agree. But from the code itself, we should still use
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN to see if we could get
it from internal register in case of some platforms don't
provide the clk stuff.. Sounds sane? :)

>
> Note: right now we only provide a register map for rk3399, so
> certainly we can't be breaking any other SoCs with our current method=
=2E
>
>
>> I don't see a reason to check the return code here.  Specifically:
>>>
>>> * If this is a SoC where you don't need to write corecfg_baseclkfre=
q
>>> then we need do nothing about this error.
>>>
>>> * If the regmap write failed (which would be terribly unexpected fo=
r a
>>> memory mapped register) then we've already printed an error (in
>>> sdhci_arasan_syscon_write).  Best course of action seems to keep go=
ing
>>> and try anyway.
>>>
>>>
>>> I don't think a retry is likely to help anything.
>>
>>
>> Well, I saw you add a return value for sdhci_arasan_syscon_write, so
>> should we remove it?
>
> It was presuming that there might be future callers who might want to
> write other corecfg registers and might need to know whether the writ=
e
> worked or not.  Since having the return value doesn't hurt anything
> I'd rather leave it in.  If you really want me to remove it, though, =
I
> will.  Just let me know.

Ahh, it's trivial, so keep it if you want.

>
>
> -Doug
>
>
>


--=20
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
