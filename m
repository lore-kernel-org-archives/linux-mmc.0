From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch] mmc: check correct variable after kzalloc()
Date: Tue, 12 Feb 2013 07:27:26 -0500
Message-ID: <87pq05ogy9.fsf@octavius.laptop.org>
References: <20130212122454.GC19045@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56503 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933022Ab3BLM1e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Feb 2013 07:27:34 -0500
In-Reply-To: <20130212122454.GC19045@elgon.mountain> (Dan Carpenter's message
	of "Tue, 12 Feb 2013 15:24:54 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, kbuild@01.org, kernel-janitors@vger.kernel.org

Hi Dan,

On Tue, Feb 12 2013, Dan Carpenter wrote:
> There is a typo here so we check "mqrq_cur->packed" instead of
> "mqrq_prev->packed".
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index c0d1315..97a848b 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -378,7 +378,7 @@ int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
>  	}
>  
>  	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
> -	if (!mqrq_cur->packed) {
> +	if (!mqrq_prev->packed) {
>  		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
>  			   mmc_card_name(card));
>  		kfree(mqrq_cur->packed);
>

Thanks, this is already fixed via a rebase edit to to the original patch
in mmc-next.  (Fengguang's 0-day bot caught it.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
