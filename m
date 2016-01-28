From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Thu, 28 Jan 2016 17:21:41 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601281719350.3886@nanos>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com> <20160128102057.GJ10826@n2100.arm.linux.org.uk> <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Haibo Chen <haibo.chen@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 28 Jan 2016, Ulf Hansson wrote:
> On 28 January 2016 at 11:20, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> -             free_irq(host->irq, host);
> >> +             disable_irq(host->irq);
> >
> > This is really not acceptable I'm afraid.  While it's common on ARM for
> > each interrupt to be uniquely allocated to a peripheral, not all SDHCI
> > platforms have that luxury.
> >
> > SDHCI is also used on PCI, and on x86 platforms, it's common to have PCI
> > interrupts shared between (sometimes many) different PCI devices.
> >
> > For example, on my laptop:
> >
> >  18:    1089806     286185   IO-APIC-fasteoi   uhci_hcd:usb8, r852, mmc0
> >
> > the SDHCI interrupt is shared with two other peripherals - one USB
> > controller and a NAND device.
> >
> > Disabling the interrupt will adversely impact other peripherals and
> > cause regressions where the interrupt is shared.
> 
> I thought disable|enable_irq() was being reference counted, so it
> shouldn't impact the other peripherals for shared IRQs. I might have
> understood this wrong though!?

It's reference counted. But it disables the irq line and not a particular
interrupt handler.
 
> Although, as if that's the case it also means that the IRQ can still
> reach sdhci's irq handler as it hasn't actually been disabled.

No. The result is that the other devices on the same irq line won't get any
interrupt anymore.

> Therefore, the only way we currently can make sure to don't get the
> IRQ is to free and later re-request it. Now, apparently that has
> issues when using threaded IRQ handlers.

What's the issue?
 
Thanks,

	tglx
