From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: Remove redundant null check before kfree in sdio_bus.c
Date: Mon, 03 Dec 2012 14:18:06 -0500
Message-ID: <87pq2rhrm9.fsf@octavius.laptop.org>
References: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36113 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2LCTSL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:18:11 -0500
In-Reply-To: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Tue, 20 Nov 2012 14:43:16 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org

Hi Sachin,

On Tue, Nov 20 2012, Sachin Kamat wrote:
> kfree on a null pointer is a no-op.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/core/sdio_bus.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 6bf6879..fdcf9e3 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -258,8 +258,7 @@ static void sdio_release_func(struct device *dev)
>  
>  	sdio_free_func_cis(func);
>  
> -	if (func->info)
> -		kfree(func->info);
> +	kfree(func->info);
>  
>  	kfree(func);
>  }

Thanks, pushed both patches to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
