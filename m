From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: remove redundant of set_bit and
 clear_bit
Date: Mon, 30 May 2016 08:18:20 +0900
Message-ID: <574B78BC.10700@samsung.com>
References: <CGME20160527063715epcas1p1584a3a6340d55ca1d912dc93f2d89bab@epcas1p1.samsung.com>
 <1464331000-16230-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54415 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbcE2XSV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2016 19:18:21 -0400
In-reply-to: <1464331000-16230-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

Applied on my repository.
Thanks!

Best Regards,
Jaehoon Chung

On 05/27/2016 03:36 PM, Shawn Lin wrote:
> dw_mci_get_cd have already dealt with these for
> both of internal card-detect and gpio card-detect.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2: None
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

