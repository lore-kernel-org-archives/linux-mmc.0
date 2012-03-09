From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: add the warning message when card didn't support HPI
Date: Fri, 09 Mar 2012 08:12:05 -0500
Message-ID: <m2r4x1or4q.fsf@bob.laptop.org>
References: <4F59BE26.8070705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58757 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2CINML (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Mar 2012 08:12:11 -0500
In-Reply-To: <4F59BE26.8070705@samsung.com> (Jaehoon Chung's message of "Fri,
	09 Mar 2012 17:24:06 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Fri, Mar 09 2012, Jaehoon Chung wrote:
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
>  drivers/mmc/core/mmc_ops.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 4d41fa9..395f944 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -556,9 +556,15 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
>  	unsigned int flags;
>  	int err;
>  
> +	if (!card->ext_csd.hpi) {
> +		pr_waring("%s: Card didn't support HPI command\n",

This isn't going to compile.  Please compile test patches before sending
them.

> +				mmc_hostname(card->host));
> +		return -EINVAL;
> +	}
> +
>  	opcode = card->ext_csd.hpi_cmd;
>  	if (opcode == MMC_STOP_TRANSMISSION)
> -		flags = MMC_RSP_R1 | MMC_CMD_AC;
> +		flags = MMC_RSP_R1B | MMC_CMD_AC;
>  	else if (opcode == MMC_SEND_STATUS)
>  		flags = MMC_RSP_R1 | MMC_CMD_AC;

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
