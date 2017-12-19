From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Tue, 19 Dec 2017 08:54:22 +0100
Message-ID: <CAPDyKFpZzUCF9Xn_c4oDJ=sF8UD+TaxL0vLtZqugcEbsmGCeDQ@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com> <CAK7LNASdJz9LpcCGQJjHU_CkxtXKhTbnRYA2Caq8Ck9OPLHghg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:41556 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938664AbdLSHyY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 02:54:24 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so1744218ita.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Dec 2017 23:54:24 -0800 (PST)
In-Reply-To: <CAK7LNASdJz9LpcCGQJjHU_CkxtXKhTbnRYA2Caq8Ck9OPLHghg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 19 December 2017 at 04:56, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Ulf,
>
>
> 2017-12-15 18:18 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 24 November 2017 at 17:24, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>>
>>> I am working on this IP for Socionext SoCs.
>>>
>>> I was hit by several issues, and noticed various
>>> clean-up candidates.
>>>
>>>  - Fix and clean-up Kconfig
>>>  - Fix various card detection problems
>>>  - Move Renesas private data out of TMIO core
>>>  - Allow to perform platform-specific settings before MMC host starts
>>>  - Fix weird IRQ handling
>>>
>>> I am getting more and more patches for TMIO.
>>> I put all in a single series to clarify the patch order.
>>>
>>> 1, 2, 4, 5, 6, 7 were already acked or reviewed by Wolfram Sang.
>>>
>>>
>>> Masahiro Yamada (22):
>>>   mmc: renesas_sdhi: consolidate DMAC CONFIG options
>>>   mmc: renesas_sdhi: remove wrong depends on to enable compile test
>>>   mmc: renesas_sdhi: remove eprobe jump label
>>>   mmc: tmio: set tmio_mmc_host to driver data
>>>   mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
>>>   mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
>>>   mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
>>>   mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
>>>   mmc: tmio: use mmc_can_gpio_cd() instead of checking
>>>     TMIO_MMC_USE_GPIO_CD
>>>   mmc: tmio: support IP-builtin card detection logic
>>>   mmc: renesas_sdhi: remove always false condition
>>>   mmc: tmio,renesas_sdhi: move struct tmio_mmc_dma to renesas_sdhi.h
>>>   mmc: tmio,renesas_sdhi: move Renesas-specific DMA data to
>>>     renesas_sdhi.h
>>>   mmc: tmio,renesas_sdhi: move ssc_tappos to renesas_sdhi.h
>>>   mmc: tmio: change bus_shift to unsigned int
>>>   mmc: tmio: fix never-detected card insertion bug
>>>   mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
>>>   mmc: tmio: remove useless TMIO_MASK_CMD handling in
>>>     tmio_mmc_host_probe()
>>>   mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
>>>   mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
>>>   mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
>>>   mmc: tmio: remove dma_ops from tmio_mmc_host_probe() argument
>>>
>>>  drivers/mmc/host/Kconfig                      |   5 +-
>>>  drivers/mmc/host/Makefile                     |   8 +-
>>>  drivers/mmc/host/renesas_sdhi.h               |  22 ++++
>>>  drivers/mmc/host/renesas_sdhi_core.c          |  49 ++++-----
>>>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  14 ++-
>>>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  35 +++---
>>>  drivers/mmc/host/tmio_mmc.c                   |  23 ++--
>>>  drivers/mmc/host/tmio_mmc.h                   |  23 +---
>>>  drivers/mmc/host/tmio_mmc_core.c              | 149 +++++++++++++-------------
>>>  9 files changed, 170 insertions(+), 158 deletions(-)
>>>
>>> --
>>> 2.7.4
>>>
>>
>> To get this moving, I have applied patch 1->8 for next, thanks!
>
>
> Could you apply 11->15 as well?
> They were reviewed by Wolfram.

Applied for next!

>
> We can skip 9, 10.

Okay, thought there were a dependency.

Thanks and kind regards
Uffe
