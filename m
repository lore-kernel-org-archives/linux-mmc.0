From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle
 mode.
Date: Mon, 18 Feb 2013 11:26:38 +0100
Message-ID: <512201DE.1070001@gmail.com>
References: <20121220220444.GA350@blumentopf> <1356041532-919-1-git-send-email-andreas.fenkart@streamunlimited.com> <20130110202203.GD14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130110202203.GD14149@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

On 10.01.2013 21:22, Tony Lindgren wrote:
> * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [121220 14:15]:
>> Without functional clock the omap_hsmmc module can't forward
>> SDIO IRQs to the system. This patch reconfigures dat1 line
>> as a gpio while the fclk is off. And uses SDIO IRQ detection of
>> the module, while fclk is present.
> 
> Looks pretty good to me, however I could not figure out what
> to apply this on for testing. It fails to apply at least against
> current linux next, can you please update against that?
>  
>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
>> +	u32 irq_mask;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&host->irq_lock, flags);
>> +
>> +	host->sdio_irq_en = (enable != 0) ? true : false;
>> +
>> +	if (host->active_pinmux) {
>> +		irq_mask = OMAP_HSMMC_READ(host->base, ISE);
>> +		if (enable)
>> +			irq_mask |= CIRQ_ENABLE;
>> +		else
>> +			irq_mask &= ~CIRQ_ENABLE;
>> +		OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>> +
>> +		if (!host->req_in_progress)
>> +			OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>> +
>> +#if 0
>> +		OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
>> +#endif
> 
> Maybe just replace #if 0 with just a comment in case it turns out to be
> needed for some cases?

Is there any update on this series? Andreas, did you do more tests?


Thanks and best regards,
Daniel

