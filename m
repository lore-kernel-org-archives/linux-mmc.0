From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther
 than free this irq
Date: Thu, 28 Jan 2016 10:20:57 +0000
Message-ID: <20160128102057.GJ10826@n2100.arm.linux.org.uk>
References: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41610 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcA1KVG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 05:21:06 -0500
Content-Disposition: inline
In-Reply-To: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 28, 2016 at 05:42:26PM +0800, Haibo Chen wrote:
> Currently sdhci driver free irq in host suspend, and call
> request_threaded_irq() in host resume. But during host resume,
> Ctrl+C can impact sdhci host resume, see the error log:

Ctrl+C should have no effect on this - that seems to imply that there's
some other bug elsewhere.

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d622435..4b1646b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2686,7 +2686,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  		host->ier = 0;
>  		sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>  		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> -		free_irq(host->irq, host);
> +		disable_irq(host->irq);

This is really not acceptable I'm afraid.  While it's common on ARM for
each interrupt to be uniquely allocated to a peripheral, not all SDHCI
platforms have that luxury.

SDHCI is also used on PCI, and on x86 platforms, it's common to have PCI
interrupts shared between (sometimes many) different PCI devices.

For example, on my laptop:

 18:    1089806     286185   IO-APIC-fasteoi   uhci_hcd:usb8, r852, mmc0

the SDHCI interrupt is shared with two other peripherals - one USB
controller and a NAND device.

Disabling the interrupt will adversely impact other peripherals and
cause regressions where the interrupt is shared.

So, I'm afraid I'm going to have to NAK this patch.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
