From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: rockchip: unset the MMC_CAP_ERASE flag
Date: Mon, 18 Jul 2016 13:20:47 +0200
Message-ID: <CAPDyKFr=neqgWms0Xopr1iwDQ+7nH9Hwd0s=hhKiYvyL0s7bSA@mail.gmail.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com> <1468547691-4525-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38486 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbcGRLUu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 07:20:50 -0400
Received: by mail-wm0-f52.google.com with SMTP id o80so111740630wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 04:20:49 -0700 (PDT)
In-Reply-To: <1468547691-4525-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 15 July 2016 at 03:54, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> In dw_mmc.c, it's enabled by default.
> It doesn't need to set MMC_CAP_ERASE in rockchip anymore.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

As we are close to the merge window, I picked this up directly instead
of you having to send me a PR.

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index d3cf1f1..25eae35 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -294,10 +294,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>
>  /* Common capabilities of RK3288 SoC */
>  static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
> -       MMC_CAP_ERASE | MMC_CAP_CMD23,
> -       MMC_CAP_ERASE | MMC_CAP_CMD23,
> -       MMC_CAP_ERASE | MMC_CAP_CMD23,
> -       MMC_CAP_ERASE | MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
>  };
>
>  static const struct dw_mci_drv_data rk2928_drv_data = {
> --
> 1.9.1
>
