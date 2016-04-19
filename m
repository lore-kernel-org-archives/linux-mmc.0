From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON
 MMC controller
Date: Tue, 19 Apr 2016 14:45:35 -0700
Message-ID: <5716A6FF.8070004@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <1459438013-25088-2-git-send-email-matt.redfearn@imgtec.com> <4790096.kDlyCl48hO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0093.outbound.protection.outlook.com ([157.56.111.93]:10004
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752132AbcDSVpu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 17:45:50 -0400
In-Reply-To: <4790096.kDlyCl48hO@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On 04/19/2016 01:46 PM, Arnd Bergmann wrote:
> On Thursday 31 March 2016 16:26:53 Matt Redfearn wrote:
>> +struct octeon_mmc_host {
>> +	u64	base;
>> +	u64	ndf_base;
>> +	u64	emm_cfg;
>> +	u64	n_minus_one;  /* OCTEON II workaround location */
>> +	int	last_slot;
>> +
>> +	struct semaphore mmc_serializer;
>
> Please don't add any new semaphores to the kernel, use a mutex or
> a completion instead.

The last time I checked, a mutex could not be used from interrupt context.

Since we are in interrupt context and we really want mutex-like behavior 
here, it seems like a semaphore is just the thing we need.

I am not sure how completions would be of use, perhaps you could elaborate.

>
>> +#if 0
>> +#define octeon_mmc_dbg trace_printk
>> +#else
>> +static inline void octeon_mmc_dbg(const char *s, ...) { }
>> +#endif
>
> Remove this and use dev_dbg() or pr_debug(), it does the same thing.

It is not the same thing.  pr_debug has *way* more overhead than 
trace_printk has it also acquires locks that can cause system lockups to 
happen.  The driver doesn't work with pr_debug().

We could just remove this *and* all calls to octeon_mmc_dbg, but 
switching to pr_debug() is not an option.

>
>> +static irqreturn_t octeon_mmc_interrupt(int irq, void *dev_id)
>
> This function is rather long, can you split it up a bit for
> readability?
>
>> +{
>> +	struct octeon_mmc_host *host = dev_id;
>> +	union cvmx_mio_emm_int emm_int;
>> +	struct mmc_request	*req;
>> +	bool host_done;
>> +	union cvmx_mio_emm_rsp_sts rsp_sts;
>> +	unsigned long flags = 0;
>> +
>> +	if (host->need_irq_handler_lock)
>> +		spin_lock_irqsave(&host->irq_handler_lock, flags);
>> +	else
>> +		__acquire(&host->irq_handler_lock);
>
> The locking seems odd, why do you only sometimes have to take the lock,

In the cn78xx_style case there are multiple irqs with this handler.  in 
the !cn78xx_style case there is a single irq.

The multiple irq case is what we are protecting.  Without the spinlock, 
there are races between the handler threads of the several irqs that can 
fire.

> and why do you disable interrupts from within the irq handler?
>

That may be gratuitous, although in the threaded interrupt handler case 
it may be needed.  I guess that has to be investigated.

David Daney
