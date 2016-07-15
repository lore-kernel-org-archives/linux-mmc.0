From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: set to MMC_CAP_ERASE by default
Date: Fri, 15 Jul 2016 10:11:14 +0800
Message-ID: <807402f9-1e4b-c78f-5cb9-a2d35adaaf13@rock-chips.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:42707 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbcGOCLb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 22:11:31 -0400
In-Reply-To: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

=D4=DA 2016/7/15 9:54, Jaehoon Chung =D0=B4=B5=C0:
> This flag needs to use the trim/discard/erase commands.
> dwmmc controller enables this flag by default.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>  drivers/mmc/host/dw_mmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9fab5ed..d16de19 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2604,6 +2604,12 @@ static int dw_mci_init_slot(struct dw_mci *hos=
t, unsigned int id)
>  	if (host->pdata->caps)
>  		mmc->caps =3D host->pdata->caps;
>
> +	/*
> +	 * Support MMC_CAP_ERASE by default.
> +	 * It needs to use trim/discard/erase commands.
> +	 */
> +	mmc->caps |=3D MMC_CAP_ERASE;
> +
>  	if (host->pdata->pm_caps)
>  		mmc->pm_caps =3D host->pdata->pm_caps;
>
>


--=20
Best Regards
Shawn Lin

