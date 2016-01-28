From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Thu, 28 Jan 2016 16:38:05 +0000
Message-ID: <20160128163805.GL10826@n2100.arm.linux.org.uk>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
 <20160128102057.GJ10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42347 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945976AbcA1QiQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 11:38:16 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr0t3BWXV9ip-DKeTXFqGxmK=i=T1UuK6qiu4ZuUJ+i=w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Haibo Chen <haibo.chen@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>

On Thu, Jan 28, 2016 at 04:47:23PM +0100, Ulf Hansson wrote:
> +tglx, Jon
> 
> On 28 January 2016 at 11:20, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 28, 2016 at 05:42:26PM +0800, Haibo Chen wrote:
> >> Currently sdhci driver free irq in host suspend, and call
> >> request_threaded_irq() in host resume. But during host resume,
> >> Ctrl+C can impact sdhci host resume, see the error log:
> >
> > Ctrl+C should have no effect on this - that seems to imply that there's
> > some other bug elsewhere.
> >
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index d622435..4b1646b 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2686,7 +2686,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
> >>               host->ier = 0;
> >>               sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> >>               sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
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

They are.  When anything disables an IRQ, the IRQ is disabled.  Only
once the N disable_irq()s have been balanced with N enable_irq()s will
the interrupt be re-enabled.  disable_irq() doesn't work on a per-device
level, but on a per-interrupt line level.

So, if sdhci calls disable_irq() in its suspend interrupt, it disables
the IRQ for _everything_ thats sharing that interrupt.  If (eg) USB or
r852 needs an interrupt to complete its own suspend, it won't see that
interrupt because SDHCI disabled it.

It appear might work as-is even so, if SDHCI happens to be (on the test
setup) suspended after (eg) both the USB and r852 drivers.

It is probably much better if SDHCI writes to the device on suspend to
disable interrupts, synchronise with the IRQ, and then set a flag to
indicate that the interrupt handler should immediately return IRQ_NONE
in case any of the other peripherals sharing the IRQ line trigger an
interrupt.

> I have recently discussed a related change on the genirq framework,
> which in principle turned out that we concluded on needing a new API
> to deal with PM related enable/disable IRQ cases.
> http://www.gossamer-threads.com/lists/linux/kernel/2350504?do=post_view_threaded#2350504

I haven't read your link, but I don't think we really need yet more
APIs to deal with this, except possibly one thing - a way to tell
genirq that a specific IRQ handler should not be called because its
device is suspended.

IOW, moving:

static irqreturn_t foo_device_irq(void *devid)
{
	struct foo_device_priv *priv = dev_id;

	if (priv->suspended)
		return IRQ_NONE;

	... rest of IRQ handling
}

into genirq code, so that we don't end up with that pattern repeated
many times in drivers.

It may be that's exactly what's being proposed in the link, but as I
say, I've not read it yet.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
