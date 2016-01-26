From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Mon, 25 Jan 2016 21:34:04 -0700
Message-ID: <56A6F73C.3030209@wwwdotorg.org>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453042744-16196-5-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 01/17/2016 07:59 AM, Stefan Wahren wrote:
> Scott Branden from Broadcom said that the BCM2835 eMMC IP core is
> very similar to IPROC and share most of the quirks. So use this driver
> instead of separate one.
> 
> The sdhci-iproc contains a better workaround for the clock domain
> crossing problem which doesn't need any delays. This results in a
> better write performance.
> 
> Btw we get the rid of the SDHCI_CAPABILITIES hack in the sdhci_readl
> function.

> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c

> +static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
> +		| SDHCI_QUIRK_MISSING_CAPS,
> +	.ops = &sdhci_iproc_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm2835_data = {
> +	.pdata = &sdhci_bcm2835_pltfm_data,
> +	.caps = SDHCI_CAN_VDD_330,
> +	.caps1 = 0x00000000,
> +};

> @@ -199,8 +213,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)

> -	/* Enable EMMC 1/8V DDR capable */
> -	host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +	if (of_device_is_compatible(np, "brcm,sdhci-iproc-cygnus")) {
> +		/* Enable EMMC 1/8V DDR capable */
> +		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +	}

Rather that placing device-specific of_device_is_compatible() throughout
the driver, I think it'd be better to key off a field in bcm2835_data or
sdhci_bcm2835_pltfm_data. That way, if the driver starts supporting
additional devices that want this MMC_CAP_1_8V_DDR, you can simply set
that up in the relevant data structure, rather than adding a mess of
of_device_is_compatible("a") || of_device_is_compatible("b") || ... to
the code.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
