From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
Date: Sun, 12 Aug 2018 18:24:29 +0200
Message-ID: <20180812162428.GA888@kunai>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Yamada-san,

> Add UniPhier SD/eMMC controller support.
> 
> As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> The clock rate setting is platform-specific, and UniPhier variants
> will add another way.  I thought it would be better to split this
> to a hook to avoid a mess.

Thanks for this series! I see you did not base it on the renaming
patches. I think is a good decision because it would be a complicated
dependency. I had a glimpse on the patches and the new hook looks good
to me. I want to do full review and testing within the next two weeks.
Then, I can also comment about re-implementing the internal DMA core
handling vs. factorizing it out. It may be fine this way, I simply can't
tell now.

Regards,

   Wolfram

> 
> 
> 
> Masahiro Yamada (7):
>   mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
>   mmc: tmio: move tmio_mmc_set_clock() to platform hook
>   dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
>   mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
>   mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
>   mmc: renesas_sdhi: refactor CLK_CTL bit calculation
>   mmc: tmio: refactor CLK_CTL bit calculation
> 
>  .../devicetree/bindings/mmc/uniphier-sd.txt        |  60 ++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  10 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c               |  40 +-
>  drivers/mmc/host/tmio_mmc.c                        |  56 ++
>  drivers/mmc/host/tmio_mmc.h                        |   4 +-
>  drivers/mmc/host/tmio_mmc_core.c                   |  79 +--
>  drivers/mmc/host/uniphier-sd.c                     | 694 +++++++++++++++++++++
>  9 files changed, 869 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
>  create mode 100644 drivers/mmc/host/uniphier-sd.c
> 
> -- 
> 2.7.4
> 
