From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Improve MMC_TEST config text.
Date: Thu, 10 Feb 2011 19:48:27 +0000
Message-ID: <20110210194827.GC19076@void.printf.net>
References: <AANLkTinps7xSofxw8opY4A5X=14jT+EE4P2bo=-F16q_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56303 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab1BJTs2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 14:48:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinps7xSofxw8opY4A5X=14jT+EE4P2bo=-F16q_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Feb 10, 2011 at 10:41:02AM +0000, Will Newton wrote:
> The test file is created under debugfs, not sysfs. Also remove
> the unnecessary default n.
> 
> Signed-off-by: Will Newton <will.newton@imgtec.com>
> ---
>  drivers/mmc/card/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
> index 2a876c4..3b1f783 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -58,12 +58,11 @@ config SDIO_UART
> 
>  config MMC_TEST
>  	tristate "MMC host test driver"
> -	default n
>  	help
>  	  Development driver that performs a series of reads and writes
>  	  to a memory card in order to expose certain well known bugs
>  	  in host controllers. The tests are executed by writing to the
> -	  "test" file in sysfs under each card. Note that whatever is
> +	  "test" file in debugfs under each card. Note that whatever is
>  	  on your card will be overwritten by these tests.
> 
>  	  This driver is only of interest to those developing or

Pushed to mmc-next for .39, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
