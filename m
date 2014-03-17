From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/5] update selection of bus speed mode for eMMC
Date: Mon, 17 Mar 2014 09:47:27 +0100
Message-ID: <CAPDyKFphJhmwSJn76J4CTu3WmU-9JPMa_R=v62j-zhx+R8iz-Q@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<003a01cf3f7f$2e170210$8a450630$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:40984 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaCQIr1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Mar 2014 04:47:27 -0400
Received: by mail-qg0-f48.google.com with SMTP id j107so15767523qga.7
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2014 01:47:27 -0700 (PDT)
In-Reply-To: <003a01cf3f7f$2e170210$8a450630$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 14 March 2014 13:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This series contains the change for selection of bus speed mode.
> Previous implementation is complicated and some sequence is duplicated.
> And specially, HS400 mode eMMC5.0 is introduced this time.
> This patch-set has been tested in Exynos SoC.
>
> Changes in v3:
>         Removed the function to check DDR type(mmc_snoop_ddr).
>         Rebased with the latest branch.

I tried to apply patch 1 for Chris' mmc-next branch, but it failed.
Please have a look.

Kind regards
Ulf Hansson

>
> Seungwon Jeon (5):
>   mmc: drop the speed mode of card's state
>   mmc: identify available device type to select
>   mmc: step power class after final selection of bus mode
>   mmc: rework selection of bus speed mode
>   mmc: add support for HS400 mode of eMMC5.0
>
>  drivers/mmc/core/bus.c     |    9 +-
>  drivers/mmc/core/core.c    |    3 +-
>  drivers/mmc/core/debugfs.c |    5 +-
>  drivers/mmc/core/mmc.c     |  681 +++++++++++++++++++++++++++-----------------
>  drivers/mmc/core/sd.c      |   16 +-
>  drivers/mmc/core/sd.h      |    1 -
>  drivers/mmc/core/sdio.c    |    8 +-
>  include/linux/mmc/card.h   |   31 +--
>  include/linux/mmc/host.h   |   42 +++-
>  include/linux/mmc/mmc.h    |   23 ++-
>  10 files changed, 497 insertions(+), 322 deletions(-)
>
> Thanks,
> Sw-j
>
