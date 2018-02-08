From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 14/16] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP}
 handling to correct place
Date: Thu, 8 Feb 2018 10:11:09 +0900
Message-ID: <CAK7LNAQwXADUhscdp=C7c-2VfZmrj9kThc0o6JN4JDvcBSdCEw@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com> <20180207214707.6d32d27towuofyyu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207214707.6d32d27towuofyyu@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2018-02-08 6:47 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jan 18, 2018 at 01:28:14AM +0900, Masahiro Yamada wrote:
>> As far as I tested the IP on UniPhier SoCs, TMIO_STAT_{RXRDY,TXRQ}
>> are asserted for DMA mode as well as for PIO.  I need to disable the
>> those IRQs in dma_ops->start hook, otherwise the DMA transfer fails
>> with the following error message:
>>   PIO IRQ in DMA mode!
>>
>> Renesas chips are the same cases since I see their dma_ops->start
>> hooks explicitly clear TMIO_STAT_{RXRDY,TXRQ} (with nice comment!).
>>
>> If we do this sanity check in TMIO MMC core, RXRDY/TXRQ handling
>> should be entirely moved to the core.  tmio_mmc_cmd_irq() will
>> be a suitable place to disable them.
>>
>> The probe function sets TMIO_MASK_{READOP,WRITEOP} but this is odd.
>>
>>     /* Unmask the IRQs we want to know about */
>>     if (!_host->chan_rx)
>>             irq_mask |= TMIO_MASK_READOP;
>>     if (!_host->chan_tx)
>>             irq_mask |= TMIO_MASK_WRITEOP;
>>
>> At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
>> tmio_mmc_request_dma() is called after this code.  Consequently,
>> TMIO_MASK_{READOP,WRITEOP} are set here whether DMA is used or not.
>> Remove this pointless code.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I need to stop reviewing here because I'd need the applied version for
> checking. I hope Ulf can give me a base tomorrow.
>
> Or Yamada-san, do you meanwhile have a git repo somewhere?
>

Patch 1-6 were pulled merged in this MW.

Patch 7-16 are cleanly applicable onto Linus' tree.
(commit 581e400ff935d34 as of writing)



-- 
Best Regards
Masahiro Yamada
