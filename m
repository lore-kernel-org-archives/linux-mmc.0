From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw-mmc: return the result of mmc_add_host()
Date: Tue, 19 Feb 2013 19:18:48 +0900
Message-ID: <000301ce0e8a$81e2e750$85a8b5f0$%jun@samsung.com>
References: <511E4A19.6020000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57434 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052Ab3BSKSx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 05:18:53 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIG00CM5PZ8GS40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 19 Feb 2013 19:18:51 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIG00LC3PZCJB60@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 19 Feb 2013 19:18:48 +0900 (KST)
In-reply-to: <511E4A19.6020000@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>

On Friday, February 15, 2013, Jaehoon Chung wrote:
> check the result of mmc_add_host() and return the value.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

> ---
>  drivers/mmc/host/dw_mmc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 60063cc..e481d90 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1990,7 +1990,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> 
>  	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
> 
> -	mmc_add_host(mmc);
> +	ret = mmc_add_host(mmc);
> +	if (ret)
> +		goto err_setup_bus;
> 
>  #if defined(CONFIG_DEBUG_FS)
>  	dw_mci_init_debugfs(slot);
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

