Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48E43169;
	Fri,  1 Aug 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042565; cv=none; b=rQ++v6Q5tuDkg7iCPL1XvniiNmhPoFZXvGCA0Ex4C9IGhcQ4bEFcepEID4eDryfWli3Vl/OlLK/LkOGXgiwmOvZPcyj6i5uGyBAIla2yWu532KahGA3XDlh1Lf507WINu3sirahr56InwyWfJyVyzi1iIdVQ0yUInfSfXuJMAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042565; c=relaxed/simple;
	bh=PQTdbHWk76OpgeQjhGtCUlTLwNSWy0TCHQwpI0BRDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlT0qAfLgCaDVShZDz8cbrGsxnIYZxcvqP0aeZbT273JfrcTFyfBq3rqoyrO6olCGA/DvTN471x5i6cRCnt7xPhia0pHCy9F1/l1wAaN94ZtneKKz0LyDzwdhE2UrSSLPxqI1zCeRjiHXlCscnboiDqfCYgn/yvC/sX6GcjRuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQEQUW7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQEQUW7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CC9C4CEF4;
	Fri,  1 Aug 2025 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754042564;
	bh=PQTdbHWk76OpgeQjhGtCUlTLwNSWy0TCHQwpI0BRDXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQEQUW7pL2l9snCH+ToOQ7UjW/i020662mBYW+l2Q62jMcNfVJDUM8OWt5Rv+5zDN
	 cQsCZyFS/YJBeaqDN10xm0JyEOY2EudDuaRdkV1eKtvY/YcF2h9hw3B0SxyPU73oVc
	 6StnirPifFnWHwR8+GPAEZXq2AtWX8qugz1obnE0=
Date: Fri, 1 Aug 2025 11:02:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: maximlevitsky@gmail.com, kai.heng.feng@canonical.com, oakad@yahoo.com,
	ulf.hansson@linaro.org, luoqiu@kylinsec.com.cn,
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jiayi_dec@163.com
Subject: Re: [PATCH] memstick: Fix deadlock by moving removing flag earlier
Message-ID: <2025080132-pacifist-spiritism-0cbe@gregkh>
References: <20250801094459.318184-1-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801094459.318184-1-lijiayi@kylinos.cn>

On Fri, Aug 01, 2025 at 05:44:59PM +0800, Jiayi Li wrote:
> The existing memstick core patch: commit 62c59a8786e6 ("memstick: Skip
> allocating card when removing host") sets host->removing in
> memstick_remove_host(),but still exists a critical time window where
> memstick_check can run after host->eject is set but before removing is set.
> 
> In the rtsx_usb_ms driver, the problematic sequence is:
> 
> rtsx_usb_ms_drv_remove:          memstick_check:
>   host->eject = true
>   cancel_work_sync(handle_req)     if(!host->removing)
>   ...                              memstick_alloc_card()
>                                      memstick_set_rw_addr()
>                                        memstick_new_req()
>                                          rtsx_usb_ms_request()
>                                            if(!host->eject)
>                                            skip schedule_work
>                                        wait_for_completion()
>   memstick_remove_host:                [blocks indefinitely]
>     host->removing = true
>     flush_workqueue()
>     [block]
> 
> 1. rtsx_usb_ms_drv_remove sets host->eject = true
> 2. cancel_work_sync(&host->handle_req) runs
> 3. memstick_check work may be executed here <-- danger window
> 4. memstick_remove_host sets removing = 1
> 
> During this window (step 3), memstick_check calls memstick_alloc_card,
> which may indefinitely waiting for mrq_complete completion that will
> never occur because rtsx_usb_ms_request sees eject=true and skips
> scheduling work, memstick_set_rw_addr waits forever for completion.
> 
> This causes a deadlock when memstick_remove_host tries to flush_workqueue,
> waiting for memstick_check to complete, while memstick_check is blocked
> waiting for mrq_complete completion.
> 
> Fix this by setting removing=true at the start of rtsx_usb_ms_drv_remove,
> before any work cancellation. This ensures memstick_check will see the
> removing flag immediately and exit early, avoiding the deadlock.
> 
> Fixes: 62c59a8786e6 ("memstick: Skip allocating card when removing host")
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>  drivers/memstick/core/memstick.c    | 1 -
>  drivers/memstick/host/rtsx_usb_ms.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 043b9ec756ff..95e65f4958f2 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -555,7 +555,6 @@ EXPORT_SYMBOL(memstick_add_host);
>   */
>  void memstick_remove_host(struct memstick_host *host)
>  {
> -	host->removing = 1;
>  	flush_workqueue(workqueue);
>  	mutex_lock(&host->lock);
>  	if (host->card)
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 3878136227e4..5b5e9354fb2e 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -812,6 +812,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>  	int err;
>  
>  	host->eject = true;
> +	msh->removing = true;
>  	cancel_work_sync(&host->handle_req);
>  	cancel_delayed_work_sync(&host->poll_card);
>  
> -- 
> 2.47.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
