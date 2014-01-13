From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au sizes
Date: Mon, 13 Jan 2014 19:14:09 +0000
Message-ID: <86fvorae4e.fsf@void.printf.net>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
	<20140113124117.GD2586@katana> <861u0bdahb.fsf@void.printf.net>
	<20140113184645.GA17979@katana>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56694 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbaAMTON (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 14:14:13 -0500
In-Reply-To: <20140113184645.GA17979@katana> (Wolfram Sang's message of "Mon,
	13 Jan 2014 19:46:45 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>

Hi,

On Mon, Jan 13 2014, Wolfram Sang wrote:
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f42050..585d44d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/pm_runtime.h>

Thanks, already rebased this change into your original patch, I'll
push the amended version out to mmc-next shortly.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
