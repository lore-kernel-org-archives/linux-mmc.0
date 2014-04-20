From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/6] update selection of bus speed mode for eMMC
Date: Sun, 20 Apr 2014 09:18:45 +0200
Message-ID: <CAPDyKFpHasn88pi6o3Hf7pZhj9wr9UHK=ui9PzpQvA66_=fivA@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<001301cf5b0b$2ffe5a40$8ffb0ec0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:43108 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaDTHSq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Apr 2014 03:18:46 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so3060154qge.30
        for <linux-mmc@vger.kernel.org>; Sun, 20 Apr 2014 00:18:45 -0700 (PDT)
In-Reply-To: <001301cf5b0b$2ffe5a40$8ffb0ec0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

Hi Seungwon,

On 18 April 2014 15:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This series contains the change for selection of bus speed mode.
> Previous implementation is complicated and some sequence is duplicated.
> And specially, HS400 mode eMMC5.0 is introduced this time.
> This patch-set has been tested in Exynos SoC.
>
> Note:
> This patch-set depends on "[PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC".
>
> Changes in v6:
>         (6/6) Included "mmc: core: add DT bindings for eMMC HS400 1.8/1.2V" into this patch-set
>         (5/6) Changed return type of prepare_hs400_tuning callback(int -> void)

I would favour the int return type, that leaves room for the
possibility of drivers to fail.

Moreover, I have already sent a pull request to Chris, with the v5
version of this patchset, which I think is fine.

Kind regards
Uffe


> Changes in v5:
>         (5/5) Added callback operation for HS400 target operation frequency
>                instead of specific timing identifier.
>         (2/5) Removed using union declaration.
>
> Changes in v4:
>         (5/5)Reverting to HS mode is included in mmc_select_hs400() using __mmc_switch().
>
> Changes in v3:
>         Removed the function to check DDR type(mmc_snoop_ddr).
>         Rebased with the latest branch.
>
> Seungwon Jeon (6):
>   mmc: drop the speed mode of card's state
>   mmc: identify available device type to select
>   mmc: step power class after final selection of bus mode
>   mmc: rework selection of bus speed mode
>   mmc: add support for HS400 mode of eMMC5.0
>   mmc: add DT bindings for eMMC HS400 1.8/1.2V
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 +
>  drivers/mmc/core/bus.c                        |    9 +-
>  drivers/mmc/core/core.c                       |    3 +-
>  drivers/mmc/core/debugfs.c                    |    5 +-
>  drivers/mmc/core/host.c                       |    4 +
>  drivers/mmc/core/mmc.c                        |  666 +++++++++++++++----------
>  drivers/mmc/core/sd.c                         |   16 +-
>  drivers/mmc/core/sd.h                         |    1 -
>  drivers/mmc/core/sdio.c                       |    8 +-
>  include/linux/mmc/card.h                      |   27 +-
>  include/linux/mmc/host.h                      |   43 ++-
>  include/linux/mmc/mmc.h                       |   23 +-
>  12 files changed, 486 insertions(+), 321 deletions(-)
>
> Thanks,
> sw-j
>
