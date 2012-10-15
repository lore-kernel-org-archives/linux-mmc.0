From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 15 Oct 2012 11:37:25 +0100
Message-ID: <20121015103725.GQ21164@n2100.arm.linux.org.uk>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52460 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2JOKha (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 06:37:30 -0400
Content-Disposition: inline
In-Reply-To: <20121015094348.GP21164@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 15, 2012 at 10:43:48AM +0100, Russell King - ARM Linux wrote:
> 1. Unregister the device _BEFORE_ taking away any resources it may
>    be using.
> 2. Don't check clks against NULL.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looking at this driver some more, who the hell came up with the sdhci
registration interface?  It violates one of the most fundamental
principles of kernel driver programming.  You do _NOT_ publish your
driver interfaces _UNTIL_ you have finished setting your device up.
Otherwise, in a preemptible or SMP kernel, your driver can be used
before the initialization has completed.

As this driver calls sdhci_pltfm_register() before it has obtained the
clock for the interface, and this function does:
	sdhci_pltfm_init
	sdhci_add_host
		mmc_add_host
			mmc_start_host
				mmc_power_up
					mmc_set_ios
						sdhci_set_ios

See, we're trying to power up and clock the card _before_ the dove
sdhci driver has even claimed the clock let alone enabled it.  This
is total bollocks.  The sdhci platform interface is total crap for
creating this broken design in the first place.  This is why MMC has
the init + add interfaces, they're there to allow drivers to do stuff
the Right(tm) way and avoid shit like the above.

This should have been picked up at review time before the driver went
into mainline.  In any case, it needs to be fixed.
