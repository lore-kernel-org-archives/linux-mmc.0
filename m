From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] mmc: sdhci-s3c: fix wrong error-control
Date: Wed, 12 Oct 2011 11:19:17 -0400
Message-ID: <m2mxd6i6fe.fsf@bob.laptop.org>
References: <4E951425.4000807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57473 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab1JLPT3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Oct 2011 11:19:29 -0400
In-Reply-To: <4E951425.4000807@samsung.com> (Jaehoon Chung's message of "Wed,
	12 Oct 2011 13:14:29 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, Oct 12 2011, Jaehoon Chung wrote:
> If sc->clk_bus[ptr] is NULL, happen NULL pointer error.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82709b6..3d00e72 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -567,8 +567,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>   err_req_regs:
>  	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
> -		clk_disable(sc->clk_bus[ptr]);
> -		clk_put(sc->clk_bus[ptr]);
> +		if (sc->clk_bus[ptr]) {
> +			clk_disable(sc->clk_bus[ptr]);
> +			clk_put(sc->clk_bus[ptr]);
> +		}
>  	}
>  
>   err_no_busclks:

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
