From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix error return code in sh_mobile_sdhi_probe()
Date: Thu, 27 Jun 2013 10:57:52 -0400
Message-ID: <8738s3r47j.fsf@octavius.laptop.org>
References: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56506 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab3F0O6D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:58:03 -0400
In-Reply-To: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com> (Wei
	Yongjun's message of "Tue, 28 May 2013 13:26:50 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: g.liakhovetski@gmx.de, ian@mnementh.co.uk, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Wei,

On Tue, May 28 2013, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fix to return a negative error code instead of 0 when we cannot get
> IRQ source by platform_get_irq(), as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index cc4c872..a4316b3 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -273,8 +273,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		}
>  
>  		/* There must be at least one IRQ source */
> -		if (!i)
> +		if (!i) {
> +			ret = irq;
>  			goto eirq;
> +		}
>  	}
>  
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
