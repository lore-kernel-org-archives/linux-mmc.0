From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 2/3] mmc: Add realtek USB sdmmc host driver
Date: Fri, 10 Jan 2014 13:49:02 +0100
Message-ID: <1389358142.6807.36.camel@linux-fkkt.site>
References: <1387792327-2511-1-git-send-email-rogerable@realtek.com>
	 <1387792327-2511-3-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44890 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbaAJMtD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jan 2014 07:49:03 -0500
In-Reply-To: <1387792327-2511-3-git-send-email-rogerable@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

On Mon, 2013-12-23 at 17:52 +0800, rogerable@realtek.com wrote:
> From: Roger Tseng <rogerable@realtek.com>
> 
> Realtek USB SD/MMC host driver provides mmc host support based on the Realtek
> USB card reader MFD driver.
> 
> Signed-off-by: Roger Tseng <rogerable@realtek.com>

> +#ifdef DEBUG

Dynamic debugging would be nice.

> +static void sd_print_debug_regs(struct rtsx_usb_sdmmc *host)
> +{
> +	struct rtsx_ucr *ucr = host->ucr;
> +	u8 val = 0;
> +
> +	rtsx_usb_ep0_read_register(ucr, SD_STAT1, &val);
> +	dev_dbg(sdmmc_dev(host), "SD_STAT1: 0x%x\n", val);
> +	rtsx_usb_ep0_read_register(ucr, SD_STAT2, &val);
> +	dev_dbg(sdmmc_dev(host), "SD_STAT2: 0x%x\n", val);
> +	rtsx_usb_ep0_read_register(ucr, SD_BUS_STAT, &val);
> +	dev_dbg(sdmmc_dev(host), "SD_BUS_STAT: 0x%x\n", val);
> +}
> +#else
> +#define sd_print_debug_regs(host)
> +#endif /* DEBUG */
> +


	Regards
		Oliver


