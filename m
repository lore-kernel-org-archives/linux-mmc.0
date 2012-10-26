From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 1/1] mmc/card/queue.c: change action when the condition
 of if is true
Date: Fri, 26 Oct 2012 16:39:37 +0530
Message-ID: <508A6F71.40404@ti.com>
References: <1351169953-7734-1-git-send-email-windsdaemon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2JZLJ4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Oct 2012 07:09:56 -0400
In-Reply-To: <1351169953-7734-1-git-send-email-windsdaemon@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wang.Jing.windsdaemon@gmail.com
Cc: Chris Ball <cjb@laptop.org>, Namjae Jeon <linkinjeon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jing Wang <windsdaemon@gmail.com>

On Thursday 25 October 2012 06:29 PM, Wang.Jing.windsdaemon@gmail.com wrote:
> From: Jing Wang <windsdaemon@gmail.com>
Some description of the actual effect of the change here would be nice.
For example, "Trim the error handling path in mmc_alloc_sg".
But what's the point of this patch anyway ? There are 2 "return" statements
instead of one.
>
> Signed-off-by: Jing Wang <windsdaemon@gmail.com>
> ---
>   drivers/mmc/card/queue.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..98a22a1 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -118,13 +118,14 @@ static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
>   	struct scatterlist *sg;
>   
>   	sg = kmalloc(sizeof(struct scatterlist)*sg_len, GFP_KERNEL);
> -	if (!sg)
> +	if (!sg) {
>   		*err = -ENOMEM;
> -	else {
> -		*err = 0;
> -		sg_init_table(sg, sg_len);
> +		return sg;
>   	}
>   
> +	*err = 0;
> +	sg_init_table(sg, sg_len);
> +
>   	return sg;
>   }
>   

