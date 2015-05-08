From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Fri, 8 May 2015 14:12:59 +0200
Message-ID: <CAPDyKFr5N_08HbLuY=4Wfv1BoVQLVR-VW+NKh_umL1hzi_KozA@mail.gmail.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
	<1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
	<1430895299.15154.9.camel@mhfsdcap03>
	<CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
	<1430962956.15154.48.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430962956.15154.48.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek
List-Id: linux-mmc@vger.kernel.org

On 7 May 2015 at 03:42, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Dear Ulf,
>
> Thanks!
> Below is my comment:
>
> On Wed, 2015-05-06 at 18:31 +0200, Ulf Hansson wrote:
>> On 6 May 2015 at 08:54, chaotian.jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>> > Dear Ulf,
>> >
>> > Thanks for your review.
>> > I must do a explain of our MMC host:
>> > Source clock is source clock of the MMC bus, MMC host has a divider to
>> > get different bus clock frequency. now the runtime suspend is gating
>> > this clock.
>> >
>> > Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
>> > cannot work(all registers readout is zero). and, all registers would be
>> > reset to default value if Hclk is gated/ungated.
>> > At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
>> > was controlled by "Infra module".
> Sorry for mistake, MSDC0 and MSDC3 has independent Hclk, MSDC1 and
> MSDC2's Hclk was controlled by "Infra module". the Infra module is a
> "power saving module", when the system go to sleep, Infra module will be
> set and MSDC1 & MSDC2's Hclk will be gated automatically.
>>
>> Thanks for clarifying!
>>
>> I don't have enough knowledge about your SoC to understand the detail,
>> but it seems like we are mixing clocks and power domains. I would
>> rather keep this separate - if the HW allows it.
>>
>> I guess the key question I have is the following:
>> 1) Is it hardware wise possible to gate the hclk, but without gating
>> the power domain?
>> 2) At what level is the reference counting done for each device in the
>> power domain? In HW or in sofftware?
>>
>
> Actually, Our MMC host do not have power domain, all the control of the
> host is the Hclk.

Okay, but I am not sure that fully answered my question.

You said that hclk will be gated when the power domain gets gated. And
the power domain (infra module, right?) will be gated at system PM
sleep. And when that happens the mmc controller loses register
context.

But, again, can hclk be gated without gating the power domain?

No matter what, it seems like a good idea to gate the power domain
when all clients of it are idle. Yes we would need to manage register
save/restore context, but on the other hand allow you to save more
power, right?

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
