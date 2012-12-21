From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [v4 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 21 Dec 2012 19:39:47 +0000
Message-ID: <201212211939.47563.arnd@arndb.de>
References: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61959 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab2LUTlB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 14:41:01 -0500
In-Reply-To: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On Friday 21 December 2012, Chunhe Lan wrote:
> 
> +static inline void mmc_delay(unsigned int ms)
> +{
> +       ktime_t end = ktime_add_us(ktime_get(), ms * 1000);
> +
> +       while (1) {
> +               s64 remaining;
> +
> +               cond_resched();
> +               remaining = ktime_to_us(ktime_sub(end, ktime_get()));
> +               if (remaining < 0)
> +                       break;
> +
> +               udelay(min_t(u32, remaining, 100));
> +       }
> +}

The new logic is more accurate than the old one, but it still wastes
a lot of energy and CPU cycles. Could you perhaps use an hrtimer to
set the exact timeout and actually sleep?

	Arnd
