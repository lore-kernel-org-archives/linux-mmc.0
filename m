From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] mmc: sdhci: Set DMA mask when adding host
Date: Wed, 16 Mar 2016 11:05:34 +0100
Message-ID: <2646031.AqmqXYeZyr@wuerfel>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com> <4404643.KcAFCUffYS@wuerfel> <56E926D8.7020908@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60629 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964968AbcCPKF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 06:05:58 -0400
In-Reply-To: <56E926D8.7020908@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Wednesday 16 March 2016 11:26:48 Adrian Hunter wrote:
> On 16/03/16 11:07, Arnd Bergmann wrote:
> > On Wednesday 16 March 2016 10:43:33 Adrian Hunter wrote:
> >>> +
> >>> +     /* 32-bit mask as default & fallback */
> >>> +     if (ret) {
> >>> +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >>
> >> What happens if device enumeration (e.g. of_dma_configure) has already set a
> >> more restrictive DMA mask?
> >>
> >>
> > 
> > In this case, dma_set_mask_and_coherent() is supposed to check the
> > bus properties settings again and fail dma_set_mask_and_coherent().
> 
> So the logic this patch introduces will disable DMA in that case.  Would it
> be better just to leave the DMA mask alone (as it does now for most sdhci
> drivers) in the 32-bit case?

It depends to some degree on the specific capabilities of the system.

Basically when the driver asks for a 32-bit mask, we have to check if that
is actually possible, and there are a couple of possible outcomes:

- If the bus is less than 32-bit wide but the RAM is small enough to
  to fit within the addressable range of the bus, the
  dma_set_mask_and_coherent() should succeed

- If the RAM is larger than what the bus can address, but swiotlb
  is configured and the swiotlb bounce buffer is addressable by
  the bus, dma_set_mask_and_coherent() should also succeed

- If there is no swiotlb and there is RAM that fits into the 32-bit
  mask but that is not addressable by the bus, the
  dma_set_mask_and_coherent() should fail, and the driver should not
  use DMA.

- Similarly, if swiotlb is enabled, but its bounce buffer is not
  reachable by the bus, the call needs to fail and the driver must
  not use DMA.

	Arnd
