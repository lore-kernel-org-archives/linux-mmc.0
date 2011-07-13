From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: tmio: fix recursive spinlock, don't schedule with interrupts disabled
Date: Wed, 13 Jul 2011 11:00:41 -0400
Message-ID: <m2oc0y2pk6.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
	<Pine.LNX.4.64.1106201803520.11365@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1106201803520.11365@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 20 Jun 2011 18:27:50 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Mon, Jun 20 2011, Guennadi Liakhovetski wrote:
> Calling mmc_request_done() under a spinlock with interrupts disabled
> leads to a recursive spin-lock on request retry path and to
> scheduling in atomic context. This patch fixes both these problems
> by moving mmc_request_done() to the scheduler workqueue.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> This is a bug-fix: without it the system Oopses with LOCKDEP enabled, so, 
> it should really go in 3.0. OTOH it is pretty intrusine and non-trivial, 
> so, reviews and tests are highly appreciated! Also, unfortunately, I 
> wasn't able to test it well enough with SDIO, because the driver for the 
> only SDIO card, that I have, reproducibly crashes the kernel:

Having trouble working out how to apply this -- for example, in this hunk:

> @@ -618,7 +631,8 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
>  		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
>  			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
>  				TMIO_STAT_CARD_REMOVE);
> -			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
> +			if (!work_pending(&host->mmc->detect.work))
> +				mmc_detect_change(host->mmc, msecs_to_jiffies(100));
>  		}
>  
>  		/* CRC and other errors */

In mmc-next there's a "goto out;" after the mmc_detect_change call, which
looks like it's always been there.  Am I missing a patch this depends on?

(It'd be a good time to get a full set of tmio patches for 3.1 pulled
together, if you can do that.)

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
