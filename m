From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: check card present before starting request
Date: Fri, 27 May 2016 12:46:14 +0900
Message-ID: <5747C306.7030909@samsung.com>
References: <CGME20160527030403epcas1p48a308b374e994de0e9e80b1b7ff1da10@epcas1p4.samsung.com>
 <1464318141-5360-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55729 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcE0DqQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 23:46:16 -0400
In-reply-to: <1464318141-5360-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 05/27/2016 12:02 PM, Shawn Lin wrote:
> The main reason to add this check is to avoid unnecessary
> mmc_request like the on-going cmd and the corresponding sbc
> if the card is removed. Although we have already checked this in
> dw_mci_handle_cd for runtime usage of sd card and dw_mci_init_slot
> for noremovable devices, but there is a timing gap before it really
> calls dw_mci_get_cd as mmc_detect_change needs some delay here.
> 
> Another gain here is that we could save some checkings of card status
> after sd card been removed.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index cb30e91..8eb7898 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -105,6 +105,7 @@ struct idmac_desc {
>  static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>  static int dw_mci_card_busy(struct mmc_host *mmc);
> +static int dw_mci_get_cd(struct mmc_host *mmc);
>  
>  #if defined(CONFIG_DEBUG_FS)
>  static int dw_mci_req_show(struct seq_file *s, void *v)
> @@ -1255,7 +1256,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	 */
>  	spin_lock_bh(&host->lock);
>  
> -	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
> +	if (!dw_mci_get_cd(mmc)) {
>  		spin_unlock_bh(&host->lock);
>  		mrq->cmd->error = -ENOMEDIUM;
>  		mmc_request_done(mmc, mrq);

I think spin_lock/unlock_bh() should be removed at here.
Instead, Can it locate before calling dw_mci_queue_request()?

Anyway, it looks good to me.

Best Regards,
Jaehoon Chung

> 

