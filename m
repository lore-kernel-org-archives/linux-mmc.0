From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove struct block_settings
Date: Fri, 22 Jan 2016 10:26:15 +0900
Message-ID: <56A18537.7030402@samsung.com>
References: <1453363574-30802-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58420 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbcAVB0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 20:26:18 -0500
In-reply-to: <1453363574-30802-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

Applied this.
Thanks!

Best Regards,
Jaehoon Chung

On 01/21/2016 05:06 PM, Shawn Lin wrote:
> This patch remove struct block_settings since
> it never be used anywhere.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  include/linux/mmc/dw_mmc.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 89df7ab..e1f90b8 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -242,14 +242,6 @@ struct dw_mci_dma_ops {
>  
>  struct dma_pdata;
>  
> -struct block_settings {
> -	unsigned short	max_segs;	/* see blk_queue_max_segments */
> -	unsigned int	max_blk_size;	/* maximum size of one mmc block */
> -	unsigned int	max_blk_count;	/* maximum number of blocks in one req*/
> -	unsigned int	max_req_size;	/* maximum number of bytes in one req*/
> -	unsigned int	max_seg_size;	/* see blk_queue_max_segment_size */
> -};
> -
>  /* Board platform data */
>  struct dw_mci_board {
>  	u32 num_slots;
> 

