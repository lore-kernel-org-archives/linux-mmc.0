From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] update selection of bus speed mode for eMMC
Date: Thu, 13 Mar 2014 15:41:54 +0100
Message-ID: <CAPDyKFra2CpjWK=m1R6fjEn8FrgV9JhiCn_gpY_o_92bK2P7Gg@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<003a01cf3a12$801584f0$80408ed0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:48202 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbaCMOlz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Mar 2014 10:41:55 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so1102056qaq.10
        for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2014 07:41:54 -0700 (PDT)
In-Reply-To: <003a01cf3a12$801584f0$80408ed0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 7 March 2014 15:35, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This series contains the change for selection of bus speed mode.
> Previous implementation is complicated and some sequence is duplicated.
> And specially, HS400 mode eMMC5.0 is introduced this time.
>
> - Continued/Updated since "[PATCH 0/3] mmc: update bus speed mode" series.
>   (Applied some comments from Ulf Hansson, Jackey Shen.)
> - Tested at EXYNOS SOC.
>
> Seungwon Jeon (5):
>   mmc: drop the speed mode of card's state
>   mmc: identify available device type to select
>   mmc: step power class after final selection of bus mode
>   mmc: rework selection of bus speed mode
>   mmc: add support for HS400 mode of eMMC5.0
>

Could you please rebase your patches on latest mmc-next, and please
run checkpatch for all of them.

Kind regards
Ulf Hansson


>  drivers/mmc/core/bus.c     |    9 +-
>  drivers/mmc/core/core.c    |    3 +-
>  drivers/mmc/core/debugfs.c |    5 +-
>  drivers/mmc/core/mmc.c     |  688 +++++++++++++++++++++++++++-----------------
>  drivers/mmc/core/sd.c      |   16 +-
>  drivers/mmc/core/sd.h      |    1 -
>  drivers/mmc/core/sdio.c    |    8 +-
>  include/linux/mmc/card.h   |   31 +--
>  include/linux/mmc/host.h   |   42 +++-
>  include/linux/mmc/mmc.h    |   23 ++-
>  10 files changed, 505 insertions(+), 321 deletions(-)
>
>
