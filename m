From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: fix host reference after mmc_free_host
Date: Mon, 29 Oct 2012 12:56:20 -0400
Message-ID: <87pq41tdxn.fsf@octavius.laptop.org>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
	<1350317108-10657-3-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1350317108-10657-3-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Mon, 15 Oct 2012 21:35:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 15 2012, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>
> struct omap_hsmmc_host *host should not be accessed after mmc_free_host().
> Reorder mmc_free_host() after iounmap(host->base).
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index a33ab74..a3929b7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2019,8 +2019,8 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
>  		clk_put(host->dbclk);
>  	}
>  
> -	mmc_free_host(host->mmc);
>  	iounmap(host->base);
> +	mmc_free_host(host->mmc);
>  	omap_hsmmc_gpio_free(pdev->dev.platform_data);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
