From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: rewrite CLKDIV computation
Date: Wed, 27 Mar 2013 21:25:18 +0900
Message-ID: <000b01ce2ae6$249bfb90$6dd3f2b0$%jun@samsung.com>
References: <1364338202-10311-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39647 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3C0MZV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 08:25:21 -0400
In-reply-to: <1364338202-10311-1-git-send-email-grundler@chromium.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Grant Grundler' <grundler@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Doug Anderson' <dianders@chromium.org>, 'Will Newton' <will.newton@gmail.com>, 'Bing Zhao' <bzhao@marvell.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ashok Nagarajan' <asnagarajan@chromium.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, March 27, 2013, Grant Grundler wrote:
> Last year Seungwon Jeon (Samsung) fixed a bug in CLKDIV computation.
For easily identifying, it would be good to point the commit id and subject.
> But when debugging a related issue (http://crbug.com/221828) I found
It is not easy to catch up issue in your site. What problem is bothering you?
Could you describe the problem and conditions you have found?

Thanks,
Seungwon Jeon

> the code unreadable.  This rewrite simplifies the computation and
> explains each step.
> 
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
> Tested on Samsung Series 3 Chromebook (exynos 5250 chipset) using
> ChromeOS 3.4 kernel (not 3.9-rc3 which this patch is based against).
> 
> I've written a test program to confirm this patch generates the
> same correct values and will share that separately.
> 
>  drivers/mmc/host/dw_mmc.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9834221..6fdf55b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -631,14 +631,22 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> 
>  	if (slot->clock != host->current_speed || force_clkinit) {
>  		div = host->bus_hz / slot->clock;
> -		if (host->bus_hz % slot->clock && host->bus_hz > slot->clock)
> -			/*
> -			 * move the + 1 after the divide to prevent
> -			 * over-clocking the card.
> +		if (host->bus_hz > slot->clock) {
> +			/* don't overclock due to integer math losses */
> +			if ((div * slot->clock) < host->bus_hz)
> +				div++;
> +
> +			/* don't overclock due to resolution of HW */
> +			if (div & 1)
> +				div++;
> +
> +			/* See 6.2.3 CLKDIV in "Mobile Storage Host Databook"
> +			 * Look for dwc_mobile_storage_db.pdf from Synopsys.
> +			 * CLKDIV value 0 means divisor 1, val 1 -> 2, ...
>  			 */
> -			div += 1;
> -
> -		div = (host->bus_hz != slot->clock) ? DIV_ROUND_UP(div, 2) : 0;
> +			div /= 2;
> +		} else
> +			div = 0;        /* use bus_hz */
> 
>  		dev_info(&slot->mmc->class_dev,
>  			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ"
> --
> 1.8.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

