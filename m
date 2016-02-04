From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: remove unused EVENT_XFER_ERROR
Date: Thu, 04 Feb 2016 15:12:55 +0900
Message-ID: <56B2EBE7.3030008@samsung.com>
References: <1454469964-21365-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48623 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbcBDGM5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 01:12:57 -0500
In-reply-to: <1454469964-21365-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 02/03/2016 12:26 PM, Shawn Lin wrote:
> EVENT_XFER_ERROR isn't been used now, so we can
> remove it.

If you are ok, after changing the commit message, I will apply this.
Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  include/linux/mmc/dw_mmc.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 89df7ab..b29e06e 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -36,7 +36,6 @@ enum {
>  	EVENT_XFER_COMPLETE,
>  	EVENT_DATA_COMPLETE,
>  	EVENT_DATA_ERROR,
> -	EVENT_XFER_ERROR
>  };
>  
>  struct mmc_data;
> 

