From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: bcm2835: Fix possible NULL ptr dereference in
 bcm2835_request
Date: Mon, 27 Mar 2017 17:03:50 +0900
Message-ID: <eb196e9b-e8f0-1da0-e7a8-94a967a08419@samsung.com>
References: <CGME20170325131858epcas2p1cad98d718fe646d90e85df131725eb01@epcas2p1.samsung.com>
 <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37799 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdC0IEN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 04:04:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ONG0057JRQGWOC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Mar 2017 17:03:52 +0900 (KST)
In-reply-to: <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On 03/25/2017 10:17 PM, Stefan Wahren wrote:
> This fixes a NULL pointer dereference in case of a MMC request with a
> set block count command and no data.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>  drivers/mmc/host/bcm2835.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7d1b0db..1f343a4 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1200,7 +1200,8 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		return;
>  	}
>  
> -	host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
> +	host->use_sbc = !!mrq->sbc && host->mrq->data &&
> +			(host->mrq->data->flags & MMC_DATA_READ);
>  	if (host->use_sbc) {
>  		if (bcm2835_send_command(host, mrq->sbc)) {
>  			if (!host->use_busy)
> 

