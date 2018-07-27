From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: tmio: allow DMA request hook to return error status
Date: Fri, 27 Jul 2018 17:05:19 +0900
Message-ID: <CAK7LNASVuNHXvyyf2_=4-QpxYosnRPCSOyicAs7WYtHfRLfkQw@mail.gmail.com>
References: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdXvbWrt44T4Sr_bDjS1YFfqZ82JHpH7f00FKYBHntyWSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXvbWrt44T4Sr_bDjS1YFfqZ82JHpH7f00FKYBHntyWSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert,

2018-07-27 16:51 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Fri, Jul 27, 2018 at 3:15 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> dma_request_chan() may return ERR_PTR(-EPROBE_DEFER), but
>> tmio_mmc_request_dma() cannot propagate it since it is a
>> void function.
>>
>> Change the return type to int so that the driver can retry
>> probing later in case the DMA-engine driver is probed after
>> the TMIO MMC driver.
>>
>> I moved the call for tmio_mmc_request_dma() up because it may
>> fail now.  I also removed unneeded clearing of host->chan_{tx,rx}
>> because (struct tmio_mmc_host) is allocated by kzalloc().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks for your patch!
>
> Isn't the idea to fall back to PIO if the DMA-engine driver is not found?
>
> Unfortunately there's no way to distinguish between "DMA-engine hasn't been
> probed yet" and "DMA-engine is not available" (e.g. CONFIG_RCAR_DMAC=n).
> In both cases, dma_request_chan() will return -EPROBE_DEFER.
> So if you treat this as an actual error, and propagate it, the following
> will happen:
>   - In case 1, the MMC driver will be reprobed successfully later.
>   - In case 2,the MMC driver will never succeed.
>
> Or am I missing something?


You are right.

drivers/Makefile lists 'dma/' before 'mmc/',
so this is not a real problem.

I will let my driver fallback to PIO for any error.

Thanks.




> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
