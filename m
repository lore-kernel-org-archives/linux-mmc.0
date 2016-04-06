From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 6 Apr 2016 09:42:40 +0200
Message-ID: <CAPDyKFrc-iCcqdP=vC-4-n=U6mXSXz_OCP3CE8aGii3PkrdMOg@mail.gmail.com>
References: <57046CDD.7090403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35043 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbcDFHmn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 03:42:43 -0400
Received: by mail-wm0-f49.google.com with SMTP id 191so48186000wmq.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2016 00:42:42 -0700 (PDT)
In-Reply-To: <57046CDD.7090403@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 6 April 2016 at 03:56, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf.
>
> Could you pull these patches into your repository (next branch)?
>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 49f6c1ea8c8e96d610f713741544ae6adc5499eb:
>
>   Merge branch 'fixes' into next (2016-04-05 13:11:07 +0200)
>
> are available in the git repository at:
>
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to c5495422af70fa424424cbf2c689d12af2d4296d:
>
>   mmc: dw_mmc: remove setup_clock callback (2016-04-06 08:19:50 +0900)
>
> ----------------------------------------------------------------
> Jaehoon Chung (1):
>       mmc: dw_mmc: exynos: add the function for controlling SMU
>
> Shawn Lin (8):
>       mmc: dw_mmc-rockchip: remove dw_mci_rockchip_pmops
>       mmc: dw_mmc-rockchip: fix failing to mount partition with "discard"
>       mmc: dw_mmc: fix warning reported by kernel-doc
>       mmc: dw_mmc: avoid using dmaengine_terminate_all
>       mmc: dw_mmc: remove unused EVENT_XFER_ERROR
>       mmc: dw_mmc-rockchip: remove setup_clock for rockchip
>       mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
>       mmc: dw_mmc: remove setup_clock callback
>
>  drivers/mmc/host/dw_mmc-exynos.c   | 23 +++++++++++---------
>  drivers/mmc/host/dw_mmc-rockchip.c | 43 +++++++++++++-------------------------
>  drivers/mmc/host/dw_mmc.c          | 11 +---------
>  drivers/mmc/host/dw_mmc.h          |  2 --
>  include/linux/mmc/dw_mmc.h         | 12 +++++++++--
>  5 files changed, 38 insertions(+), 53 deletions(-)

Thanks, pulled into the next branch!

Kind regards
Uffe
