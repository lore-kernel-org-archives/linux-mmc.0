From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Tue, 19 Apr 2016 22:46:08 +0200
Message-ID: <4790096.kDlyCl48hO@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <1459438013-25088-2-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:51117 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbcDSUqn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 16:46:43 -0400
In-Reply-To: <1459438013-25088-2-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On Thursday 31 March 2016 16:26:53 Matt Redfearn wrote:
> +struct octeon_mmc_host {
> +	u64	base;
> +	u64	ndf_base;
> +	u64	emm_cfg;
> +	u64	n_minus_one;  /* OCTEON II workaround location */
> +	int	last_slot;
> +
> +	struct semaphore mmc_serializer;

Please don't add any new semaphores to the kernel, use a mutex or
a completion instead.

> +#if 0
> +#define octeon_mmc_dbg trace_printk
> +#else
> +static inline void octeon_mmc_dbg(const char *s, ...) { }
> +#endif

Remove this and use dev_dbg() or pr_debug(), it does the same thing.

> +static irqreturn_t octeon_mmc_interrupt(int irq, void *dev_id)

This function is rather long, can you split it up a bit for
readability?

> +{
> +	struct octeon_mmc_host *host = dev_id;
> +	union cvmx_mio_emm_int emm_int;
> +	struct mmc_request	*req;
> +	bool host_done;
> +	union cvmx_mio_emm_rsp_sts rsp_sts;
> +	unsigned long flags = 0;
> +
> +	if (host->need_irq_handler_lock)
> +		spin_lock_irqsave(&host->irq_handler_lock, flags);
> +	else
> +		__acquire(&host->irq_handler_lock);

The locking seems odd, why do you only sometimes have to take the lock,
and why do you disable interrupts from within the irq handler?

	Arnd
