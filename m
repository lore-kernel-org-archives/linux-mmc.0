From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_spi: Fix return value evaluation of irq_of_parse_and_map()
Date: Mon, 11 Feb 2013 11:49:11 -0500
Message-ID: <878v6ussmw.fsf@octavius.laptop.org>
References: <1359565508-13362-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359565508-13362-1-git-send-email-stigge@antcom.de> (Roland
	Stigge's message of "Wed, 30 Jan 2013 18:05:08 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: plagnioj@jcrosoft.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 30 2013, Roland Stigge wrote:
> When irq_of_parse_and_map() returns an error, it does as zero. But in
> mmc_spi_get_pdata(), the error return case is compared against NO_IRQ. This
> might work where NO_IRQ is zero (defaults to zero when undefined, as on MIPS)
> but not where NO_IRQ is sth. different, e.g. on ARM, where it is -1.
>
> This patch changes to comparison with 0 which is the error return value of
> irq_of_parse_and_map(). 
>
> Tested on ARM that mmc_spi is working now.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 1534b58..d720b5e 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -146,7 +146,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  		oms->pdata.get_ro = of_mmc_spi_get_ro;
>  
>  	oms->detect_irq = irq_of_parse_and_map(np, 0);
> -	if (oms->detect_irq != NO_IRQ) {
> +	if (oms->detect_irq != 0) {
>  		oms->pdata.init = of_mmc_spi_init;
>  		oms->pdata.exit = of_mmc_spi_exit;
>  	} else {

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
