From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix spelling mistake in dev_dbg message
Date: Thu, 17 Nov 2016 10:24:20 +0900
Message-ID: <360eeabd-3deb-ad52-cd41-d78e0c8b7973@samsung.com>
References: <CGME20161116185513epcas4p1d969894081c8dabb75a554321d1e4bed@epcas4p1.samsung.com>
 <20161116185501.10976-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46190 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbcKQBYq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 20:24:46 -0500
In-reply-to: <20161116185501.10976-1-colin.king@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Colin,

On 11/17/2016 03:55 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake "desciptor" to "descriptor" in
> dev_dbg message.

Applied on my dwmmc repository. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a16c537..9341b18 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -612,7 +612,7 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
>  	return 0;
>  err_own_bit:
>  	/* restore the descriptor chain as it's polluted */
> -	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
> +	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
>  	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
>  	dw_mci_idmac_init(host);
>  	return -EINVAL;
> @@ -688,7 +688,7 @@ static inline int dw_mci_prepare_desc32(struct dw_mci *host,
>  	return 0;
>  err_own_bit:
>  	/* restore the descriptor chain as it's polluted */
> -	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
> +	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
>  	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
>  	dw_mci_idmac_init(host);
>  	return -EINVAL;
> 

