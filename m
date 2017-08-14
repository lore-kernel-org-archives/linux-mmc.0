From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] mmc/sdhci-s3c: use generic sdhci_set_bus_width()
Date: Mon, 14 Aug 2017 15:05:24 +0300
Message-ID: <383b2721-72f7-f88e-1d16-8f7b0a27df77@intel.com>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
 <4323de12fe8bf8c33211a39a5fb14563fb80f2e9.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4323de12fe8bf8c33211a39a5fb14563fb80f2e9.1502310654.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/08/17 23:36, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>

There always needs to be a commit message. i.e.

"Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
MMC_CAP_8_BIT_DATA capability flag, replace the sdhci-s3c version with the
generic sdhci version."

Also subject should begin "mmc: sdhci-s3c: "...

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


> ---
>  drivers/mmc/host/sdhci-s3c.c | 34 +---------------------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 7c065a70f92b..d328fcf284d1 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -414,43 +414,11 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  }
>  
> -/**
> - * sdhci_s3c_set_bus_width - support 8bit buswidth
> - * @host: The SDHCI host being queried
> - * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
> - *
> - * We have 8-bit width support but is not a v3 controller.
> - * So we add platform_bus_width() and support 8bit width.
> - */
> -static void sdhci_s3c_set_bus_width(struct sdhci_host *host, int width)
> -{
> -	u8 ctrl;
> -
> -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -
> -	switch (width) {
> -	case MMC_BUS_WIDTH_8:
> -		ctrl |= SDHCI_CTRL_8BITBUS;
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> -		break;
> -	case MMC_BUS_WIDTH_4:
> -		ctrl |= SDHCI_CTRL_4BITBUS;
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> -		break;
> -	default:
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> -		break;
> -	}
> -
> -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> -}
> -
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
>  	.get_min_clock		= sdhci_s3c_get_min_clock,
> -	.set_bus_width		= sdhci_s3c_set_bus_width,
> +	.set_bus_width		= sdhci_set_bus_width,
>  	.reset			= sdhci_reset,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  };
> 
