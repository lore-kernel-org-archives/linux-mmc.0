From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Use mmc_send_status() and drop
 get_card_status()
Date: Mon, 22 May 2017 10:43:49 +0300
Message-ID: <888cba7c-df6f-7c24-ee26-d644f261781d@intel.com>
References: <1495438722-22091-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753061AbdEVHtn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 May 2017 03:49:43 -0400
In-Reply-To: <1495438722-22091-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 22/05/17 10:38, Ulf Hansson wrote:
> There are no reason to why the mmc block device driver needs to implements
> its own version of how to get the status of the card. Current it do so via
> the static function get_card_status(). Let's instead drop that function and
> convert to use mmc_send_status() as that is what everybody else is using.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/block.c   | 22 +++-------------------
>  drivers/mmc/core/mmc_ops.c |  1 +
>  2 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e973798..23a3254 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -127,7 +127,6 @@ MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
>  
>  static inline int mmc_blk_part_switch(struct mmc_card *card,
>  				      struct mmc_blk_data *md);
> -static int get_card_status(struct mmc_card *card, u32 *status, int retries);
>  
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -385,7 +384,7 @@ static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
>  		return -EINVAL;
>  
>  	do {
> -		err = get_card_status(card, status, 5);
> +		err = mmc_send_status(card, status);
>  		if (err)
>  			break;
>  
> @@ -885,21 +884,6 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>  	return 0;
>  }
>  
> -static int get_card_status(struct mmc_card *card, u32 *status, int retries)
> -{
> -	struct mmc_command cmd = {};
> -	int err;
> -
> -	cmd.opcode = MMC_SEND_STATUS;
> -	if (!mmc_host_is_spi(card->host))
> -		cmd.arg = card->rca << 16;
> -	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> -	err = mmc_wait_for_cmd(card->host, &cmd, retries);
> -	if (err == 0)
> -		*status = cmd.resp[0];
> -	return err;
> -}
> -
>  static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>  		bool hw_busy_detect, struct request *req, bool *gen_err)
>  {
> @@ -908,7 +892,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>  	u32 status;
>  
>  	do {
> -		err = get_card_status(card, &status, 5);
> +		err = mmc_send_status(card, &status);
>  		if (err) {
>  			pr_err("%s: error %d requesting status\n",
>  			       req->rq_disk->disk_name, err);
> @@ -1076,7 +1060,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>  	 * we can't be sure the returned status is for the r/w command.
>  	 */
>  	for (retry = 2; retry >= 0; retry--) {
> -		err = get_card_status(card, &status, 0);
> +		err = mmc_send_status(card, &status);

That is not quite the same because mmc_send_status() does MMC_CMD_RETRIES
retries.  That changes the value and meaning of prev_cmd_status_valid. i.e.
the logic is considering whether the error bits in the status might have
been cleared by the retry.

>  		if (!err)
>  			break;
>  
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 78f75f0..ac4b694 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -76,6 +76,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(mmc_send_status);
>  
>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
> 

