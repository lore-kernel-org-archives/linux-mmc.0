From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/3] drivers/mmc/host/mvsdio.c: Convert release_resource to
 release_mem_region
Date: Tue, 22 Mar 2011 15:04:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1103221503100.11889@xanadu.home>
References: <1300814095-25278-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:25013 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab1CVTEc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 15:04:32 -0400
In-reply-to: <1300814095-25278-1-git-send-email-julia@diku.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Miroslaw <mirq-linux@rere.qmqm.pl>, Anton Vorontsov <cbouatmailru@gmail.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Sascha Sommer <saschasommer@freenet.de>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Tue, 22 Mar 2011, Julia Lawall wrote:

> Request_mem_region should be used with release_mem_region, not
> release_resource.
> 
> A semantic patch that partially fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @b@
> expression x,E;
> @@
> 
> x = request_mem_region(x->start,...)
> ... when != release_mem_region(x->start,...)
>     when != x = E
> (
> - release_resource(x);
> - kfree(x);
> +  release_mem_region(x->start,resource_size(x));
> |
> ?- release_resource(x);
> +  release_mem_region(x->start,resource_size(x));
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  drivers/mmc/host/mvsdio.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index a5bf60e..4606087 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -825,7 +825,7 @@ out:
>  			iounmap(host->base);
>  	}
>  	if (r)
> -		release_resource(r);
> +		release_mem_region(r->start, resource_size(r));
>  	if (mmc)
>  		mmc_free_host(mmc);
>  
> @@ -850,7 +850,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
>  		del_timer_sync(&host->timer);
>  		mvsd_power_down(host);
>  		iounmap(host->base);
> -		release_resource(host->res);
> +		release_mem_region(host->res->start, resource_size(host->res));
>  		mmc_free_host(mmc);
>  	}
>  	platform_set_drvdata(pdev, NULL);
> 
