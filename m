From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: rockchip: unset the MMC_CAP_ERASE flag
Date: Fri, 15 Jul 2016 10:09:54 +0800
Message-ID: <8267eb33-c6c1-d85e-a6e2-aae4ca7a89bb@rock-chips.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
 <1468547691-4525-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:35055 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcGOCK3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 22:10:29 -0400
In-Reply-To: <1468547691-4525-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

=D4=DA 2016/7/15 9:54, Jaehoon Chung =D0=B4=B5=C0:
> In dw_mmc.c, it's enabled by default.
> It doesn't need to set MMC_CAP_ERASE in rockchip anymore.

Nice to hear that.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw=
_mmc-rockchip.c
> index d3cf1f1..25eae35 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -294,10 +294,10 @@ static int dw_mci_rockchip_init(struct dw_mci *=
host)
>
>  /* Common capabilities of RK3288 SoC */
>  static unsigned long dw_mci_rk3288_dwmmc_caps[4] =3D {
> -	MMC_CAP_ERASE | MMC_CAP_CMD23,
> -	MMC_CAP_ERASE | MMC_CAP_CMD23,
> -	MMC_CAP_ERASE | MMC_CAP_CMD23,
> -	MMC_CAP_ERASE | MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
>  };
>
>  static const struct dw_mci_drv_data rk2928_drv_data =3D {
>


--=20
Best Regards
Shawn Lin

