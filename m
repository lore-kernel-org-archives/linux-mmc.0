From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
Date: Thu, 23 Sep 2010 20:12:57 +0100
Message-ID: <20100923191257.GA2739@void.printf.net>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, akpm@linux-foundation.org, w.sang@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

On Thu, Sep 23, 2010 at 04:22:05PM +0200, Marek Szyprowski wrote:
> If not all clocks has been defined in platform data, driver will cause
> a null pointer dereference when it is being removed. This patch fixes
> this issue.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 71ad416..757d92c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -481,8 +481,10 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 1);
>  
>  	for (ptr = 0; ptr < 3; ptr++) {
> -		clk_disable(sc->clk_bus[ptr]);
> -		clk_put(sc->clk_bus[ptr]);
> +		if (sc->clk_bus[ptr]) {
> +			clk_disable(sc->clk_bus[ptr]);
> +			clk_put(sc->clk_bus[ptr]);
> +		}
>  	}
>  	clk_disable(sc->clk_io);
>  	clk_put(sc->clk_io);

I'll send this to Linus for .36 after you reply with an ACK.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
