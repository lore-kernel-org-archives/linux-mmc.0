From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] MMC: mmci: Add required documentation for Device Tree bindings
Date: Thu, 15 Mar 2012 17:53:25 +0000
Message-ID: <201203151753.25774.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54575 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031933Ab2CORxm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:53:42 -0400
In-Reply-To: <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On Wednesday 14 March 2012, Lee Jones wrote:

Some more comments about the individual properties

> +Required properties:
> +- compatible             : contains "arm,pl18x", "arm,primecell".

Better use the exact number for 'x' here.

> +- reg                    : contains pl18x registers and length.
> +- interrupts             : contains the device IRQ(s).

You should document what the first and second interrupts are,
respectively, if there is more than one.

> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.

This one should be optional.

> +
> +Optional properties:
> +- ocr_mask               : contains the regulator oscillator mask

Not sure about this one. If it's for the regulators, we should be
using the regulator bindings.

> +- wp-gpios               : contains any write protect (ro) gpios
> +- cd-gpios               : contains any card detection gpios
> +- cd-invert              : indicates whether the cd gpio is inverted 
> +- clock_frequency        : contains the maximum operating frequency

The name should be 'clock-frequency', not 'clock_frequency'.

> +- mmc_cap_4_bit_data     : indicates whether device is 4 bit capable
> +- mmc_cap_8_bit_data     : indicates whether device is 8 bit capable
> +- mmc_cap_mmc_highspeed  : indicates whether MMC is high speed capable
> +- mmc_cap_sd_highspeed   : indicates whether SD is high speed capable

I would strongly recommend using the same naming as sdhci here. I think
tegra has set a precedent.

> +ux500 variant specific properties:
> +- gpio-en                : contains the level-shifter enable gpio
> +- gpio-vsel              : contains the level-shifter voltage select gpio

I think these need to be 'en-gpios' and 'vsel-gpios', in order for the
gpio binding to work.

> +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> +- rx_src_dev_type        : contains the rx source device (DMA)

As Russell commented already, these should not be here.

	Arnd
