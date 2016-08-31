From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 31 Aug 2016 13:16:56 +0200
Message-ID: <CAPDyKFr=sE=oj2WpYokeCfhW1Xe96WT0_1asQu2uX34Wi3EE7w@mail.gmail.com>
References: <4202d0be-ec5c-3594-d5ad-fce6d314c547@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36020 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759402AbcHaLQ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 07:16:58 -0400
Received: by mail-wm0-f49.google.com with SMTP id c133so27604196wmd.1
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2016 04:16:58 -0700 (PDT)
In-Reply-To: <4202d0be-ec5c-3594-d5ad-fce6d314c547@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>, Jin Guojun <kid.jin@hisilicon.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 31 August 2016 at 12:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your mmc-next?
> If there are any other problems, let me know, plz.

Thanks Jaehoon, pulled into my next branch!

Kind regards
Uffe

>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 08433b60269228dc92c4bce6bba5902a8a5b904b:
>
>   mmc: block: don't use CMD23 with very old MMC cards (2016-08-31 10:24:51 +0200)
>
> are available in the git repository at:
>
>   http://github.com/jh80chung/dw-mmc for-ulf
>
> for you to fetch changes up to 802a9ffc7b3e5901cc79f36a900a0f7abe5592c8:
>
>   mmc: dw_mmc: k3: UHS-SD card for Hisilicon Hikey (2016-08-31 19:56:31 +0900)
>
> ----------------------------------------------------------------
> Guodong Xu (2):
>       Documentation: synopsys-dw-mshc: add binding for resets
>       mmc: dw_mmc: add reset support to dwmmc host controller
>
> Jaehoon Chung (1):
>       mmc: dw_mmc: remove the unnecessary IS_ERR() checking for ciu/biu clock
>
> Jin Guojun (1):
>       mmc: dw_mmc: k3: UHS-SD card for Hisilicon Hikey
>
> Krzysztof Kozlowski (1):
>       mmc: dw_mmc: exynos: Warn if HS400 is being used on non-Exynos5420 chipset
>
> Shawn Lin (2):
>       mmc: dw_mmc: remove parsing for each slot subnode
>       mmc: dw_mmc: return -EILSEQ for EBE and SBE error
>
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  4 ++++
>  drivers/mmc/host/dw_mmc-exynos.c                           |  6 +++++-
>  drivers/mmc/host/dw_mmc-k3.c                               |  6 ++++++
>  drivers/mmc/host/dw_mmc.c                                  | 81 +++++++++++++++++++++++++++------------------------------------------------------
>  include/linux/mmc/dw_mmc.h                                 |  2 ++
>  5 files changed, 44 insertions(+), 55 deletions(-)
>
