From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 08/10] mmc: card: Use R1 response for the stop cmd at
 recovery path
Date: Thu, 23 Jan 2014 12:09:52 +0200
Message-ID: <52E0EA70.9010308@intel.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org> <1390402824-9850-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1626 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbaAWKIT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jan 2014 05:08:19 -0500
In-Reply-To: <1390402824-9850-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 22/01/14 17:00, Ulf Hansson wrote:
> Hosts supporting MMC_CAP_WAIT_WHILE_BUSY shall not be waiting for busy
> detection completion in the recovery path, which were the case when
> using R1B response.
> 
> Start using R1 as response instead to align behavior, no matter if
> MMC_CAP_WAIT_WHILE_BUSY is supported or not.

This does not make sense to me.  If you are sending a STOP command you
should use the correct response type.  R1B should be OK here because the
card should release the busy signal in any case except failure.

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 87cd2b0..74169fa 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -728,7 +728,7 @@ static int send_stop(struct mmc_card *card, u32 *status)
>  	int err;
>  
>  	cmd.opcode = MMC_STOP_TRANSMISSION;
> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>  	err = mmc_wait_for_cmd(card->host, &cmd, 5);
>  	if (err == 0)
>  		*status = cmd.resp[0];
> 

