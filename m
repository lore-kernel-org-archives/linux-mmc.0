From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Fri, 22 May 2015 14:51:56 +0200
Message-ID: <CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw@mail.gmail.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
	<1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFo5788uRqAaXUZ-OiS1XF8NPmg4tn2ipZNJdx4dci+KMQ@mail.gmail.com>
	<1432284000.23435.38.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36386 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536AbbEVMv5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 08:51:57 -0400
Received: by qget53 with SMTP id t53so7404165qge.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 05:51:56 -0700 (PDT)
In-Reply-To: <1432284000.23435.38.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek

[...]

>> You are invoking msdc_gate_clock() and msdc_ungate_clock() in a
>> balanced manner, thus hclk_enabled is redundant. Please remove it.
>
> on drv->probe(), already invoke the msdc_ungate_clock(), so, when the
> runtime pm resume invoke the msdc_ungate_clock(), the hclk already
> enabled.


That's why you invoke pm_runtime_set_active() during ->probe() when
deploying PM support in patch3. It's not an issue then.

[...]

>> I assume it's possible to gate the clock by updating a MSDC register
>> instead!? That would be prefereable since then you can leave clock
>> gating/ungating via the clk API, to be dealt from runtime PM. That
>> would also make "sclk_enabled" in the struct msdc_host redundant.
>>
>> Adopting to above, obviously requires MSDC to be able to ungate the
>> clock by also updating a MSDC register. I assume that's possible as
>> well!?
>>
> We can set the bit1 of MSDC_CFG, when this bit is 0, the bus clock was
> gated to 0 if no command or data is transmitted.
> And, from our designer, when we operate the MSDC register, we need make
> sure both HCLK and source are enabled, if source clock was disabled,
> write some MSDC registers will have no effect(eg. send CMD, without
> source clock, not only cannot send CMD, but also cannot get CMD timeout
> interrupt.)

Thanks, that answered my question. As I understand it you should be
able to adopt to my propsual.

[...]

>> > +{
>> > +       unsigned long tmo = jiffies + msecs_to_jiffies(20);
>> > +
>> > +       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
>> > +                       && time_before(jiffies, tmo))
>> > +               continue;
>> > +
>> > +       if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
>> > +               dev_err(host->dev, "CMD bus busy detected\n");
>> > +               host->error |= REQ_CMD_BUSY;
>> > +               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
>> > +               return false;
>> > +       }
>> > +
>> > +       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
>> > +               /* R1B or with data, should check SDCBUSY */
>> > +               while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
>> > +                       cpu_relax();
>> > +       }
>>
>> MSDC seems to be handling card busy detection in HW, right?
>>
> Do not have this ability, HW only know if CMD/DAT is low, but do not
> have any interrupt for it,

I see, but doesn't the above polling mean that msdc will not propagate
the response until the card have stopped signal busy? That's what
MMC_CAP_WAIT_WHILE_BUSY shall be used for.

Perhaps you should remove the above polling, and rely on the MMC core
to poll with CMD13 instead?

>> If so, you should enable MMC_CAP_WAIT_WHILE_BUSY and set
>> "max_busy_timeout" to DAT_TIMEOUT to inform the mmc core about it.
>>

[...]

Kind regards
Uffe
