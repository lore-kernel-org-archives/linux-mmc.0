From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: core: fix permanent sleep of mmcqd during card removal
Date: Mon, 11 Feb 2013 12:00:27 -0500
Message-ID: <87zjzardjo.fsf@octavius.laptop.org>
References: <n@samsung.com>
	<1356513966-24945-1-git-send-email-kdorfman@codeaurora.org>
	<001d01cdf88d$f4214270$dc63c750$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39087 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab3BKRAc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 12:00:32 -0500
In-Reply-To: <001d01cdf88d$f4214270$dc63c750$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 22 Jan 2013 19:48:03 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Konstantin Dorfman' <kdorfman@codeaurora.org>

Hi,

On Tue, Jan 22 2013, Seungwon Jeon wrote:
> This patch is derived from 'mmc: fix async request mechanism ...'.
> According as async transfer, a request is handled with twice mmc_start_req.
> When the card is removed, the request is actually not issued in the first
> mmc_start_req [__mmc_start_data_req]. And then mmc_wait_for_data_req_done
> will come in the next mmc_start_req. But there is no event for completions.
> wake_up_interruptible is needed in __mmc_start_data_req for the case of
> removed card.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b3a122..997b257 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -350,6 +350,7 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
>  	mrq->host = host;
>  	if (mmc_card_removed(host->card)) {
>  		mrq->cmd->error = -ENOMEDIUM;
> +		mmc_wait_data_done(mrq);
>  		return -ENOMEDIUM;
>  	}
>  	mmc_start_request(host, mrq);

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
