From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 1/3] mmc: sdhci: Set DMA mask when adding host
Date: Wed, 16 Mar 2016 11:26:48 +0200
Message-ID: <56E926D8.7020908@intel.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
 <1457316477-8153-2-git-send-email-acourbot@nvidia.com>
 <56E91CB5.7030007@intel.com> <4404643.KcAFCUffYS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28568 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422AbcCPJae (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Mar 2016 05:30:34 -0400
In-Reply-To: <4404643.KcAFCUffYS@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On 16/03/16 11:07, Arnd Bergmann wrote:
> On Wednesday 16 March 2016 10:43:33 Adrian Hunter wrote:
>>> +
>>> +     /* 32-bit mask as default & fallback */
>>> +     if (ret) {
>>> +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>
>> What happens if device enumeration (e.g. of_dma_configure) has already set a
>> more restrictive DMA mask?
>>
>>
> 
> In this case, dma_set_mask_and_coherent() is supposed to check the
> bus properties settings again and fail dma_set_mask_and_coherent().

So the logic this patch introduces will disable DMA in that case.  Would it
be better just to leave the DMA mask alone (as it does now for most sdhci
drivers) in the 32-bit case?

