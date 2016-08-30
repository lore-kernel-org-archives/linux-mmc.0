From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Tue, 30 Aug 2016 16:04:49 +0200
Message-ID: <201608301604.49119.arnd@arndb.de>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <5229438.Oa2AiqCmJN@wuerfel> <CAOGqxeVZBkfMX7wj9V=RhDV+V7hUyVVMUuGgepkN6yGc9B9xLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:54101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcH3OFL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 10:05:11 -0400
In-Reply-To: <CAOGqxeVZBkfMX7wj9V=RhDV+V7hUyVVMUuGgepkN6yGc9B9xLg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>

On Monday 29 August 2016, Alan Cooper wrote:
> I think there's some confusion over the core issue so let be summarize.
> The SDHCI host controller CAPABILITIES register bit 28 indicates if
> the host controller hardware can support 64 bit addresses using the
> larger 96 bit DMA descriptors. We currently don't have any SoCs that
> have this support, even our current 64bit ARM SoCs don't support this,
> though there are future ARM SoCs that will have this support. The bug
> is that a few MIPS based SoCs had this bit incorrectly set even though
> the hardware did not support it and this caused the driver to use the
> larger DMA descriptors which crashed the driver. All we're trying to
> fix here is a simple SDHCI host controller hardware bug where a CAPs
> bit is a 1 where it should be a 0. Our future 64 ARM chips that do
> support 64bit addressing should be the only chips with this bit set.

Ok, got it. Thanks for the clarification.

So the SDHCI device claims to have a capability that doesn't work,
rather than correctly listing a property that works in principle
but is prevented from working by something outside of the device
as we discussed another time [1]

If this happens in other chips as well, I guess we could also
solve this by changing the code to only enable the 64-bit ADMA
feature when dma_get_required_mask() returns something larger
than a 32-bit mask. This would also be (very slightly) more
efficient because we have to access fewer registers per transfer.

	Arnd

[1] http://marc.info/?l=linux-mmc&m=141457290627820&w=2
