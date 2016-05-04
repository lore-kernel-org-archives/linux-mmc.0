From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: retry to switch voltage when failed
Date: Wed, 4 May 2016 18:41:55 +0800
Message-ID: <96613140-e5f9-1ffd-a9d3-84f3133913be@rock-chips.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:48029 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcEDKmN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 06:42:13 -0400
In-Reply-To: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

=D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
> If vqmmc is used and failed to switch voltage, then retry to switch
> voltage. MMC core is providing the retrying scheame.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9dd1bd3..28602cc 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1416,7 +1416,7 @@ static int dw_mci_switch_voltage(struct mmc_hos=
t *mmc, struct mmc_ios *ios)
>  			dev_dbg(&mmc->class_dev,
>  					 "Regulator set error %d - %s V\n",
>  					 ret, uhs & v18 ? "1.8" : "3.3");
> -			return ret;
> +			return -EAGAIN;
>  		}
>  	}

If not vqmmc is assigned, dw_mci_switch_voltage still returns success t=
o
mmc core?

>  	mci_writel(host, UHS_REG, uhs);
>


--=20
Best Regards
Shawn Lin

