From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Mon, 17 Aug 2015 15:02:58 +0200
Message-ID: <CAMuHMdWdLXmfwE0qP50cj4d9N6tfTQWxpj9VZWDywJASMewFTw@mail.gmail.com>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
	<1539991.LpcThZV47z@wuerfel>
	<CAMuHMdWR0u9X36Dsw0QufmGO0phiY_w-tn1f-EmnL69FZ7NhMQ@mail.gmail.com>
	<2503249.0HMJqMtNHP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2503249.0HMJqMtNHP@wuerfel>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Sat, Aug 15, 2015 at 10:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > How about changing the type of the slave_id_rx/slave_id_tx fields
>> > to void*? That way, the hack can be moved to arch/sh/boards/board-sh7757lcr.c,
>> > which is now the only file passing data this way. Ideally, we'd also
>> > pass the shdma_chan_filter function pointer in pdata to avoid the link
>> > time dependency on a particular dmaengine driver.
>>
>> That's actually more tricky, as a NULL filter function means something
>> completely different, and causes funny failures if the DTS lacks "dmas"
>> properties, cfr. "dmaengine: shdma: Make dummy shdma_chan_filter() always
>> return false".
>> https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=next&id=056f6c87028544de934f27caf95aa1545d585767
>
> Ah, this is nasty, I had not thought of that case. This makes the entire
> dma_request_slave_channel_compat() interface (which I never liked, fwiw)
> dangerous to use, because a lot of other drivers will get the filter
> function pointer from pdata already (any driver that works with more
> than one dmaengine master has to).
>
> I wonder if we should enforce this in __dma_request_slave_channel_compat()
> by checking both the fn and fn_param arguments to ensure they are not
> NULL before calling the legacy fallback using __dma_request_channel.

Thanks, that seems to work fine. Will send a patch...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
