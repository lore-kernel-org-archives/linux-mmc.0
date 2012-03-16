From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: add the warning message when card didn't support HPI
Date: Thu, 15 Mar 2012 23:36:42 -0400
Message-ID: <87y5r1b4j9.fsf@laptop.org>
References: <4F5D3BE7.3080601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46509 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275Ab2CPDgg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 23:36:36 -0400
In-Reply-To: <4F5D3BE7.3080601@samsung.com> (Jaehoon Chung's message of "Mon,
	12 Mar 2012 08:57:27 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Sun, Mar 11 2012, Jaehoon Chung wrote:
> Though card didn't support HPI,someone could use the send_hpi_cmd().
> Then maybe didn't work fine.
> Because card->ext_csd.hpi_cmd didn't set.
> So if card didn't support hpi, return the waring message.
>
> And CMD12's flags is MMC_RSP_R1B.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v2:
> 	- Fixed typo and removed the flags variable.
>
>  drivers/mmc/core/mmc_ops.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 4d41fa9..30f45be 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -553,18 +553,22 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
>  {
>  	struct mmc_command cmd = {0};
>  	unsigned int opcode;
> -	unsigned int flags;
>  	int err;
>  
> +	if (!card->ext_csd.hpi) {
> +		pr_warning("%s: Card didn't support HPI command\n",
> +				mmc_hostname(card->host));
> +		return -EINVAL;
> +	}
> +
>  	opcode = card->ext_csd.hpi_cmd;
>  	if (opcode == MMC_STOP_TRANSMISSION)
> -		flags = MMC_RSP_R1 | MMC_CMD_AC;
> +		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>  	else if (opcode == MMC_SEND_STATUS)
> -		flags = MMC_RSP_R1 | MMC_CMD_AC;
> +		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  
>  	cmd.opcode = opcode;
>  	cmd.arg = card->rca << 16 | 1;
> -	cmd.flags = flags;
>  	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
>  
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
