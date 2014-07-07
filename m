From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv2 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Mon, 07 Jul 2014 18:19:35 +0900
Message-ID: <000d01cf99c4$920eb1b0$b62c1510$%jun@samsung.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
 <1404128960-27225-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49449 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaGGJTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jul 2014 05:19:38 -0400
In-reply-to: <1404128960-27225-6-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, 'Mark Rutland' <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Sorry for late review.
If you're in progress for next, please consider it.

On Mon, June 30, 2014, Jaehoon Chung wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..6c5d696 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -994,10 +994,11 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>  {
>  	int read_only;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci_board *brd = slot->host->pdata;
>  	int gpio_ro = mmc_gpio_get_ro(mmc);
> 
>  	/* Use platform get_ro function, else try on board write protect */
> -	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
It would be better to use host->quirks instead of brd->quirks
It's finally updated with host->pdata->quirks on probing.

Thanks,
Seungwon Jeon

