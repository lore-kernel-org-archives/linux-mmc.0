From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Wed, 20 Apr 2016 00:09:31 +0200
Message-ID: <37975265.p6gUi9hTMt@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <4790096.kDlyCl48hO@wuerfel> <5716A6FF.8070004@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51229 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcDSWJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 18:09:55 -0400
In-Reply-To: <5716A6FF.8070004@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On Tuesday 19 April 2016 14:45:35 David Daney wrote:
> On 04/19/2016 01:46 PM, Arnd Bergmann wrote:
> > On Thursday 31 March 2016 16:26:53 Matt Redfearn wrote:
> >> +struct octeon_mmc_host {
> >> +	u64	base;
> >> +	u64	ndf_base;
> >> +	u64	emm_cfg;
> >> +	u64	n_minus_one;  /* OCTEON II workaround location */
> >> +	int	last_slot;
> >> +
> >> +	struct semaphore mmc_serializer;
> >
> > Please don't add any new semaphores to the kernel, use a mutex or
> > a completion instead.
> 
> The last time I checked, a mutex could not be used from interrupt context.
> 
> Since we are in interrupt context and we really want mutex-like behavior 
> here, it seems like a semaphore is just the thing we need.
> 
> I am not sure how completions would be of use, perhaps you could elaborate.

Completions are used when you have one thread waiting for an event,
which is often an interrupt: the process calls
wait_for_completion(&completion); and the interrupt handler calls
complete(&completion);

It seems that you are using the semaphore for two reasons here (I
only read it briefly so I may be wrong):
waiting for the interrupt handler and serializing against another
thread. In this case you need both a mutex (to guarantee mutual
exclusion) and a completion (to wait for the interrupt handler
to finish).

> >> +#if 0
> >> +#define octeon_mmc_dbg trace_printk
> >> +#else
> >> +static inline void octeon_mmc_dbg(const char *s, ...) { }
> >> +#endif
> >
> > Remove this and use dev_dbg() or pr_debug(), it does the same thing.
> 
> It is not the same thing.  pr_debug has *way* more overhead than 
> trace_printk has it also acquires locks that can cause system lockups to 
> happen.  The driver doesn't work with pr_debug().
> 
> We could just remove this *and* all calls to octeon_mmc_dbg, but 
> switching to pr_debug() is not an option.

Ok, I failed to realize that trace_printk() is a generic feature,
not something you defined here.

Anyway, pr_debug() does nothing when the 'DEBUG' macro is not defined
and CONFIG_DYNAMIC_DEBUG is not enabled, which is the normal case
(as your #if 0/#else is), so there is still zero overhead.

If the dynamic debug gets enabled, the overhead is may be higher
than trace_printk, but I don't think you could get into a case where
it hangs the system, printk() is intentionally callable from any
context except from the serial driver output and from non-maskable
interrupts.

> >> +static irqreturn_t octeon_mmc_interrupt(int irq, void *dev_id)
> >
> > This function is rather long, can you split it up a bit for
> > readability?
> >
> >> +{
> >> +	struct octeon_mmc_host *host = dev_id;
> >> +	union cvmx_mio_emm_int emm_int;
> >> +	struct mmc_request	*req;
> >> +	bool host_done;
> >> +	union cvmx_mio_emm_rsp_sts rsp_sts;
> >> +	unsigned long flags = 0;
> >> +
> >> +	if (host->need_irq_handler_lock)
> >> +		spin_lock_irqsave(&host->irq_handler_lock, flags);
> >> +	else
> >> +		__acquire(&host->irq_handler_lock);
> >
> > The locking seems odd, why do you only sometimes have to take the lock,
> 
> In the cn78xx_style case there are multiple irqs with this handler.  in 
> the !cn78xx_style case there is a single irq.
> 
> The multiple irq case is what we are protecting.  Without the spinlock, 
> there are races between the handler threads of the several irqs that can 
> fire.

Ok, I see. How about rearranging the code in a way that doesn't
need the check or the __acquire? You could do this as

static irqreturn_t octeon_mmc_multi_interrupt(int irq, void *dev_id)
{
	struct octeon_mmc_host *host = dev_id;
	irqreturn_t ret;

	spin_lock(&host->irq_handler_lock);
	ret = octeon_mmc_interrupt(irq, dev_id);
	spin_unlock(&host->irq_handler_lock);

	return ret;
}

> > and why do you disable interrupts from within the irq handler?
> >
> 
> That may be gratuitous, although in the threaded interrupt handler case 
> it may be needed.  I guess that has to be investigated.

Ok. I checked first that this is not a threaded handler. In case
of fully preemptable kernels, all interrupt handlers are threaded,
but then spin_lock_irqsave() does not turn off interrupts but only
prevent handlers from running.

	Arnd

