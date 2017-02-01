From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/9] mmc: meson-gx: minor improvements in meson_mmc_set_ios
Date: Wed, 01 Feb 2017 20:55:55 +0900
Message-ID: <a32d463d-2af2-8d20-9585-f76af566d623@samsung.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
 <CGME20170131210832epcas2p111e35a63c02a8e4ddc83354a691d92ee@epcas2p1.samsung.com>
 <834a9dbd-9f6b-8dea-6713-e9bdcd09f9ed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39257 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBALz6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 06:55:58 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKP02PPT2H8LC90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2017 20:55:56 +0900 (KST)
In-reply-to: <834a9dbd-9f6b-8dea-6713-e9bdcd09f9ed@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

On 02/01/2017 05:57 AM, Heiner Kallweit wrote:
> val isn't used in the switch clause and afterwards there's an
> identical statement. So remove it.
> 
> In case of an unexpected bus width the error message indicates
> the intention to set the bus width to 4 and to go on.
> So remove the return statement. This return statement also
> conflicts with "setting to 4" because nothing would be set
> actually before returning.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index da3cce31..38edc60d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -379,7 +379,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	meson_mmc_clk_set(host, ios->clock);
>  
>  	/* Bus width */
> -	val = readl(host->regs + SD_EMMC_CFG);
>  	switch (ios->bus_width) {
>  	case MMC_BUS_WIDTH_1:
>  		bus_width = CFG_BUS_WIDTH_1;
> @@ -394,7 +393,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
>  			ios->bus_width);
>  		bus_width = CFG_BUS_WIDTH_4;
> -		return;

It's a different question..why does meson-gx-mmc use 4bit buswidth for invalid bus-with? not using 1bit-buswidth?

Best Regards,
Jaehoon Chung

>  	}
>  
>  	val = readl(host->regs + SD_EMMC_CFG);
> 

