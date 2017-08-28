From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/5] mmc: sdhci: Add quirk to indicate MMC_RSP_136 has CRC
Date: Mon, 28 Aug 2017 10:57:32 +0300
Message-ID: <24fa9713-1367-08d7-54b6-b853e32fd6aa@intel.com>
References: <20170821074132.4622-1-kishon@ti.com>
 <20170821074132.4622-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:31148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdH1IEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Aug 2017 04:04:07 -0400
In-Reply-To: <20170821074132.4622-3-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 21/08/17 10:41, Kishon Vijay Abraham I wrote:
> TI's implementation of sdhci controller used in DRA7 SoC's has
> CRC in responses with length 136 bits. Add quirk to indicate
> the controller has CRC in MMC_RSP_136. If this quirk is
> set sdhci library shouldn't shift the response present in
> SDHCI_RESPONSE register.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ba639b7851cb..9c8d7428df3c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1182,6 +1182,9 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>  		cmd->resp[i] = sdhci_readl(host, reg);
>  	}
>  
> +	if (host->quirks2 & SDHCI_QUIRK2_RSP_136_HAS_CRC)
> +		return;
> +
>  	/* CRC is stripped so we need to do some shifting */
>  	for (i = 0; i < 4; i++) {
>  		cmd->resp[i] <<= 8;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 399edc681623..54bc444c317f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -435,6 +435,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> +/* Controller has CRC in 136 bit Command Response */
> +#define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

