From: Balaji T K <balajitk@ti.com>
Subject: Re: [patch 2/2] mmc: omap_hsmmc: checking for ERR_PTR instead of
 NULL
Date: Thu, 30 Jan 2014 18:30:35 +0530
Message-ID: <52EA4CF3.2000200@ti.com>
References: <20140130121548.GB10368@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140130121548.GB10368@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 30 January 2014 05:45 PM, Dan Carpenter wrote:
> The of_get_hsmmc_pdata() function returns NULL on error, it doesn't
> return ERR_PTRs.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index bfb0dbd052c0..76dbc7b759c2 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1761,9 +1761,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
>   	if (match) {
>   		pdata = of_get_hsmmc_pdata(&pdev->dev);
> -
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> +		if (!pdata)
> +			return -ENOMEM;

Thanks for reporting this.
Caller needs to be fixed. I will send a patch to fix this.

>
>   		if (match->data) {
>   			const u16 *offsetp = match->data;
>

