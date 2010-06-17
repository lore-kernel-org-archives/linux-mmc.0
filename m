From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for MMC1
  Controller
Date: Thu, 17 Jun 2010 13:27:37 -0700
Message-ID: <20100617132737.d952d191.akpm@linux-foundation.org>
References: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757508Ab0FQU1r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2010 16:27:47 -0400
In-Reply-To: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, adrian.hunter@nokia.com

On Thu, 17 Jun 2010 20:57:19 +0530 (IST)
"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:

> Adding card detect callback function which gives the status of
> the card .For MMC1 Controller, Card detect interrupt source is
> twl6030 and card present/absent status is provided by MMCCTRL
> register of twl6030.
> 
>
> ...
>
> 
> +	int ret = -ENOSYS;
> +	int ret = -ENOSYS;

ENOSYS seems an inappropriate errno to use in a driver.

"ENOSYS -- The system doesn't support that function.  For example, if
you call setpgid() on a system without job control, you'll get an
ENOSYS error."

I think it means "you the programmer tried to do something in a syscall
which didn't make sense in this context".

I'm not sure what _is_ appropraite here.  There's always EIO I guess. 
ENODEV?

This happens a lot.  The userspace errnos just don't map well onto
kernel-internal operations.  it was a mistake - we should have defined a kernel-internal namespace and perhaps type for such things.  Oh well.

> +/* Configuring Card Detect for MMC1 */
> +static inline int omap4_hsmmc1_card_detect_config(void)
> +{
> +	int res = -1;
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
> +
> +	/*
> +	 * Intially Configuring MMC_CTRL for receving interrupts &
> +	 * Card status on TWL6030 for MMC1
> +	 */
> +	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
> +	if (res < 0)
> +		return res;
> +	reg_val &= ~VMMC_AUTO_OFF;
> +	reg_val |= SW_FC;
> +	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
> +
> +	 /* Configuring CFG_INPUT_PUPD3 */
> +	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
> +						TWL6030_CFG_INPUT_PUPD3);
> +	if (res < 0)
> +		return res;
> +	reg_val &= ~(MMC_PU | MMC_PD);
> +	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_CFG_INPUT_PUPD3);
> +	return res;
> +}

This is waaaaay to large to be inlined.  Why not put it in a .c file?

