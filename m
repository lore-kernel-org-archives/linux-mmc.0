From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 11:06:24 +0000
Message-ID: <20110221110624.GK14495@n2100.arm.linux.org.uk>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com> <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52273 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BULGs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 06:06:48 -0500
Content-Disposition: inline
In-Reply-To: <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, r65037@freescale.com, cjb@laptop.org, kernel@pengutronix.de, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, eric@eukrea.com, avorontsov@ru.mvista.com, linuxzsc@gmail.com

On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> +	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
> +		if (readl(host->ioaddr + SDHCI_VENDOR_SPEC) & 0x2)
> +			writel(readl(host->ioaddr + SDHCI_VENDOR_SPEC) & ~0x2,
> +					host->ioaddr + SDHCI_VENDOR_SPEC);

Is it necessary to read the register twice, or would:

		u32 val = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
		if (val & 0x02)
			writel(val & ~0x02, host->ioaddr + SDHCI_VENDOR_SPEC);

be clearer and more obvious?
