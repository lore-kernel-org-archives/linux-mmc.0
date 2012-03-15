From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 18:23:32 +0000
Message-ID: <201203151823.32882.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <201203151746.56678.arnd@arndb.de> <20120315175443.GG15988@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56845 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161027Ab2COUBh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 16:01:37 -0400
In-Reply-To: <20120315175443.GG15988@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 05:46:56PM +0000, Arnd Bergmann wrote:
> > Can you elaborate? I suggested the split in order to keep the ux500
> > specific parts local to one file. With the device tree conversion,
> > we really want to have them out of the platform code, but sticking them
> > into the main driver seems wrong, too.
> 
> You're talking about the data structures which describe what quirks to
> apply for the ux500 parts, rather than the actual quirks themselves.
> That's not a particularly clever thing to do because it separates out
> the selection of the works from the rest of the driver, which means
> simply searching for the flags to find out what's applied for what has
> to span several files.

Right, that is a disadvantage, but it's also how a lot of other
drivers work, in particular sdhci.

My reasoning is roughly this:

* we want to get rid of arch/arm/mach-ux500/board-mop500-sdi.c
* the sdi0_configure() and mop500_sdi0_vdd_handler() functions
  need to be moved somewhere in order to do that, so they should
  be with the driver.
* we don't want them in mmci.c, so we create a new file for these.
* in order to call do the setup from sdi0_configure right, it needs
  to be done in the probe() function
* if we want to have a separate probe function, we also need to
  have a separate amba_driver structure
* the variant_data in mmci.c belongs with the amba_id, so that
  also gets moved to the ux500 file.

If you have a better solution for one or more of these, I'm
all ears.

The alternatives that I can see are:
a) keep using auxdata to supply a platform_data pointer and
   do everything in the main driver. Problem: we want to
   avoid auxdata if possible
b) move the code from patch 4 into mmci.c using #ifdef.
   Problem: it's ugly code that has nothing to do with mmci
   in general.
c) use the regulator framework to do the voltage selection
   here, and have only generic code in mmci.c. This may
   be the best solution, but I have no idea if this is
   actually possible, or how to do it.

	arnd

