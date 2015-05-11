From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Mon, 11 May 2015 12:29:42 +0200
Message-ID: <CAPDyKFqeAzjpbZsyfcwb_WarC=dzoCsEeLTmxAbtvOo3Y4cYyg@mail.gmail.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
	<1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
	<1430895299.15154.9.camel@mhfsdcap03>
	<CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
	<1430962956.15154.48.camel@mhfsdcap03>
	<CAPDyKFr5N_08HbLuY=4Wfv1BoVQLVR-VW+NKh_umL1hzi_KozA@mail.gmail.com>
	<1431335885.26820.7.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1431335885.26820.7.camel@mhfsdcap03>
Sender: linux-gpio-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek
List-Id: linux-mmc@vger.kernel.org

On 11 May 2015 at 11:18, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Fri, 2015-05-08 at 14:12 +0200, Ulf Hansson wrote:
>> On 7 May 2015 at 03:42, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> > Dear Ulf,
>> >
>> > Thanks!
>> > Below is my comment:
>> >
>> > On Wed, 2015-05-06 at 18:31 +0200, Ulf Hansson wrote:
>> >> On 6 May 2015 at 08:54, chaotian.jing <chaotian.jing@mediatek.com> wrote:
>> >> > Dear Ulf,
>> >> >
>> >> > Thanks for your review.
>> >> > I must do a explain of our MMC host:
>> >> > Source clock is source clock of the MMC bus, MMC host has a divider to
>> >> > get different bus clock frequency. now the runtime suspend is gating
>> >> > this clock.
>> >> >
>> >> > Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
>> >> > cannot work(all registers readout is zero). and, all registers would be
>> >> > reset to default value if Hclk is gated/ungated.
>> >> > At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
>> >> > was controlled by "Infra module".
>> > Sorry for mistake, MSDC0 and MSDC3 has independent Hclk, MSDC1 and
>> > MSDC2's Hclk was controlled by "Infra module". the Infra module is a
>> > "power saving module", when the system go to sleep, Infra module will be
>> > set and MSDC1 & MSDC2's Hclk will be gated automatically.
>> >>
>> >> Thanks for clarifying!
>> >>
>> >> I don't have enough knowledge about your SoC to understand the detail,
>> >> but it seems like we are mixing clocks and power domains. I would
>> >> rather keep this separate - if the HW allows it.
>> >>
>> >> I guess the key question I have is the following:
>> >> 1) Is it hardware wise possible to gate the hclk, but without gating
>> >> the power domain?
>> >> 2) At what level is the reference counting done for each device in the
>> >> power domain? In HW or in sofftware?
>> >>
>> >
>> > Actually, Our MMC host do not have power domain, all the control of the
>> > host is the Hclk.
>>
>> Okay, but I am not sure that fully answered my question.
>>
>> You said that hclk will be gated when the power domain gets gated. And
>> the power domain (infra module, right?) will be gated at system PM
>> sleep. And when that happens the mmc controller loses register
>> context.
>>
>> But, again, can hclk be gated without gating the power domain?
>>
>> No matter what, it seems like a good idea to gate the power domain
>> when all clients of it are idle. Yes we would need to manage register
>> save/restore context, but on the other hand allow you to save more
>> power, right?
>>
> For MSDC0 & MSDC3, it has independent HCLK, do not have power domain.
> For MSDC1 & MSDC2, its HCLK was controlled by Infra module(This is a big
> power domain for many modules).
> So, for msdc0 & msdc3, we can control its Hclk, for msdc1 & msdc2, we
> cannot control it.

Okay, thanks for the clarification!

>
> Yes, I will do gate/ungate HCLK & source clock in PM.
> In addition, Since the gate/ungate HCLK is done by runtime PM, and all
> register operation should work at HCLK is on, so the msdc_init_hw() only
> can be called at set_ios(), because in probe(), the HCLK may have not
> been enabled.

I suggest you to enable HCLK in ->probe() and thus you may also call
msdc_init_hw() from there.

This should simplify for you, when adding the runtime PM support.

Kind regards
Uffe
