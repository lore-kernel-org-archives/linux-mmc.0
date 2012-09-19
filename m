From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: fix the wrong number of max bus clock
Date: Wed, 19 Sep 2012 02:46:07 -0400
Message-ID: <m3392eik7k.fsf@pullcord.laptop.org>
References: <5057F695.5080601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51018 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab2ISGpo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 02:45:44 -0400
In-Reply-To: <5057F695.5080601@samsung.com> (Jaehoon Chung's message of "Tue,
	18 Sep 2012 13:20:37 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Tue, Sep 18 2012, Jaehoon Chung wrote:
> We can use the four bus-clock at sdhci-s3c.c
> But when removed, didn't check the fourth bus clock.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0c77b10..f2b76ef 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -788,7 +788,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	for (ptr = 0; ptr < 3; ptr++) {
> +	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		if (sc->clk_bus[ptr]) {
>  			clk_disable(sc->clk_bus[ptr]);
>  			clk_put(sc->clk_bus[ptr]);

Thanks, pushed to mmc-next for 3.7 with a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
