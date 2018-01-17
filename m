From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 17/22] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP}
 handling to correct place
Date: Thu, 18 Jan 2018 01:45:25 +0900
Message-ID: <CAK7LNATB9+S9AKS-NUNCrmG=4VZ8dSjAcZqGWMX5CApN_+sQJg@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-18-git-send-email-yamada.masahiro@socionext.com> <20180116080101.264qbj5inn76abom@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116080101.264qbj5inn76abom@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,


2018-01-16 17:01 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Sat, Nov 25, 2017 at 01:24:52AM +0900, Masahiro Yamada wrote:
>> This driver was largely extended by Renesas, but actually used by
>> several SoC vendors.  The current code does not work for UniPhier
>> SoCs at least.
>
> Do you insist on this paragraph? All people working on the code so far
> tried hard to make it work on all devices they had access to. So far, I
> can't recall one of the several SoC vendors contacting upstream to get
> their support merged (until now, of course) or even to file bugs.
> Because I can't guess unknown stuff, I'd prefer to skip this paragraph.

I dropped this in v3.



>> The DMA mode for UniPhier SoCs failed with the following error message:
>>   PIO IRQ in DMA mode!
>>
>> For UniPhier SoCs, the TMIO_MASK_{READOP,WRITEOP} are asserted in the
>> DMA mode as well.
>
> Sure, that we need to fix! Note that both Renesas DMA drivers also
> enable DATAEND and disable RXRDY | TXRQ on their own, too. So, probably
> the same issue? And IIUC we can decide now to prepare the irqs like this
> in tmio_core because all known DMA engines need it. Or we keep it that
> DMA engines set up irqs themselves. More flexible but maybe
> over-engineered?

OK, I cleaned up RXRDY | TXRQ in renesas drivers, too.

It is probably possible to cleanup DATAEND,
but I did not touch it for now.

As you may know, the original IP from Panasonic
did not support internal DMAC.

Renesas extended the IP by itself for the internal DMAC.

Panasonic did so in a different way.  So, the DMA engine HW
is completely different, and the current core is not
flexible enough for UniPhier SoCs because
our DMA engines added own interrupt masks.

I will consider how to handle it later,
but I do not see a reason to do it in this series.


>> In fact, the code is very strange.
>
> Yes.
>
>> The TMIO_MASK_{READOP,WRITEOP} IRQs are set as follows:
>>
>>     /* Unmask the IRQs we want to know about */
>>     if (!_host->chan_rx)
>>             irq_mask |= TMIO_MASK_READOP;
>>     if (!_host->chan_tx)
>>             irq_mask |= TMIO_MASK_WRITEOP;
>>
>> At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
>> tmio_mmc_request_dma() is called after this code.  Consequently,
>> TMIO_MASK_{READOP,WRITEOP} are set whether DMA is used or not.
>
> Yes :( Bummer.
>
>> tmio_mmc_cmd_irq() enables TMIO_MASK_{READOP,WRITEOP}, but never
>> disables them.  This does not take care of a case where ->force_pio
>> is set, but unset later.
>
> force_pio gets disabled within the same request? I may be overlooking
> something but I only see code paths where force_pio gets cleared and a
> little later the request gets finished. Can you give me a pointer?

I cleaned up force_pio, but in a separate patch
because it is just loosely related.


>> After all, the correct place to handle those flags is just before
>> starting the data transfer.
>
> While I totally agree the code below can be improved for sure, I'd
> prefer to keep the design pattern that irqs get disabled once they are
> not actively used. Generally spoken, I think it makes sense to keep
> regressions on old platforms low. Any chance this can be achieved?
> Other than that, fixing/removing this irq_mask handling from probe() is
> really good.
>

I could not understand this suggestion.
Please let me know if v3 is still a problem.



-- 
Best Regards
Masahiro Yamada
