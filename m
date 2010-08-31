From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 1/3] omap4 hsmmc : Adding card detect support for MMC1
Date: Tue, 31 Aug 2010 06:55:52 +0100
Message-ID: <20100831055552.GA7847@console-pimps.org>
References: <23529.10.24.255.18.1283190503.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:42186 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754581Ab0HaFz6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 01:55:58 -0400
Content-Disposition: inline
In-Reply-To: <23529.10.24.255.18.1283190503.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com

On Mon, Aug 30, 2010 at 11:18:23PM +0530, kishore kadiyala wrote:
> Adding card detect callback function and card detect configuration
> function for MMC1 Controller.
> 
> Card detect configuration function does initial configuration of the
> MMC Control & PullUp-PullDown registers of Phoenix.
> 
> For MMC1 Controller, Card detect interrupt source is
> twl6030 and the card detect call back function provides card present/absent
> status by reading MMC Control register.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

[...]

> @@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
>  }
>  EXPORT_SYMBOL(twl6030_interrupt_mask);
> 
> +int twl6030_mmc_card_detect_config(void)
> +{
> +	int ret;
> +	u8 reg_val = 0;
> +
> +	/* Unmasking the Card detect Interrupt line for MMC1 from Phoenix */
> +	if (twl_class_is_6030()) {
> +		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> +							REG_INT_MSK_LINE_B);
> +		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> +							REG_INT_MSK_STS_B);
> +	}
> +
> +	/*
> +	 * Intially Configuring MMC_CTRL for receving interrupts &
> +	 * Card status on TWL6030 for MMC1
> +	 */
> +	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
> +	if (ret < 0) {
> +		pr_err("twl6030: Failed to read MMCCTRL, error %d\n", ret);
> +		return ret;
> +	}
> +	reg_val &= ~VMMC_AUTO_OFF;
> +	reg_val |= SW_FC;
> +	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
> +	if (ret < 0) {
> +		return ret;
> +		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
> +	}

Shouldn't this be

		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
		return ret;

?

> +
> +	/* Configuring PullUp-PullDown register */
> +	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
> +						TWL6030_CFG_INPUT_PUPD3);
> +	if (ret < 0) {
> +		return ret;
> +		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
> +									ret);

Shouldn't this be,

		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
									ret);
		return ret;
?
