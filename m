From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 12/13] mmc: add DT bindings for more MMC capability
 flags
Date: Sun, 17 Feb 2013 02:58:42 +0300
Message-ID: <51201D32.20006@cogentembedded.com>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de> <1360941242-18153-13-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360941242-18153-13-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02/15/2013 06:14 PM, Guennadi Liakhovetski wrote:

> Many MMC capability flags are platform-dependent and are traditionally set
> in platform data. With DT often each such capability requires a special
> binding. Add bindings for MMC_CAP_SD_HIGHSPEED, MMC_CAP_MMC_HIGHSPEED,
> MMC_CAP_POWER_OFF_CARD and MMC_CAP_SDIO_IRQ capabilities. Also add code to
> DT parser to look up "keep-power-in-suspend" and "enable-sdio-wakeup"
> bindings and set MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ respectively,
> if found.
>
> Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> ---
>   Documentation/devicetree/bindings/mmc/mmc.txt |    4 ++++
>   drivers/mmc/core/host.c                       |   13 +++++++++++++
>   2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 24c8552..d9ab51f 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -25,6 +25,10 @@ Optional properties:
>   - max-frequency: maximum operating clock frequency
>   - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>     this system, even if the controller claims it is.
> +- cap-sd-highspeed: SD high-speed timing is supported
> +- cap-mmc-highspeed: MMC high-speed timing is supported
> +- cap-power-off-card: powering off the card is safe
> +- cap-sdio-irq: enable SDIO IRQ signalling on this interface
>
>   *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>   polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index daa2ed1..1365466 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -398,6 +398,19 @@ void mmc_of_parse(struct mmc_host *host)
>   	}
>   	if (explicit_inv_wp ^ gpio_inv_wp)
>   		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> +
> +	if (of_find_property(np, "cap-sd-highspeed",&len))
> +		host->caps |= MMC_CAP_SD_HIGHSPEED;
> +	if (of_find_property(np, "cap-mmc-highspeed",&len))
> +		host->caps |= MMC_CAP_MMC_HIGHSPEED;
> +	if (of_find_property(np, "cap-power-off-card",&len))
> +		host->caps |= MMC_CAP_POWER_OFF_CARD;
> +	if (of_find_property(np, "cap-sdio-irq",&len))
> +		host->caps |= MMC_CAP_SDIO_IRQ;
> +	if (of_find_property(np, "keep-power-in-suspend",&len))
> +		host->pm_caps |= MMC_PM_KEEP_POWER;
> +	if (of_find_property(np, "enable-sdio-wakeup",&len))
> +		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>    

    Why are you not using of_property_read_bool() instead?

WBR, Sergei

