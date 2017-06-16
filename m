From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/5] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Fri, 16 Jun 2017 09:21:04 +0200
Message-ID: <CAMuHMdWE6pq3XUKq3U2sTDMsjqkk7gYsjyuEskQ_+e+J3vvKWg@mail.gmail.com>
References: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
 <1496927595-19521-5-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdU8fqoi-zh4OKC_40xH3pZy+w_qDjtxm2pRLUsJieFmgw@mail.gmail.com> <20170616071201.GD16534@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170616071201.GD16534@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Fri, Jun 16, 2017 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 09, 2017 at 09:39:49AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Jun 8, 2017 at 3:13 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> > R-Car Gen3 has a dedicated DMA controller for SDHI module. Since
>> > the DMAC is in a part of SDHI module and is not suitable as dmaengine,

>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig

>> > +config MMC_SDHI_SYS_DMAC
>> > +       tristate "DMA support use of SYS DMAC with SDHI SD/SDIO controller"
>>
>> DMA support for SYS_DMAC?
>
> How about this?
>
> config MMC_SDHI_SYS_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"

Better!

>         ...
>         help
>            This provides DMA support for the SDHI SD/SDIO controllers
>            using SYS-DMAC via DMA Engine. This supports the controllers

I would drop "the".

>            found in SuperH and Renesas ARM based SoCs.
>
> config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
>         ...
>         help
>            This provides DMA support for the SDHI SD/SDIO controllers
>            using on-chip bus mastering. This supports the controllers

Likewise.

>            found in arm64 based SoCs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
