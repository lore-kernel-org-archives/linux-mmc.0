From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 6 Jul 2016 18:19:25 +0200
Message-ID: <CAPDyKFrs7c2szMBTrZWpuZzU5LK7rbLdNGq28K82FJeNpdJu_g@mail.gmail.com>
References: <5773279F.1080003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33801 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbcGFQTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2016 12:19:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id 187so33350088wmz.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2016 09:19:27 -0700 (PDT)
In-Reply-To: <5773279F.1080003@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jerome Forissier <jerome.forissier@linaro.org>, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Jae hoon Chung <jh80.chung@gmail.com>

On 29 June 2016 at 03:42, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your repository (next branch)?
>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 466780648db4aed7722de91e9d9749c6c5=
969327:
>
>   mmc: sh_mmcif: Use a 10s timeout in the error recovery path (2016-0=
6-27 11:19:29 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 545585efee538cac5202b415a3d0c12b4556e9=
6f:
>
>   mmc: dw_mmc: fix unmap sg twice when finding data err (2016-06-29 1=
0:39:05 +0900)
>
> ----------------------------------------------------------------
> Ben Dooks (1):
>       mmc: dw_mmc: fix 32bit little-endian access of des1 field
>
> Doug Anderson (2):
>       mmc: dw_mmc: Consider HLE errors to be data and command errors
>       mmc: dw_mmc: Wait for data transfer after response errors.
>
> Jaehoon Chung (4):
>       mmc: dw_mmc: exynos: fix the NULL pointer dereference error
>       mmc: dw_mmc: remove the quirks flags
>       mmc: dw_mmc: add the card write threshold for HS400 mode
>       mmc: dw_mmc: prevent to set the wrong value
>
> J=C3=A9r=C3=B4me Forissier (1):
>       mmc: dw_mmc: k3: add MMC_CAP_CMD23
>
> Seung-Woo Kim (1):
>       mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
>
> Shawn Lin (3):
>       mmc: dw_mmc: remove redundant of set_bit and clear_bit
>       mmc: dw_mmc: check card present before starting request
>       mmc: dw_mmc: fix unmap sg twice when finding data err
>
>  drivers/mmc/host/dw_mmc-exynos.c   |   2 +-
>  drivers/mmc/host/dw_mmc-k3.c       |   7 ++
>  drivers/mmc/host/dw_mmc-rockchip.c |   3 -
>  drivers/mmc/host/dw_mmc.c          | 157 ++++++++++++++++++++++-----=
----------
>  drivers/mmc/host/dw_mmc.h          |  10 +--
>  include/linux/mmc/dw_mmc.h         |   9 ---
>  6 files changed, 108 insertions(+), 80 deletions(-)

Thanks Jaehoon, pulled into my next branch!

Kind regards
Uffe
