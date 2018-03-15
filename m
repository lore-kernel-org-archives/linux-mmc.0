From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 05/11] mmc: sdhci: Disable HS200 mode if controller
 can't support 1.8v
Date: Thu, 15 Mar 2018 12:58:37 +0200
Message-ID: <fc379441-ed8e-47b4-f34b-d4137d158ec6@intel.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-6-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-6-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Though MMC controller can indicate HS200 mode capability (by
> using "mmc-hs200-1_8v" dt property), if the IO lines in the board
> is connected to 3.3v supply, HS200 mode cannot be supported.
> Such boards have "no-1-8-v" property in their dts file. Disable HS200
> mode for boards which have "no-1-8-v" set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ededa7f43df..aa8b5ca0d1b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>  		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>  				 SDHCI_SUPPORT_DDR50);
> +		mmc->caps2 &= ~MMC_CAP2_HS200;

Pedantically, shouldn't that be:

	~(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)

We have MMC_CAP2_HSX00_1_2V so maybe we should add:

	#define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)

And then

		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;

>  	}
>  
>  	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
> 
