From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/1] mmc: dw_mmc: Fix NULL pointer dereference
Date: Wed, 15 Jan 2014 20:59:22 +0900
Message-ID: <001801cf11e9$3adbf6e0$b093e4a0$%jun@samsung.com>
References: <1389781753-28217-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45688 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbaAOL7Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 06:59:24 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZF00MTOYMZ4740@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 20:59:23 +0900 (KST)
In-reply-to: <1389781753-28217-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, jh80.chung@samsung.com, patches@linaro.org

On Wed, January 15, 2014, Sachin Kamat wrote:
> If mrq->sbc is not NULL but data->stop happens to be NULL,
> it will lead to NULL pointer dereferencing. Avoid this by
> having a NULL check for data->stop.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Although there is actually no case in mrq->sbc is not NULL and  data->stop NULL from mmc's block,
this change is desirable.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9ded62c8225e..8b3e58a5f9ed 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1345,7 +1345,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
> 
>  			if (!err) {
>  				if (!data->stop || mrq->sbc) {
> -					if (mrq->sbc)
> +					if (mrq->sbc && data->stop)
>  						data->stop->error = 0;
>  					dw_mci_request_end(host, mrq);
>  					goto unlock;
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

