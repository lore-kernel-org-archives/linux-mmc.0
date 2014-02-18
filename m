From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller
Date: Tue, 18 Feb 2014 19:02:47 +0100
Message-ID: <2905238.0nD7CECiVl@wuerfel>
References: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63687 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaBRSDM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 13:03:12 -0500
In-Reply-To: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>

On Tuesday 18 February 2014 16:08:29 Thomas Petazzoni wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> The SDHCI unit used on the Armada 380 and 385 Marvell SoC is similar
> to the PXAv3 unit. The only difference is that on Armada 38x, the
> PXAv3 unit accesses memory through MBus windows which must be
> configured prior to using the device. Without this, DMA would not
> work.
> 
> In order to achieve this, the sdhci-pxav3 driver is extended with an
> additional compatible string "marvell,armada-380-sdhci". When this
> compatible string is used, the MBus windows are initialized in a way
> that is identical to what all other DMA-capable drivers for Marvell
> EBU platforms do.

It seems odd to do this in the sdhci driver, when the configuration
is done in registers that belong to mbus.

> +/*
> + * These registers are relative to the second register region, for the
> + * MBus bridge.
> + */
> +#define SDHCI_WINDOW_CTRL(i)   (0x80 + ((i) << 3))
> +#define SDHCI_WINDOW_BASE(i)   (0x84 + ((i) << 3))
> +#define SDHCI_MAX_WIN_NUM      8

These look similar to the outbound mbus windows that are used for MMIO,
but it's not really clear from the code what they really do.

> +       for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
> +               writel(0, regs + SDHCI_WINDOW_CTRL(i));
> +               writel(0, regs + SDHCI_WINDOW_BASE(i));
> +       }
> +
> +       for (i = 0; i < dram->num_cs; i++) {
> +               const struct mbus_dram_window *cs = dram->cs + i;
> +
> +               /* Write size, attributes and target id to control register
> */ +               writel(((cs->size - 1) & 0xffff0000) |
> +                       (cs->mbus_attr << 8) |
> +                       (dram->mbus_dram_target_id << 4) | 1,
> +                       regs + SDHCI_WINDOW_CTRL(i));
> +               /* Write base address to base register */
> +               writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
> +       }

Accessing the mbus_dram_window() is also something that seems to fit
better into the mbus driver.

I assume there are more the same register ranges for each bus master
behind mbus (PCI being special again). How about adding an exported
function to the mbus driver that sets up all the windows for one
bus master correctly, passing only the number of the bus master?

	Arnd
