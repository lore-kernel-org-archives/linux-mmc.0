From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove unused define for NUM_GPIOS
Date: Fri, 08 Nov 2013 13:56:12 +0900
Message-ID: <527C6EEC.8060404@samsung.com>
References: <1380790750.30876.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22726 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3KHE4N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Nov 2013 23:56:13 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVX00GPZHOYZML0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 08 Nov 2013 13:56:06 +0900 (KST)
In-reply-to: <1380790750.30876.0.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 10/03/2013 05:59 PM, Axel Lin wrote:
> NUM_GPIOS is not used after commit e19499ae
> "mmc: sdhci-s3c: let device core setup the default pin configuration".
> Thus remove it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 926aaf6..d0732d2 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -33,9 +33,6 @@
>  
>  #define MAX_BUS_CLK	(4)
>  
> -/* Number of gpio's used is max data bus width + command and clock lines */
> -#define NUM_GPIOS(x)	(x + 2)
> -
>  /**
>   * struct sdhci_s3c - S3C SDHCI instance
>   * @host: The SDHCI host created
> 

