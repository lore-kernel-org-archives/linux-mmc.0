From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: add the debug message for SET_BLOCK_COUNT
Date: Sat, 11 Feb 2012 16:06:11 -0500
Message-ID: <m2r4y1krlo.fsf@bob.laptop.org>
References: <4F30B2E6.60406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41878 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab2BKVGS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Feb 2012 16:06:18 -0500
In-Reply-To: <4F30B2E6.60406@samsung.com> (Jaehoon Chung's message of "Tue, 07
	Feb 2012 14:13:10 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Tue, Feb 07 2012, Jaehoon Chung wrote:
> This patch is added just debug message.
> Almost features need to use the CMD23.
> But we didn't see the debug message for sbc.
> If sbc's message can see, should be help for debugging.
> (We can check whether use the cmd23 or not)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8a19143..6b72eb8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -188,6 +188,12 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  	struct scatterlist *sg;
>  #endif
>  
> +	if (mrq->sbc) {
> +		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
> +			 mmc_hostname(host), mrq->sbc->opcode,
> +			 mrq->sbc->arg, mrq->sbc->flags);
> +	}
> +
>  	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
>  		 mmc_hostname(host), mrq->cmd->opcode,
>  		 mrq->cmd->arg, mrq->cmd->flags);

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
