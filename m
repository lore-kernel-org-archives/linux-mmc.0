From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] mmc: dw_mmc: update host driver with minor fixes
Date: Mon, 22 Dec 2014 15:03:33 +0100
Message-ID: <CAPDyKFrpds3Qg7ZKtJkWHsAGThBLUk3GdUhg9iD9U6xS3zwccg@mail.gmail.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33671 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbaLVODe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 09:03:34 -0500
Received: by mail-qg0-f41.google.com with SMTP id e89so1548414qgf.28
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2014 06:03:34 -0800 (PST)
In-Reply-To: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 22 December 2014 at 13:12, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> This series is part of [1] which are send by Seungwon jeon few months back.
> when he attempted to add HS400 support for exynos dw_mmc host controller.
> Since then these patches are just sitting idle.
> This is my attempt to land some of the changes which are generic, and performance
> booter on dw_mmc host controller.
>
> These patches are already ACKed by Jaehoon Chung.
>
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg27903.html
>
> Changes in v3:
>       None, just a rebase on ulf's next branch.
>
>
> Seungwon Jeon (3):
>   mmc: dw_mmc: fix the max_blk_count in IDMAC
>   mmc: dw_mmc: exynos: don't use if clock isn't available
>   mmc: dw_mmc: exynos: move definitions to header file
>
>  drivers/mmc/host/dw_mmc-exynos.c |   59 +++++++++-----------------------------
>  drivers/mmc/host/dw_mmc-exynos.h |   56 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c        |    4 +--
>  3 files changed, 71 insertions(+), 48 deletions(-)
>  create mode 100644 drivers/mmc/host/dw_mmc-exynos.h
>
> --
> 1.7.9.5
>

Thanks! Applied for next.

Kind regards
Uffe
