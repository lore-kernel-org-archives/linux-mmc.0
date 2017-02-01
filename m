From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/9] mmc: meson-gx: fix setting f_min
Date: Wed, 01 Feb 2017 20:49:30 +0900
Message-ID: <1e55512d-1dc3-bd57-82e1-888553ab3a9e@samsung.com>
References: <CGME20170131210651epcas5p37ca57e71ecbab37efe9b0227e4449d30@epcas5p3.samsung.com>
 <476265c8-b7e8-acdb-1964-5663c629caa3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36697 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdBAMCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:02:38 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKP02QP82S7JV90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2017 21:02:31 +0900 (KST)
In-reply-to: <476265c8-b7e8-acdb-1964-5663c629caa3@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

On 02/01/2017 05:57 AM, Heiner Kallweit wrote:
> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
> I think the itention is to set f_min to 400 kHz.
> Change value and comment accordingly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 5eca88bc..da3cce31 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	if (f_min != UINT_MAX)
>  		f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
>  	else
> -		f_min = 4000000;  /* default min: 400 MHz */
> +		f_min = 400000;  /* default min: 400 kHz */

I'm not sure but f_min can be 100KHz by default, not 400KHz.
Because mmc-core should be try to find frequency from 400KHz to "f_min" value.

Best Regards,
Jaehoon Chung

>  	host->mmc->f_min = f_min;
>  
>  	/* create the mux */
> 

