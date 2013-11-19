From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Tue, 19 Nov 2013 14:37:52 +0100
Message-ID: <CALtMJEB4RRHdc9HYqdCf=YonbpADrj5_MiWJgE1rxK_t5O8nsA@mail.gmail.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com>
	<1384761240-11005-3-git-send-email-afenkart@gmail.com>
	<CAPDyKFrTm3BB3o=445FjigB1nVuKukwa6FtunPqtzFR2BihhRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrTm3BB3o=445FjigB1nVuKukwa6FtunPqtzFR2BihhRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

2013/11/19 Ulf Hansson <ulf.hansson@linaro.org>:
> On 18 November 2013 08:53, Andreas Fenkart <afenkart@gmail.com> wrote:

>>
>> +static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
>> +{
>> +       struct omap_hsmmc_host *host = dev_id;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->irq_lock, flags);
>> +       if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
>> +               disable_irq_nosync(mmc_slot(host).sdio_irq);
>> +               host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
>> +       }
>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>> +
>> +       pm_request_resume(host->dev); /* no use counter */
>
> In the case were you are not waking up from system suspend, but from
> runtime suspend, you likely want to signal the SDIO irq as soon as
> possible. Then you should use mmc_signal_sdio_irq instead.

That was my intention first as well, and previous patches worked that way.
SDIO IRQ while in pm_suspend is a rare event, compard to SDIO irq
while in pm_active state.

cat /proc/interrupts
           CPU0
 80:      68349      INTC  64  mmc0
236:       4352      GPIO  28  mmc0

Here the Wifi module is just connected, not being pinged or iperf
running. So the benefit will not be as big as you imagine.

On the other side the optimisations is not without problems, while in
pm_suspend the functional clock is off and you must not access the
registers of the module.

But this is exactly whapt happens when you call mmc_signal_sdio_irq,
it will call back into the drivers omap_hsmmc_enable_sdio_irq trying to
disable the SDIO irq. So you must add special state machines there.

After all it's doable but error prone, and I consider not worth the troubles
for no noticeable speedup.

Also have a look here, Balaji T K had a similar remark to yours
http://www.spinics.net/lists/linux-omap/msg99832.html

>
> In the other case, when waking up from system suspend, you should be
> able to completely rely on that the mmc_sdio_resume from the core
> layer, will handle the IRQ.
>
> Kind regards
> Ulf Hansson
>
