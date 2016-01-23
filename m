From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC PATCH] mmc: remove the MMC_DATA_STREAM flag
Date: Sat, 23 Jan 2016 18:59:21 +0100
Message-ID: <87y4bgb2iu.fsf@belgarion.home>
References: <56978FBF.1080509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:45026 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbcAWR7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Jan 2016 12:59:30 -0500
In-Reply-To: <56978FBF.1080509@samsung.com> (Jaehoon Chung's message of "Thu,
	14 Jan 2016 21:08:31 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fabio Estevam <fabio.estevam@freescale.com>, Ben Dooks <ben-linux@fluff.org>, Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>

Jaehoon Chung <jh80.chung@samsung.com> writes:

> It's not set to MMC_DATA_STREAM anywhere.
> It seems that it had used with CMD11/20. But now CMD11/20 didn't also use.
> I didn't know what is exactly, so i sent the patch as just RFC. 
> If i get some comments for this, i will resend the patch after separate to each host controller.
>
> If MMC_DATA_STREAM can be removed, then flags of data should be then one of
> MMC_DATA_READ and MMC_DATA_WRITE.
The commit message won't pass checkpatch, will it ?

> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1525,13 +1525,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  	}
>  	if (rq_data_dir(req) == READ) {
>  		brq->cmd.opcode = readcmd;
> -		brq->data.flags |= MMC_DATA_READ;
> +		brq->data.flags = MMC_DATA_READ;
Why this chunk ? If the caller had already set some flags of its own, why
overwrite them ? That has no connection to MMC_DATA_STREAM I can see.
...
> -		brq->data.flags |= MMC_DATA_WRITE;
> +		brq->data.flags = MMC_DATA_WRITE;
Ditto.
> -	brq->data.flags |= MMC_DATA_WRITE;
> +	brq->data.flags = MMC_DATA_WRITE;
Ditto.

... drivers not within my area zapped ...

> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index ce08896..4285d3a 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
Works for me.

Cheers.

-- 
Robert
