From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v14 1/6] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Wed, 27 Aug 2014 09:57:11 +0200
Message-ID: <53FD8F57.8030401@epfl.ch>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com>	<1401352085-22781-2-git-send-email-afenkart@gmail.com>	<53F9A1B5.2080409@epfl.ch> <CALtMJEC0z2AGnO=uYxQ4_0GjU7LQNxkH7DP5+rhfr0=DNo6Wkw@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CALtMJEC0z2AGnO=uYxQ4_0GjU7LQNxkH7DP5+rhfr0=DNo6Wkw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Andreas,

On 08/24/2014 07:46 PM, Andreas Fenkart wrote:
> Hi Florian
> 
> 2014-08-24 10:26 GMT+02:00 Florian Vaussard <florian.vaussard@epfl.ch>:
>> Hi Andreas,
>>
>> On 05/29/2014 10:28 AM, Andreas Fenkart wrote:
>>> There have been various patches floating around for enabling
>>> the SDIO IRQ for hsmmc, but none of them ever got merged.
>>>
>>
>> [...]
>>
>>> For now, only support SDIO interrupt if we are booted with
>>> a separate wake-irq configued via device tree. This is
>>> because omaps need the wake-irq for idle states, and some
>>> omaps need special quirks. And we don't want to add new
>>> legacy mux platform init code callbacks any longer as we
>>> are moving to DT based booting anyways.
>>>
>>> To use it, you need to specify the wake-irq using the
>>> interrupts-extended property.
>>>
>>
>> First, thanks a lot for your tenacity on this patchset, this was a long
>> needed feature. I enabled the SDIO interrupt, and got the throughput of
>> my 88W8686-based chip multiplied by 15. Nice! I just have an issue with
>> the wake-up path, and maybe you could help me.
>>
>> According to the DM3730 TRM, the MMC2 has the SWAKEUP path. So first I
>> tried to give the same wake-irq as the MMC's one, but
>> omap_hsmmc_configure_wake_irq() fails to request it, as they are not
>> IRQF_SHARED.
> 
> Why can't it be shared?
> 

I first tried

interrupts-extended = <&intc 86 &intc 86>;

but devm_request_irq() in omap_hsmmc_configure_wake_irq() fails.
But this is probably not the good approach, as Tony pointed out.

Regards,
Florian
