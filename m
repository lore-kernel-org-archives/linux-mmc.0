From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH]mmc: core: check PM_SLEEP for mmc_bus_suspend/resume callbacks
Date: Mon, 23 Apr 2012 08:11:47 -0400
Message-ID: <87fwbufy0s.fsf@laptop.org>
References: <20120423071802.GA14743@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53443 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518Ab2DWMLc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Apr 2012 08:11:32 -0400
In-Reply-To: <20120423071802.GA14743@intel.com> (Chuanxiao Dong's message of
	"Mon, 23 Apr 2012 15:18:02 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, andrew@lunn.ch

Hi,

On Mon, Apr 23 2012, Chuanxiao Dong wrote:
> If PM_SLEEP is not enabled, mmc.c will give warnning since mmc_bus_suspend/
> mmc_bus_resume functions are defined but not used. This patch can fix this
> warnning.
>
> Found-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/core/bus.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index c60cee9..9b68933 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -122,6 +122,7 @@ static int mmc_bus_remove(struct device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int mmc_bus_suspend(struct device *dev)
>  {
>  	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> @@ -143,6 +144,7 @@ static int mmc_bus_resume(struct device *dev)
>  		ret = drv->resume(card);
>  	return ret;
>  }
> +#endif
>  
>  #ifdef CONFIG_PM_RUNTIME

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
