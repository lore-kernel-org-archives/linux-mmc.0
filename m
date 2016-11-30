From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] DWMMC controller for next
Date: Wed, 30 Nov 2016 09:13:48 +0100
Message-ID: <CAPDyKFr2y1qwbqx5o4pN7rp=aAqbxRu-1Yf4ui--M-Ut-s8dJw@mail.gmail.com>
References: <657025e2-decd-338e-60e9-f7ebfc7fcbb4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:36415 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbcK3INz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 03:13:55 -0500
Received: by mail-wj0-f179.google.com with SMTP id qp4so166527493wjc.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2016 00:13:50 -0800 (PST)
In-Reply-To: <657025e2-decd-338e-60e9-f7ebfc7fcbb4@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 30 November 2016 at 02:39, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches for next on your repository?
>
> The following changes since commit b977a3400ee697f80e128e8bb927652026e400da:
>
>   mmc: mmc_test: remove BUG_ONs and deploy error handling (2016-11-29 13:40:22 +0100)
>
> are available in the git repository at:
>
>   http://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to dc595736c5549b82d02fb4217cf68be595e479be:
>
>   mmc: dw_mmc: display the clock message only one time when card is polling (2016-11-30 10:36:33 +0900)
>
> ----------------------------------------------------------------
> Jaehoon Chung (3):
>       mmc: dw_mmc: check the "present" variable before checking flags
>       mmc: dw_mmc: add the debug message for polling and non-removable
>       mmc: dw_mmc: display the clock message only one time when card is polling
>
> Joonyoung Shim (2):
>       mmc: dw_mmc: exynos: fix to call suspend callback
>       mmc: dw_mmc: add missing codes for runtime resume
>
>  drivers/mmc/host/dw_mmc-exynos.c | 28 ++++++++++++++++++++++++++--
>  drivers/mmc/host/dw_mmc.c        | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/dw_mmc.h        |  1 +
>  3 files changed, 72 insertions(+), 7 deletions(-)
>
> Best Regards,
> Jaehoon Chung

Thanks Jaehoon, pulled into next!

Kind regards
Uffe
