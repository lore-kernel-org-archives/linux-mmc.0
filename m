From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
Date: Thu, 26 Jul 2018 18:14:32 +0900
Message-ID: <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert,


2018-07-26 17:25 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Thu, Jul 26, 2018 at 5:33 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
>> MFD glue") said, these MMC controllers use the IP from Panasonic.
>>
>> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
>> The common driver code was split and expanded as 'tmio-mmc-core', then
>> it become historical misnomer since 'tmio' is not the name of this IP.
>>
>> I pointed out this [1], and suggested to re-organize the names in the
>> form of:
>>
>>   <IP-name>.c            (common code for this IP)
>>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>>   <IP-name>_sdhi.c       (Renesas SDHI)
>>   <IP-name>_uniphier.c   (Socionext UniPhier)
>>
>> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
>> are prefixed with 'MN'.
>>
>> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>>
>> In the discussion with Wolfram Sang, my suggestion was rejected
>> because it implied drastic function renaming, which is too invasive.
>>
>> Ulf Hansson was still happy with file renaming to clarify the
>> relationship between variants.  So, the accepted solution was:
>>
>>  - Make 'tmio_mmc' the _right_ core name
>>  - Align all variant files with the same prefix.
>>  - Do not rename functions
>>
>> This commit renames files as follows:
>>
>>   tmio_mmc_core.c              -> tmio_mmc.c
>>   tmio_mmc.c                   -> tmio_mmc_original.c
>>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>
> I have mixed feelings about the last two renames, especially about the last
> one: SYS-DMAC is very Renesas-specific, as it's a separate IP block in
> Renesas SoCs.
> 1. Are there other SoCs using the same internal DMAC?

Probably no.

The original IP from Panasonic did not contain any internal DMA engine.

renesas_sdhi_internal_dmac.c is probably
the Resansas' own extension.


Panasonic also implemented a different internal DMA engine
(Socionext inherited the RTL from Panasonic).

This is completely different from the Renesas' implementation.



>    If not, perhaps the "renesas" should be kept in the driver name?


I do not mind that, but the file name would be very long
"tmio_mmc_renesas_sdhi_internal_dmac.c"

Or, do you mean "tmio_mmc_renesas_internal_dmac.c" ?



> 2. Are there other SoCs using an external DMAC?


Yes.  Some old SoCs in UniPhier SoC family rely on
the external DMAC, like renesas_sdhi_sys_dmac.c


>    Is the interface to the external DMAC similar?
>    If yes, perhaps it should be renamed to tmio_mmc_sdhi_external_dmac.c?


"sdhi" is already Renesas-specific name, isn't it?

I really do not care, "sys" or "external"
It is up to renesas folks .


>    If not, perhaps the "renesas" should be kept in the driver name?


I am not quite sure, but this is less Renesas-specific
since renesas_sdhi_sys_dmac.c is just a software abstraction layer.
The real driver code is under drivers/dma/.

The difference is, in my case, TX and RX share a single DMA channel.


Thanks.



> Thanks!
>
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
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
