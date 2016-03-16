From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] mmc: sdhci: Set DMA mask when adding host
Date: Wed, 16 Mar 2016 10:07:01 +0100
Message-ID: <4404643.KcAFCUffYS@wuerfel>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com> <1457316477-8153-2-git-send-email-acourbot@nvidia.com> <56E91CB5.7030007@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E91CB5.7030007@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Wednesday 16 March 2016 10:43:33 Adrian Hunter wrote:
> > +
> > +     /* 32-bit mask as default & fallback */
> > +     if (ret) {
> > +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> 
> What happens if device enumeration (e.g. of_dma_configure) has already set a
> more restrictive DMA mask?
> 
> 

In this case, dma_set_mask_and_coherent() is supposed to check the
bus properties settings again and fail dma_set_mask_and_coherent().

We currently don't do that on ARM, which is a bug.

	Arnd
