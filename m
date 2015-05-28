From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: sunxi: Also set SDXC_LOW_POWER_ON
Date: Thu, 28 May 2015 10:04:28 +0200
Message-ID: <5566CC0C.1050103@redhat.com>
References: <cover.1432491958.git.hramrach@gmail.com>	<29e003a6fb8253b1e103f341405d4e8322e3edc2.1432491958.git.hramrach@gmail.com>	<5562C90D.8070507@redhat.com> <CAPDyKFrvB1AZGdvQ1fb6ShC8v-3DbVabiki13L8gG7M2saJALA@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBEMYTOVQKGQEMY6G3RI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAPDyKFrvB1AZGdvQ1fb6ShC8v-3DbVabiki13L8gG7M2saJALA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 28-05-15 10:02, Ulf Hansson wrote:
> On 25 May 2015 at 09:02, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi,
>>
>> On 24-05-15 20:04, Michal Suchanek wrote:
>>>
>>> The function sunxi_mmc_oclk_onoff filters out the SDXC_LOW_POWER_ON flag
>>> but never sets it.
>>>
>>> Set SDXC_LOW_POWER_ON when oclk is disabled.
>>
>>
>> Nack, looking at the datasheet I do not thing this patch actually
>> does anything, according to the datasheet setting this bit to 1 results
>> in: "Turn off card clock when FSM in IDLE state", iow this does mmc clock
>> gating on idle automatically in hardware, since we completely disable the
>> clock on clock-off by clearing SDXC_CARD_CLOCK_ON setting this bit on
>> clock-off is a nop.
>>
>> We could consider actually setting this to safe power when setting the clock
>> on, for doing that it would be good to look at the android code and see if
>> it ever sets this bit and if so when.
>>
>> WRT CONFIG_MMC_CLKGATE we are probably better off using SDXC_LOW_POWER_ON
>> then that when it is enabled. So maybe we should set SDXC_LOW_POWER_ON
>> based on #ifdef WRT CONFIG_MMC_CLKGATE, and have some way to tell the
>> mmc core to not do clock gating on this host ?
>
> I am planning to remove the entire thing for CONFIG_MMC_CLKGATE, maybe
> it's time to do that now!?

Removing it now sounds like a good plan to me, we would still need
to look into maybe enabling SDXC_LOW_POWER_ON on sunxi in some cases
to save power, but that is an orthogonal problem.

Regards,

Hans
