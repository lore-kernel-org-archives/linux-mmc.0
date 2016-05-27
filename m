From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH 1/2] mmc: dw_mmc: remove redundant of set_bit and
 clear_bit
Date: Fri, 27 May 2016 09:53:18 +0900
Message-ID: <57479A7E.3050103@samsung.com>
References: <CGME20160526030828epcas1p16b97a230c35c2599a2b8fcada376c9de@epcas1p1.samsung.com>
 <1464232063-24841-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56405 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbcE0AxU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 20:53:20 -0400
In-reply-to: <1464232063-24841-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 05/26/2016 12:07 PM, Shawn Lin wrote:
> dw_mci_get_cd have already dealed with these for
> both of internal card-detect and gpio card-detect.

s/dealed/dealt

This patch looks good to me. Could you resend the patch? not RFC.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 829a6ee..cb30e91 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2616,10 +2616,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  		mmc->max_seg_size = mmc->max_req_size;
>  	}
>  
> -	if (dw_mci_get_cd(mmc))
> -		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> -	else
> -		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +	dw_mci_get_cd(mmc);
>  
>  	ret = mmc_add_host(mmc);
>  	if (ret)
> 

