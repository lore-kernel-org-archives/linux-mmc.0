From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 18/22] mmc: sdhci-s3c: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 12:37:33 +0900
Message-ID: <518876FD.2000207@samsung.com>
References: <005d01ce4a23$f4a94d90$ddfbe8b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33953 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab3EGDhb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 23:37:31 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MME0072SSQHT450@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 07 May 2013 12:37:30 +0900 (KST)
In-reply-to: <005d01ce4a23$f4a94d90$ddfbe8b0$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 05/06/2013 03:35 PM, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index c6f6246..926aaf6 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -745,7 +745,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(sc->clk_io);
>  
>  	sdhci_free_host(host);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }
> 

