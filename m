From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mmc: tmio: add barriers to IO operations
Date: Thu, 24 Jan 2013 20:10:18 +0900
Message-ID: <20130124111018.GC5724@linux-sh.org>
References: <Pine.LNX.4.64.1301231745130.26301@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1301231745130.26301@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 23, 2013 at 05:46:18PM +0100, Guennadi Liakhovetski wrote:
> Without barriers SDIO operations fail with runtime PM enabled.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/host/tmio_mmc.h |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index d857f5c..ad1a1c6 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -159,19 +159,20 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
>  
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> -	return readw(host->ctl + (addr << host->bus_shift));
> +	return ioread16(host->ctl + (addr << host->bus_shift));
>  }
>  
>  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
>  		u16 *buf, int count)
>  {
> +	wmb();
>  	readsw(host->ctl + (addr << host->bus_shift), buf, count);
>  }
>  
Some reason to not use ioread16_rep() and friends?
