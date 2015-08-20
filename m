From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Thu, 20 Aug 2015 15:29:47 +0200
Message-ID: <1781695.TNL8ksnpjB@wuerfel>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be> <2503249.0HMJqMtNHP@wuerfel> <CAMuHMdVksvUvrzuPH4WqLDxLzpxGDauWW2GYi=ayzyzGmN5R=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVksvUvrzuPH4WqLDxLzpxGDauWW2GYi=ayzyzGmN5R=g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 17 August 2015 14:17:25 Geert Uytterhoeven wrote:
> >> This will break out-of-tree boards at compile-time though. Given the limited
> >> number of wired up DMA channels under arch/sh/, they may actually be
> >> more in use out-of-tree than in-tree?
> >>
> >> Alternatively, perhaps we should just drop pdata DMA configuration from
> >> some drivers?
> >
> > I think that would be helpful, but it would not work for this driver as
> > long as we keep arch/sh/boards/board-sh7757lcr.c in the kernel.
> 
> No, not for this driver.
> 
> But there are several drivers (spi-rspi, spi-sh-msiof, sh-sci, sh_flctl) that
> have .slave*id* fields in platform data, but no platform code ever sets them.
> Despite platform code that fills in SHDMA_SLAVE_* values in sh_dmae_chan.
> These don't work anyway, and I don't think anyone is interested in fixing that.

Right, removing pdata support for those would be a useful cleanup.

	Arnd
