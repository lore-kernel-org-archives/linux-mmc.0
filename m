From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: remove the deprecated
 "supports-highspeed" property
Date: Fri, 29 Jul 2016 10:44:27 +0800
Message-ID: <0dc812a2-8b80-03cf-b253-58f7f45ab72b@rock-chips.com>
References: <1469699727-23339-1-git-send-email-jh80.chung@samsung.com>
 <1469699727-23339-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469699727-23339-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Rob Herrin <robh+dt@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/7/28 17:55, Jaehoon Chung =D0=B4=B5=C0:
> Remvoe the deprecated "supports-highspeed" property.
> DWMMC controller will not use this property anymore.
>

We had set up a flag day to remove these deprecated property
long time agao.

It doesn't *break* old dtb which may(not ?) still boot up new
kernel code as we just make it suffer from lower speed, then
I think it's time for them to migrate to the new property anyway.

So,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1b719a6..e9faedd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2890,11 +2890,6 @@ static struct dw_mci_board *dw_mci_parse_dt(st=
ruct dw_mci *host)
>  			return ERR_PTR(ret);
>  	}
>
> -	if (of_find_property(np, "supports-highspeed", NULL)) {
> -		dev_info(dev, "supports-highspeed property is deprecated.\n");
> -		pdata->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> -	}
> -
>  	return pdata;
>  }
>
>


--=20
Best Regards
Shawn Lin
