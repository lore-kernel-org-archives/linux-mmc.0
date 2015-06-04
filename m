From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Thu, 4 Jun 2015 09:32:19 +0200
Message-ID: <CAPDyKFqH3jx9_uDPNY_+332DQ6_zROCPbPx=YaXbLN5qehno1g@mail.gmail.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
	<1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFo5788uRqAaXUZ-OiS1XF8NPmg4tn2ipZNJdx4dci+KMQ@mail.gmail.com>
	<1432284000.23435.38.camel@mhfsdcap03>
	<CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw@mail.gmail.com>
	<1432620991.647.6.camel@mhfsdcap03>
	<CAPDyKFrNQ6E4cU1_gK56ZNYgb=9EzHoJ=vXyraYoKNnRL=Umyg@mail.gmail.com>
	<1432726480.647.16.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36132 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbFDHcU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 03:32:20 -0400
Received: by qkx62 with SMTP id 62so19577731qkx.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 00:32:20 -0700 (PDT)
In-Reply-To: <1432726480.647.16.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek

On 27 May 2015 at 13:34, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Tue, 2015-05-26 at 14:33 +0200, Ulf Hansson wrote:
>> [...]
>>
>> >> >> > +{
>> >> >> > +       unsigned long tmo = jiffies + msecs_to_jiffies(20);
>> >> >> > +
>> >> >> > +       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
>> >> >> > +                       && time_before(jiffies, tmo))
>> >> >> > +               continue;
>> >> >> > +
>> >> >> > +       if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
>> >> >> > +               dev_err(host->dev, "CMD bus busy detected\n");
>> >> >> > +               host->error |= REQ_CMD_BUSY;
>> >> >> > +               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
>> >> >> > +               return false;
>> >> >> > +       }
>> >> >> > +
>> >> >> > +       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
>> >> >> > +               /* R1B or with data, should check SDCBUSY */
>> >> >> > +               while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
>> >> >> > +                       cpu_relax();
>> >> >> > +       }
>> >> >>
>> >> >> MSDC seems to be handling card busy detection in HW, right?
>> >> >>
>> >> > Do not have this ability, HW only know if CMD/DAT is low, but do not
>> >> > have any interrupt for it,
>> >>
>> >> I see, but doesn't the above polling mean that msdc will not propagate
>> >> the response until the card have stopped signal busy? That's what
>> >> MMC_CAP_WAIT_WHILE_BUSY shall be used for.
>> >>
>> > As you see, we only check the "busy state" BEFORE issue a R1B command or
>> > with data command, but do not check if AFTER the request was done, that
>> > would do not match the "MMC_CAP_WAIT_WHILE_BUSY"(eg. CMD5 to sleep)
>>
>> Okay, fair enough. Still, I don't understand why you want to do that?
>>
> Below is the description of these 2 bits:
> 1       CMDBSY  CMDBUSY SD Command line busy status
> S/W should always read this bit to make sure the command line is not
> busy before sending the next command.
> If the command is R1B or data read/write command, S/W should check
> SDCBUSY bit too.
> Note: When Auto command 12 is enabled, this bit will be asserted
> immediately after SDC_CMD is written and de-asserted after auto-command
> 12 finishes.
> 1'b0: No transmission is going on CMD line on SD bus
> 1'b1: There exists transmission going on CMD line on SD bus
> 0       SDCBSY  SDCBUSY SD controller busy status
> 1'b0: SD controller is idle
> 1'b1: SD controller is busy
>

Thanks, for elaborating. I get it know. :-)

>> > In addition, about CMD5, I find that the suspend/resume flow of EMMC is
>> > stranger in new kernel version, when suspend, it may issue CMD5 to enter
>> > sleep mode, then power off MMC, but when resume, it will
>> > re-initialization, So that why need do the redundant CMD5 in suspend ?
>>
>> Both CMD0 and CMD5 are valid as wakeup commands.
>>
>> To be able to use CMD5, the VCCQ regulator must be kept enabled in the
>> sleep state. That's when it becomes a bit tricky, due to the range of
>> different host drivers and SoCs for how VCCQ is managed.
>>
>> To be safe we have chosen to use CMD0, since it works for *all* cases
>> no matter if VCCQ get gated or not.
>>
>> Moreover, using CMD5 as the wakeup command would require added
>> complexity in the code dealing with suspend/resume. I don't think the
>> effort is worth it, at least until someone has proven that the resume
>> time is greatly decreased by using CMD5.
>>
>> >
>> >> Perhaps you should remove the above polling, and rely on the MMC core
>> >> to poll with CMD13 instead?
>> > before any read/write command, core will issue CMD13 to confirm card
>> > status, here is just only do double confirm to avoid HW issue.
>>
>> What HW issue and why do you need to double confirm? It seems strange.
> Some fake SD card, even the CMD13 get card status is in transfer state,
> but when we do read/write, the data0 was pull low.

Okay. So in this case your mmc host driver will take care of this. That's fine.

My concern is then how other mmc host drivers will deal with these
kind of cards that violates the spec. It would be nice if you could
add a card quirk for these cards, if you still recall what cards that
were causing these issues.

>
> By the way, do you think need do some spinlock protect in our code ?
> I cannot find a good reason to use spin lock, it seems no need
> it,although there will be many thread(mmcqd, mmcqd/0boot1,) and the irq
> handler.

>From mmc core layer point of view, you shouldn't be needing any spinlocks.

Whether your driver has a potential concurrent access of the same
registers, I don't know. If that's the case you probably want to
protect this from happening.

Kind regards
Uffe
