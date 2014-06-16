From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
Date: Mon, 16 Jun 2014 22:55:12 +0100
Message-ID: <20140616215512.GC23430@n2100.arm.linux.org.uk>
References: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:59933 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756083AbaFPVzV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 17:55:21 -0400
Content-Disposition: inline
In-Reply-To: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@linaro.org>
Cc: arm@kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 16, 2014 at 01:56:16PM -0400, Matt Porter wrote:
> Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
> driver which is enabled in this defconfig. This results in the
> SDHCI driver not being built and a boot failure. Explictly
> enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
> driver is built.

I really don't understand why MMC_SDHCI_PLTFM isn't selected by the
sub-drivers.  sdhci-pltfm.c is a library module, which is only
useful with one of the sub-drivers enabled.

So, rather than providing a multitude of dependent options, why not
present people with:

 + sdhci drivers
   + sdhci pci
   + sdhci acpi
   + Arasan
   + Freescale eSDHC
   + Nintendo Wii
   + Dove

and leave MMC_SDHCI_PLTFM as a hidden option whose purpose is to
enable building of sdhci-pltfm.c.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
