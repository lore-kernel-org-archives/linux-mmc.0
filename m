From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
Date: Tue, 17 Jun 2014 13:46:50 +0200
Message-ID: <201406171346.51153.arnd@arndb.de>
References: <1402941376-29594-1-git-send-email-mporter@linaro.org> <20140616215512.GC23430@n2100.arm.linux.org.uk> <539F6CC7.4010002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55464 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbaFQLrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jun 2014 07:47:14 -0400
In-Reply-To: <539F6CC7.4010002@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Matt Porter <mporter@linaro.org>, arm@kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tuesday 17 June 2014, Stephen Warren wrote:
> On 06/16/2014 03:55 PM, Russell King - ARM Linux wrote:
> > On Mon, Jun 16, 2014 at 01:56:16PM -0400, Matt Porter wrote:
> >> Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> >> MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
> >> driver which is enabled in this defconfig. This results in the
> >> SDHCI driver not being built and a boot failure. Explictly
> >> enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
> >> driver is built.
> > 
> > I really don't understand why MMC_SDHCI_PLTFM isn't selected by the
> > sub-drivers.  sdhci-pltfm.c is a library module, which is only
> > useful with one of the sub-drivers enabled.
> > 
> > So, rather than providing a multitude of dependent options, why not
> > present people with:
> > 
> >  + sdhci drivers
> >    + sdhci pci
> >    + sdhci acpi
> >    + Arasan
> >    + Freescale eSDHC
> >    + Nintendo Wii
> >    + Dove
> >
> > and leave MMC_SDHCI_PLTFM as a hidden option whose purpose is to
> > enable building of sdhci-pltfm.c.
> 
> CC'ing Arnd, as author of 5d01b7684b7e "mmc: simplify SDHCI Kconfig
> dependencies". I also forgot to do that on the patch that fixed
> multi_v7_defconfig for this:-(

I think doing it the other way round as Russell suggested is a good
idea, and we can definitely do that. We have a similar situation in
other subsystems, sometimes we do it one way and sometimes the other.

The problem I was addressing in my patch was that the SDHCI driver
in particular was mixing the two approaches, which is much worse
as that can cause Kconfig dependency loops and is rather confusing.
I picked the approach that seemed simpler at the time.

	Arnd
