From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: MAINTAINERS: change omap_hsmmc maintenance to orphan
Date: Mon, 28 Jan 2013 16:33:43 -0500
Message-ID: <8738xl8020.fsf@laptop.org>
References: <1358343026-17198-1-git-send-email-svenkatr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1358343026-17198-1-git-send-email-svenkatr@gmail.com>
	(Venkatraman S.'s message of "Wed, 16 Jan 2013 19:00:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 16 2013, Venkatraman S wrote:
> The specified email id is no longer in service.
> Update the OMAP HSMMC entry from the MAINTAINERS file as I will
> no longer be able to maintain this driver.
>
> Signed-off-by: Venkatraman S <svenkatr@gmail.com>
> ---
>  MAINTAINERS |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd5b31f..95778e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5499,10 +5499,8 @@ S:	Maintained
>  F:	drivers/mmc/host/omap.c
>  
>  OMAP HS MMC SUPPORT
> -M:	Venkatraman S <svenkatr@ti.com>
> -L:	linux-mmc@vger.kernel.org
>  L:	linux-omap@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/mmc/host/omap_hsmmc.c
>  
>  OMAP RANDOM NUMBER GENERATOR SUPPORT

Thanks for your work on omap_hsmmc, Venkat!

Is anyone else interested in taking up maintenance of omap_hsmmc?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
