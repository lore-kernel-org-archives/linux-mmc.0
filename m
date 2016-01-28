From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Thu, 28 Jan 2016 16:47:23 +0100
Message-ID: <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
	<20160128102057.GJ10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128102057.GJ10826@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Haibo Chen <haibo.chen@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

+tglx, Jon

On 28 January 2016 at 11:20, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 28, 2016 at 05:42:26PM +0800, Haibo Chen wrote:
>> Currently sdhci driver free irq in host suspend, and call
>> request_threaded_irq() in host resume. But during host resume,
>> Ctrl+C can impact sdhci host resume, see the error log:
>
> Ctrl+C should have no effect on this - that seems to imply that there's
> some other bug elsewhere.
>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d622435..4b1646b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2686,7 +2686,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>>               host->ier = 0;
>>               sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>>               sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>> -             free_irq(host->irq, host);
>> +             disable_irq(host->irq);
>
> This is really not acceptable I'm afraid.  While it's common on ARM for
> each interrupt to be uniquely allocated to a peripheral, not all SDHCI
> platforms have that luxury.
>
> SDHCI is also used on PCI, and on x86 platforms, it's common to have PCI
> interrupts shared between (sometimes many) different PCI devices.
>
> For example, on my laptop:
>
>  18:    1089806     286185   IO-APIC-fasteoi   uhci_hcd:usb8, r852, mmc0
>
> the SDHCI interrupt is shared with two other peripherals - one USB
> controller and a NAND device.
>
> Disabling the interrupt will adversely impact other peripherals and
> cause regressions where the interrupt is shared.

I thought disable|enable_irq() was being reference counted, so it
shouldn't impact the other peripherals for shared IRQs. I might have
understood this wrong though!?

Although, as if that's the case it also means that the IRQ can still
reach sdhci's irq handler as it hasn't actually been disabled.

Therefore, the only way we currently can make sure to don't get the
IRQ is to free and later re-request it. Now, apparently that has
issues when using threaded IRQ handlers.

I have recently discussed a related change on the genirq framework,
which in principle turned out that we concluded on needing a new API
to deal with PM related enable/disable IRQ cases.
http://www.gossamer-threads.com/lists/linux/kernel/2350504?do=post_view_threaded#2350504

Perhaps that's actually what we need to cover this case.

>
> So, I'm afraid I'm going to have to NAK this patch.

I agree. We need another solution!

Kind regards
Uffe
