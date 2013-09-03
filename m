From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: add ignorance case for CMD13 CRC error
Date: Tue, 03 Sep 2013 18:59:38 +0900
Message-ID: <005801cea88c$4d77d5b0$e8678110$%jun@samsung.com>
References: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
 <CAPDyKFrGxbo46_uhJrWc-u0k1kJxXxeKePdoou3aFpwSBUY21g@mail.gmail.com>
 <002901cea22c$af778730$0e669590$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53875 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759897Ab3ICJ7m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:59:42 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSJ00CDTNR3QXZ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 03 Sep 2013 18:59:41 +0900 (KST)
In-reply-to: <002901cea22c$af778730$0e669590$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>

On Mon, August 26, 2013, Seungwon Jeon wrote:
> While speed mode is changed, CMD13 cannot be guaranteed.
> According to the spec., it is not recommended to use CMD13
> to check the busy completion of the timing change.
> If CMD13 is used in this case, CRC error must be ignored.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Change in v2:
>  - Removed function declaration.(From Ulf Hansson)
Hi Ulf,

I hope that you find this change.

Thanks,
Seungwon Jeon

> 
>  drivers/mmc/core/mmc_ops.c |   70 ++++++++++++++++++++++++++-----------------
>  1 files changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index ef18348..1464c1e 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -23,6 +23,40 @@
> 
>  #define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
> 
> +static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
> +				    bool ignore_crc)
> +{
> +	int err;
> +	struct mmc_command cmd = {0};
> +
> +	BUG_ON(!card);
> +	BUG_ON(!card->host);
> +
> +	cmd.opcode = MMC_SEND_STATUS;
> +	if (!mmc_host_is_spi(card->host))
> +		cmd.arg = card->rca << 16;
> +	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +	if (ignore_crc)
> +		cmd.flags &= ~MMC_RSP_CRC;
> +
> +	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
> +	if (err)
> +		return err;
> +
> +	/* NOTE: callers are required to understand the difference
> +	 * between "native" and SPI format status words!
> +	 */
> +	if (status)
> +		*status = cmd.resp[0];
> +
> +	return 0;
> +}
> +
> +int mmc_send_status(struct mmc_card *card, u32 *status)
> +{
> +	return __mmc_send_status(card, status, false);
> +}
> +
>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
>  	int err;
> @@ -380,6 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  	struct mmc_command cmd = {0};
>  	unsigned long timeout;
>  	u32 status;
> +	bool ignore_crc;
> 
>  	BUG_ON(!card);
>  	BUG_ON(!card->host);
> @@ -408,10 +443,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  	if (!use_busy_signal)
>  		return 0;
> 
> -	/* Must check status to be sure of no errors */
> +	/*
> +	 * Must check status to be sure of no errors
> +	 * If CMD13 is to check the busy completion of the timing change,
> +	 * disable the check of CRC error.
> +	 */
> +	ignore_crc = (index == EXT_CSD_HS_TIMING) ? true : false;
>  	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
>  	do {
> -		err = mmc_send_status(card, &status);
> +		err = __mmc_send_status(card, &status, ignore_crc);
>  		if (err)
>  			return err;
>  		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> @@ -449,32 +489,6 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
> 
> -int mmc_send_status(struct mmc_card *card, u32 *status)
> -{
> -	int err;
> -	struct mmc_command cmd = {0};
> -
> -	BUG_ON(!card);
> -	BUG_ON(!card->host);
> -
> -	cmd.opcode = MMC_SEND_STATUS;
> -	if (!mmc_host_is_spi(card->host))
> -		cmd.arg = card->rca << 16;
> -	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> -
> -	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
> -	if (err)
> -		return err;
> -
> -	/* NOTE: callers are required to understand the difference
> -	 * between "native" and SPI format status words!
> -	 */
> -	if (status)
> -		*status = cmd.resp[0];
> -
> -	return 0;
> -}
> -
>  static int
>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>  		  u8 len)
> --
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

