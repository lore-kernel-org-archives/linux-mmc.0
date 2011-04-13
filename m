From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH] MMC: Fix use of uninitialized data in mmc_cmd_app.
Date: Wed, 13 Apr 2011 14:04:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104131400420.13863@peruna>
References: <1302726792-4733-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:41996 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932296Ab1DMVFK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 17:05:10 -0400
In-Reply-To: <1302726792-4733-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, 13 Apr 2011, Andrei Warkentin wrote:

> mmc_cmd_app did not zero out mmc_command on stack.
> 
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/core/sd_ops.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 76af349..71fdb07 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -29,6 +29,8 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>  	BUG_ON(!host);
>  	BUG_ON(card && (card->host != host));
>  
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +
>  	cmd.opcode = MMC_APP_CMD;
>  
>  	if (card) {
> -- 

Out of curiosity, why is:

	memset(&cmd, 0, sizeof(struct mmc_command));

preferred over:

	struct mmc_command cmd = {0};


John
