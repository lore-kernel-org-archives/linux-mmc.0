From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/21] mmc: core: A start to slim down public mmc headers
Date: Tue, 10 Jan 2017 16:37:59 +0100
Message-ID: <CAPDyKFpa48L6VKHrrkfmyDZDzeeHXMtXbi-_3xS0EyX0MthRow@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35439 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754049AbdAJPiD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:38:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id a197so131836832wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:38:02 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 30 December 2016 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Ideally we should not expose functions nor structures as being public available
> as the interface for mmc - unless they really are intended to be used like that.
>
> Unfortunate this is not the case today and which has lead to the mmc interface
> in some cases being abused. That of course has its own problems, but we can
> still move things in the right direction, which is what this series intend to
> do. More precisely, it moves things that can be easily moved from the public mmc
> headers to the private mmc headers.
>
> This should be considered as a first step of improving the situation, further
> additional changes will have to continue this path.
>
>
> Ulf Hansson (21):
>   sh: sh7724: Don't use a public mmc header for MMC_PROGRESS*
>   mmc: Removed the unused public mmc boot.h header
>   mmc: sh_mmcif: Remove unused use_cd_gpio/cd_gpio from platform data
>   mmc: sh_mmcif: Remove unused ->get_cd() platform callback
>   mmc: sh_mmcif: Remove unused ccs_unsupported from the platform data
>   mmc: sh_mmcif: Remove unused clk_ctrl2_present from the platform data
>   mmc: dw_mmc: Remove the public dw_mmc header file
>   mmc: sdhci-cadence: Include mmc.h
>   mmc: sdhci: Include leds.h
>   mmc: host: Include interrupt.h in mmc host drivers that depends on it
>   mmc: core: First step in cleaning up public mmc header files
>   mmc: core: First step in cleaning up private mmc header files
>   mmc: core: Move public functions from core.h to private headers
>   mmc: core: Move some host specific public functions to host.h
>   mmc: core: Move erase/trim/discard defines from public core.h to mmc.h
>   mmc: core: Remove unused struct _mmc_csd from public mmc.h header
>   mmc: omap: Don't use mmc_card_present() when validating for inserted
>     card
>   mmc: vub300: Don't use mmc_card_present() when validating for inserted
>     card
>   mmc: core: Move public functions from card.h to private headers
>   mmc: core: Move public functions from host.h to private headers
>   mmc: core: Don't use extern declarations of public mmc functions
>
>  MAINTAINERS                          |   1 -
>  arch/sh/boot/romimage/mmcif-sh7724.c |  16 +-
>  drivers/mmc/core/block.c             |   6 +
>  drivers/mmc/core/block.h             |   8 +
>  drivers/mmc/core/bus.c               |   2 +
>  drivers/mmc/core/bus.h               |  16 +-
>  drivers/mmc/core/card.h              | 223 ++++++++++++++++++++++++++++
>  drivers/mmc/core/core.c              |   1 +
>  drivers/mmc/core/core.h              |  41 +++++-
>  drivers/mmc/core/debugfs.c           |   2 +
>  drivers/mmc/core/host.h              |  48 ++++++
>  drivers/mmc/core/mmc.c               |  13 ++
>  drivers/mmc/core/mmc_ops.h           |  14 ++
>  drivers/mmc/core/mmc_test.c          |   5 +
>  drivers/mmc/core/pwrseq.h            |   6 +-
>  drivers/mmc/core/queue.c             |   2 +
>  drivers/mmc/core/queue.h             |   6 +-
>  drivers/mmc/core/quirks.c            |   2 +
>  drivers/mmc/core/sd.c                |   2 +
>  drivers/mmc/core/sd.h                |   5 +-
>  drivers/mmc/core/sd_ops.h            |   9 ++
>  drivers/mmc/core/sdio.c              |   2 +
>  drivers/mmc/core/sdio_bus.c          |   1 +
>  drivers/mmc/core/sdio_bus.h          |   3 +
>  drivers/mmc/core/sdio_cis.h          |   3 +
>  drivers/mmc/core/sdio_io.c           |   2 +
>  drivers/mmc/core/sdio_irq.c          |   2 +
>  drivers/mmc/core/sdio_ops.h          |   5 +
>  drivers/mmc/core/slot-gpio.h         |   2 +
>  drivers/mmc/host/davinci_mmc.c       |   1 +
>  drivers/mmc/host/dw_mmc-exynos.c     |   1 -
>  drivers/mmc/host/dw_mmc-k3.c         |   1 -
>  drivers/mmc/host/dw_mmc-pci.c        |   1 -
>  drivers/mmc/host/dw_mmc-pltfm.c      |   1 -
>  drivers/mmc/host/dw_mmc-rockchip.c   |   1 -
>  drivers/mmc/host/dw_mmc.c            |   1 -
>  drivers/mmc/host/dw_mmc.h            | 258 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/meson-gx-mmc.c      |   1 +
>  drivers/mmc/host/mtk-sd.c            |   1 +
>  drivers/mmc/host/omap.c              |   2 +-
>  drivers/mmc/host/sdhci-cadence.c     |   1 +
>  drivers/mmc/host/sdhci.h             |   2 +
>  drivers/mmc/host/sh_mmcif.c          |  28 +---
>  drivers/mmc/host/tmio_mmc.h          |   1 +
>  drivers/mmc/host/via-sdmmc.c         |   1 +
>  drivers/mmc/host/vub300.c            |   6 +-
>  drivers/mmc/host/wmt-sdmmc.c         |   1 +
>  include/linux/mmc/boot.h             |   7 -
>  include/linux/mmc/card.h             | 242 -------------------------------
>  include/linux/mmc/core.h             |  86 ++---------
>  include/linux/mmc/dw_mmc.h           | 274 -----------------------------------
>  include/linux/mmc/host.h             |  63 ++------
>  include/linux/mmc/mmc.h              |  59 ++------
>  include/linux/mmc/sh_mmcif.h         |   5 -
>  include/linux/mmc/slot-gpio.h        |   3 +
>  55 files changed, 747 insertions(+), 749 deletions(-)
>  create mode 100644 drivers/mmc/core/card.h
>  delete mode 100644 include/linux/mmc/boot.h
>  delete mode 100644 include/linux/mmc/dw_mmc.h
>
> --
> 1.9.1
>

Patch 1->10 applied for next. Thanks all reviewers!

I will fix the build issues reported for patch 11 and re-spin the series asap.

Kind regards
Uffe
