From: Philip Rakity <prakity@marvell.com>
Subject: Re: SD8686 fast power-cycle problems
Date: Fri, 17 Jun 2011 11:49:05 -0700
Message-ID: <1E37377F-AC54-43BC-AF01-53CA9FDE3A10@marvell.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59787 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932429Ab1FQSy3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jun 2011 14:54:29 -0400
In-Reply-To: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Zhangfei Gao <zgao6@marvell.com>, Bing Zhao <bzhao@marvell.com>, Benson Chau <bchau@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


sdio_reset is harmless to non-sdio devices.  Especially since it is in the main power up path.

I see no reason this should be done.  Can you prepare a patch ?

snip from core.c

static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
{
	host->f_init = freq;

#ifdef CONFIG_MMC_DEBUG
	pr_info("%s: %s: trying to init card at %u Hz\n",
		mmc_hostname(host), __func__, host->f_init);
#endif
	mmc_power_up(host);

	/*
	 * sdio_reset sends CMD52 to reset card.  Since we do not know
	 * if the card is being re-initialized, just send it.  CMD52
	 * should be ignored by SD/eMMC cards.
	 */
	sdio_reset(host);
	mmc_go_idle(host);

	mmc_send_if_cond(host, host->ocr_avail);


regards,

Philip

On Jun 17, 2011, at 9:39 AM, Daniel Drake wrote:

> Hi,
> 
> Thanks for your help and explanations with earlier issues around the
> power-on and reset sequence for the SD8686.
> 
> We are still struggling a little with this, in the context of enabling
> runtime power management.
> 
> If we power down the card, and then *immediately* power it on again
> (and performing the CMD5,5,3,7 init sequence), the card fails to
> respond to the first CMD5.
> 
> We have identified two workarounds to this problem:
> 1. If we wait 300ms after powering off the card before turning it on
> again, it works fine.
> 
> 2. If we perform a SDIO I/O reset after powering on, before starting
> the 5,5,3,7 sequence, it works fine.
> 
> Do you have any comments or possible explanations for this issue? Is
> it something you are aware of?
> 
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

