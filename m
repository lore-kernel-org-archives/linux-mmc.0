From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Mon, 18 Mar 2013 19:21:36 +0900
Message-ID: <5146EAB0.1030705@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28328 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab3CRKVf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Mar 2013 06:21:35 -0400
In-reply-to: <1363382956-14557-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Paul Stewart <pstew@chromium.org>, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug,

Great..i have found the problem like this.
I will check your patch..and share the result.

Best Regards,
Jaehoon Chung

On 03/16/2013 06:29 AM, Doug Anderson wrote:
> On a flaky piece of hardware that seems good at generating CRC errors,
> we have found that often times the CRC errors don't get reported
> properly when using CONFIG_MMC_DW_IDMAC (they get reported OK when
> using pio).
> 
> The flow that happens is:
> 1. dw_mci_interrupt() fires and status=80b8, pending=8088 so that
>    we hit (pending & DW_MCI_DATA_ERROR_FLAGS).  We store 8088 in
>    data_status and set EVENT_DATA_ERROR in host->pending_events
> 2. We schedule the tasklet and it runs.
> 3. We're in STATE_SENDING_DATA in the tasklet and see
>    EVENT_DATA_ERROR so we dw_mci_stop_dma().
> 4. dw_mci_stop_dma() calls dw_mci_idmac_stop_dma() and
>    dw_mci_dma_cleanup().  These stop dma but _don't_ set
>    EVENT_XFER_COMPLETE (since we're host->using_dma).
> 5. data->stop is NULL so we don't send a stop command.
> 6. We move onto STATE_DATA_ERROR and loop again in the tasklet.
> 7. We hit STATE_DATA_ERROR but the transfer isn't done, so the tasklet
>    stops.
> 
> We never seem to get any additional DMA interrupts that cause
> EVENT_XFER_COMPLETE and restart the tasklet so we just hang.  That
> doesn't seem surprising given that we've stopped DMA.
> 
> We did put a print at the end of dw_mci_interrupt() to show the result
> of the "mci_readl(host, IDSTS)" and saw 0xa000 in the case of the
> above CRC error.
> 
> A proposed fix for this is to ignore (but still clear) the
> EVENT_XFER_COMPLETE in STATE_DATA_ERROR in the tasklet.
> 
> Reported-by: Bing Zhao <bzhao@marvell.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9834221..696b3bb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1137,10 +1137,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			goto unlock;
>  
>  		case STATE_DATA_ERROR:
> -			if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
> -						&host->pending_events))
> -				break;
> -
> +			clear_bit(EVENT_XFER_COMPLETE, &host->pending_events);
>  			state = STATE_DATA_BUSY;
>  			break;
>  		}
> 

