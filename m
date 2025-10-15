Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com [220.197.32.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DF3126CE;
	Wed, 15 Oct 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511980; cv=none; b=EYE82C3MrqpK4Y0Yd5AG7t822cUbCwfJM1Uoh23JpmLStGXBYxJOM5ADHktcA7Z2o4d/9xGMJs5AifMReTDDcESoHuL9KWjMKOp6K7xTVjjcytnRTJ70jfbDTjMiZyRdnAgawXhKsMw/wBqWLp7IP754HUaYO9CFEMxn07WxmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511980; c=relaxed/simple;
	bh=edc1A/lLth606SbUTGSMVUX4tCnlzFbesWdc7qd8GY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxbTAKJDjWpeZY0lzibDrPWgYExo0Bumc5infsz0LG1Cz8YQ5UpIvgt1+J71g1mqPXaKYd83ZUukjrxJaYCE4KoCEPSacrZ4wz8adnjN6iJ4JGZjdTUJUkw0AYWvTgTpfxrtk1O+3SMXPqZyu/aM/chQc0Q6cGhEP0TS+NX6QrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=V6Npg03b; arc=none smtp.client-ip=220.197.32.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="V6Npg03b"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25f8c2a47;
	Wed, 15 Oct 2025 15:06:06 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: adrian.hunter@intel.com
Cc: yangzh0906@thundersoft.com,
	arnd@arndb.de,
	gordon.ge@bst.ai,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 5/9] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Wed, 15 Oct 2025 15:06:05 +0800
Message-ID: <20251015070605.1471915-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <72c6b6cd-943b-465e-9281-5ad7fb195433@intel.com>
References: <72c6b6cd-943b-465e-9281-5ad7fb195433@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e6b0bd0309cckunmca9633f0613a10
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk1CVk9NQ0hIGkoYSUNMSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=V6Npg03bKsOacEmFic5PhyY+UxojxYdAQDwMgrzXi42cjOcJwYb4kfQejskKcgRBlhInizB/tUvBn8QnxDrCxJbvo61hvPXs7Fk0JJk4GTaK1BTKXPNP/NySCBbqBEIg5pHd8lNFzUy4mkwSALoUXzUpSbNg0vk/wGbxC4AXCSs=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=I5DgyZhmCKycIeh0PdNQMv1WJTxiM6HDcnbURmrZWag=;
	h=date:mime-version:subject:message-id:from;

On Mon, Sep 29, 2025 at 04:25:51PM +0300, Adrian Hunter wrote:
> On 23/09/2025 09:10, Albert Yang wrote:


Thank you for the thorough review! I have addressed all your comments
and prepared v5.
Here are the detailed changes for each of your review comments:

> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXS)             += mxs-mmc.o
> >  obj-$(CONFIG_MMC_SDHCI)            += sdhci.o
> >  obj-$(CONFIG_MMC_SDHCI_UHS2)       += sdhci-uhs2.o
> >  obj-$(CONFIG_MMC_SDHCI_PCI)        += sdhci-pci.o
> > +obj-$(CONFIG_MMC_SDHCI_BST)                += sdhci-of-bst.o
>
> This would be better positioned so that it is not between
>       obj-$(CONFIG_MMC_SDHCI_PCI) and sdhci-pci-y
>

Done. Moved to after the sdhci-pci-y block in drivers/mmc/host/Makefile.

> >  sdhci-pci-y                        += sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> >                                sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/ioport.h>
>
> Is linux/ioport.h needed?
>

Removed. This header was indeed unnecessary.


> > +#include <linux/platform_device.h>
> > +#include <linux/iopoll.h>
>
> Also:
>
> #include <linux/bits.h>
>
> And if you use FIELD_PREP():
>
> #include <linux/bitfield.h>

Done. Added both headers and updated the clock divider code to use FIELD_PREP().

> > +#define SDHCI_CLOCK_PLL_EN         0x0008
>
> Already defined in sdhci.h

Removed. The definition from sdhci.h is now used.


> > +#define SDHCI_TUNING_COUNT         0x20
>
> For SD cards the limit is 40.  This number seems to be
> driver-specific so should be named accordingly e.g.

Done. Renamed to SDHCI_BST_TUNING_COUNT and updated all references.

> > +#define BST_EMMC_CTRL_BIT2         BIT(2)
>
> BST_EMMC_CTRL_BIT2 is not a very descriptive name
>

Done. Renamed to BST_EMMC_CTRL_RST_N (reset line control bit) with updated
references in sdhci_bst_reset().

> > +
> > +/* Clock frequency limits */
> > +#define BST_DEFAULT_MAX_FREQ               2000000UL
>
> 2 MHz looks too low?
>

You're right, my apologies for the confusion. The value was incorrect in v4.
The correct maximum frequency is 200000000UL (200 MHz). I've corrected this
in v5 and updated all references. I've also simplified the clock division
calculation to avoid overflow warnings (removed the "* 100" operation).

> > +#define BST_CLOCK_DIV_MASK         GENMASK(7, 0)
> > +#define BST_CLOCK_DIV_SHIFT                8
>
> Can use just:
>
> #define BST_CLOCK_DIV_MASK            GENMASK(15, 8)
>
> and FIELD_PREP() so that BST_CLOCK_DIV_SHIFT is not needed
>

Done. Changed to GENMASK(15, 8) and updated the code to use:
	clk &= ~BST_CLOCK_DIV_MASK;
	clk |= FIELD_PREP(BST_CLOCK_DIV_MASK, div);
BST_CLOCK_DIV_SHIFT has been removed.

> > +   /* Turn off card/internal/PLL clocks when clock==0 to avoid idle power */
> > +   u32 clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>
> Could be inside the 'if (!clock) {' block e.g.
>
>       if (!clock) {
>               u32 clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

Done. Moved the variable declaration inside the if (!clock) block to limit scope.

> Kernel style is not to put kernel-doc comments on call-back function
> implementations.

Done. Removed all kernel-doc comments from:
- sdhci_bst_reset()
- sdhci_bst_set_timeout()
- sdhci_bst_set_power()
- sdhci_bst_execute_tuning()
- sdhci_bst_voltage_switch()


> > +   if (host->bounce_buffer) {
> > +           dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> > +                             host->bounce_buffer, host->bounce_addr);
> > +           host->bounce_buffer = NULL;
> > +   }
>
> Same 5 lines of code further above.  Could be a separate little helper function.
>

Done. Created sdhci_bst_free_bounce_buffer() helper function which handles:
- Freeing bounce buffer via dma_free_coherent()
- Releasing reserved memory via of_reserved_mem_device_release()
This helper is now used in both probe error path and remove function.

All review comments have been addressed and verified.

Note: Following Arnd Bergmann's feedback [1], in the next submission I plan
to split out the MMC driver patches and submit them separately to the MMC
subsystem maintainers. This will help streamline the review process and
allow the platform code and driver code to progress independently.

[1] https://lore.kernel.org/lkml/f64b0e00-1c30-47a1-b6b0-1bc28cc7f8ac@app.fastmail.com/

Thank you again for the thorough and constructive review!

Best regards,
Albert Yang
