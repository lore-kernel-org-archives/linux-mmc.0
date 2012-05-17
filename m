From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: at91-mci: this driver is now deprecated
Date: Thu, 17 May 2012 08:45:31 -0400
Message-ID: <87k40b3ris.fsf@laptop.org>
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
	<1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43618 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932645Ab2EQMpc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 May 2012 08:45:32 -0400
In-Reply-To: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Wed, 16 May 2012 17:51:59 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

Hi,

On Wed, May 16 2012, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> at91-mci is deprecated since atmel-mci can deal with all chips.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  drivers/mmc/host/Kconfig                   |    7 +++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 03ca210..8b4aef2 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -539,3 +539,14 @@ When:	3.6
>  Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
>  	violates the spec.
>  Who:	Sasikantha Babu <sasikanth.v19@gmail.com>
> +
> +----------------------------
> +
> +What:	at91-mci driver ("CONFIG_MMC_AT91")
> +When:	3.7
> +Why:	There two mci drivers: at91-mci and atmel-mci. The PDC support was
             ^ are

> +	added to atmel-mci as a first step to support more chips. Then
> +	at91-mci was kept only for old IP versions (on at91rm9200 and
> +	at91sam9261). The support of these IP versions has just been added
> +	so atmel-mci can be used for all chips.
> +Who:	Ludovic Desroches <ludovic.desroches@atmel.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2bc06e7..f150591 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -278,10 +278,13 @@ choice
>  	  Choose which driver to use for the Atmel MCI Silicon
>  
>  config MMC_AT91
> -	tristate "AT91 SD/MMC Card Interface support"
> +	tristate "AT91 SD/MMC Card Interface support (DEPRECATED)"
>  	depends on ARCH_AT91
>  	help
> -	  This selects the AT91 MCI controller.
> +	  This selects the AT91 MCI controller. This driver will be
> +	  remove soon (for more information have a look to
          ^ removed
> +	  Documentation/feature-removal-schedule.txt). Please use
> +	  MMC_ATMEL_MCI.
>  
>  	  If unsure, say N.

Seems like I should take this patch 2/2, and then someone else should
merge 1/2?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
