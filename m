From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: add complete to DMA ops
Date: Fri, 16 Jun 2017 12:09:30 +0200
Message-ID: <CAMuHMdXy=TLeW+kSBBAnu73oNYaVK-xybpPwr__=syAdHaFygQ@mail.gmail.com>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUkhkDEqsDZUQ94dFnLU+dFcZ+ed=qHokH3sEWGFdkkuw@mail.gmail.com>
 <20170616060602.GA16534@verge.net.au> <CAMuHMdV58Gp+M3eDG3wmgcG6S7L=HBoeFY3gNPVAA1HBWATOcw@mail.gmail.com>
 <20170616070432.GC16534@verge.net.au> <CAMuHMdVpE+2QK2WbfyDCCUq1fzHqnuyAKsGgzj+ZonOwc96w3A@mail.gmail.com>
 <20170616071354.GE16534@verge.net.au> <CAMuHMdXP8HXxQWfFf=i3j98q529doO7dpfgLBqhZPHeyYzNo_w@mail.gmail.com>
 <20170616073330.GG22158@verge.net.au> <20170616100314.GD6032@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170616100314.GD6032@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Fri, Jun 16, 2017 at 12:03 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 16, 2017 at 09:33:31AM +0200, Simon Horman wrote:
>> On Fri, Jun 16, 2017 at 09:23:15AM +0200, Geert Uytterhoeven wrote:
>> > Hi Simon,
>> >
>> > On Fri, Jun 16, 2017 at 9:13 AM, Simon Horman <horms@verge.net.au> wrote:
>> > > Sorry for letting this bug creep in to renesas-drivers.
>> > > Do you want a patch against your tree? I will plan to post v2 of
>> > > this patchset soon in any case.
>> >
>> > You can post such a patch to please users of renesas-drivers, but I won't
>> > apply it now. I assume the issue will be fixed when next renesas-drivers
>> > release is created ;-)
>>
>> That is my assumption too :)
>
> Revised patches posted as "[PATCH mmc/next v2 0/4] mmc: renesas_sdhi: add
> support for R-Car Gen3 SDHI DMAC"

Thanks!

> Pushed to topic/sdhi-gen3-dma-2017-v2 in my renesas tree.
> Do you need a fresh pull request?

Not needed, I already updated my list of topics to merge.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
