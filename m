From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Mon, 17 Aug 2015 14:17:25 +0200
Message-ID: <CAMuHMdVksvUvrzuPH4WqLDxLzpxGDauWW2GYi=ayzyzGmN5R=g@mail.gmail.com>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
	<1539991.LpcThZV47z@wuerfel>
	<CAMuHMdWR0u9X36Dsw0QufmGO0phiY_w-tn1f-EmnL69FZ7NhMQ@mail.gmail.com>
	<2503249.0HMJqMtNHP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34789 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbbHQMR0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 08:17:26 -0400
In-Reply-To: <2503249.0HMJqMtNHP@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Arnd,

On Sat, Aug 15, 2015 at 10:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 August 2015 17:13:31 Geert Uytterhoeven wrote:
>> On Wed, Aug 12, 2015 at 4:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 11 August 2015 14:48:34 Geert Uytterhoeven wrote:
>> >>         dma_cap_mask_t mask;
>> >> @@ -413,12 +413,11 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
>> >>         dma_cap_set(DMA_SLAVE, mask);
>> >>
>> >>         if (pdata)
>> >> -               slave_data = direction == DMA_MEM_TO_DEV ?
>> >> -                       (void *)pdata->slave_id_tx :
>> >> -                       (void *)pdata->slave_id_rx;
>> >> +               slave_id = direction == DMA_MEM_TO_DEV ?
>> >> +                       pdata->slave_id_tx : pdata->slave_id_rx;
>> >>
>> >>         chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
>> >> -                               slave_data, dev,
>> >> +                               (void *)(uintptr_t)slave_id, dev,
>> >>                                 direction == DMA_MEM_TO_DEV ? "tx" : "rx");
>> >>
>> >>         dev_dbg(dev, "%s: %s: got channel %p\n", __func__,
>> >
>> > How about changing the type of the slave_id_rx/slave_id_tx fields
>> > to void*? That way, the hack can be moved to arch/sh/boards/board-sh7757lcr.c,
>> > which is now the only file passing data this way. Ideally, we'd also
>>
>> And to the other SH boards... This is not limited to the mmcif driver.
>>
>> Ah, I see tmio_mmc_data already does it this way.
>
> I probably made a similar comment there, now I just did 'git grep slave_id_.x'

:-)

>> This will break out-of-tree boards at compile-time though. Given the limited
>> number of wired up DMA channels under arch/sh/, they may actually be
>> more in use out-of-tree than in-tree?
>>
>> Alternatively, perhaps we should just drop pdata DMA configuration from
>> some drivers?
>
> I think that would be helpful, but it would not work for this driver as
> long as we keep arch/sh/boards/board-sh7757lcr.c in the kernel.

No, not for this driver.

But there are several drivers (spi-rspi, spi-sh-msiof, sh-sci, sh_flctl) that
have .slave*id* fields in platform data, but no platform code ever sets them.
Despite platform code that fills in SHDMA_SLAVE_* values in sh_dmae_chan.
These don't work anyway, and I don't think anyone is interested in fixing that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
