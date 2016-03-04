From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/3] mmc: sdhci: Set DMA mask properly
Date: Fri, 04 Mar 2016 16:59:01 +0100
Message-ID: <2058077.gkPpZ9jbXd@wuerfel>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Friday 04 March 2016 19:38:42 Alexandre Courbot wrote:
> Well that's far from the two-liner I had in mind to fix our bounce-buffers
> problem with Tegra, but it feels correct. Testing for ACPI and PCI would be
> appreciated (I am rather confident that ACPI will be ok, but the PCI part
> should be reviewed by someone who knows better).
> 
> 64-bit capable devices are supposed to set their own DMA mask. Currently
> this does not happen for sdhci devices excepted for the two (sdhci-acpi
> and sdhci-pci) that define a enable_dma() hook and do it there. However
> this hook is called from several places while DMA mask is supposed to
> be set only once ; for instance the sdhci-acpi driver maintains a flag
> just to make sure the DMA mask is set only upon the first call of this
> hook.
> 
> For the vast majority of drivers that do not define a enable_dma() hook, the
> default 32-bit DMA mask is used and there is a risk of using unneeded bounce
> buffers on hosts capable of 64-bit addressing.
> 
> The first patch adds a default DMA mask setting function that is called when
> a DMA-capable host is added. It tries to set sane DMA masks according to the
> device's reported capabilities.
> 
> The addition of this function seems to make the same code in sdhci-acpi and
> sdhci-pci redundant, so it is removed from these drivers. On top of making
> this series a negative line count, it also removes one usage of the obsolete
> pci_set_dma_mask() function.
> 
> Thanks to Arnd for the insightful discussion that led to this.

Looks great overall, much simpler and saner in the new version. I found
one small bug, which appears to have been preexisting, but you moved
it to a different file now.

	Arnd
