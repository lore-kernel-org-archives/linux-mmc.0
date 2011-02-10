From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Ensure prototypes for SD API are visible in sd.c
Date: Thu, 10 Feb 2011 19:50:37 +0000
Message-ID: <20110210195037.GD19076@void.printf.net>
References: <1297335517-26248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56318 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756375Ab1BJTui (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 14:50:38 -0500
Content-Disposition: inline
In-Reply-To: <1297335517-26248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, patches@opensource.wolfsonmicro.com

Hi Mark,

On Thu, Feb 10, 2011 at 10:58:37AM +0000, Mark Brown wrote:
> So we know the implementation and prototypes agree with each other.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/mmc/core/sd.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d18c32b..6dac89f 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -21,6 +21,7 @@
>  #include "core.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "sd.h"
>  #include "sd_ops.h"
>  
>  static const unsigned int tran_exp[] = {

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
