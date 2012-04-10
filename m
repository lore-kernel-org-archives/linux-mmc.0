From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] davinci_mmc: set MODULE_ALIAS to allow autoloading
Date: Tue, 10 Apr 2012 10:10:42 -0400
Message-ID: <87k41nwucd.fsf@laptop.org>
References: <1333613108-28607-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44196 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338Ab2DJOKn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 10:10:43 -0400
In-Reply-To: <1333613108-28607-1-git-send-email-jlu@pengutronix.de> (Jan
	Luebbe's message of "Thu, 5 Apr 2012 10:05:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Luebbe <jlu@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hi Jan,

On Thu, Apr 05 2012, Jan Luebbe wrote:
> Davinci MMC platform devices (as in mach-davinci/devices-da8xx.c) use
> "davinci_mmc" as their name. To allow autoloading of the relevant
> driver, the module needs to set the MODULE_ALIAS.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  drivers/mmc/host/davinci_mmc.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c1f3673..7cf6c62 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1533,4 +1533,5 @@ module_exit(davinci_mmcsd_exit);
>  MODULE_AUTHOR("Texas Instruments India");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("MMC/SD driver for Davinci MMC controller");
> +MODULE_ALIAS("platform:davinci_mmc");
>  

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
