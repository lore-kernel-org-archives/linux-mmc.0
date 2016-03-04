From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Fri, 04 Mar 2016 09:38:21 +0100
Message-ID: <27028474.SJJak25cUc@wuerfel>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com> <CAAVeFuLN7SUM3rSgYXOut+2xgwHEzyY51c2tKP2fqKCRD7ZZXg@mail.gmail.com> <CAAVeFuLEXB1uLgzbvTy207z5Dh6LST7DvzTJ5Vtt1JeiStJztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:54983 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbcCDIie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 03:38:34 -0500
In-Reply-To: <CAAVeFuLEXB1uLgzbvTy207z5Dh6LST7DvzTJ5Vtt1JeiStJztg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday 04 March 2016 15:43:56 Alexandre Courbot wrote:
> >
> > Yeah, I'm not too sure what is the point of setting the fake mask to
> > be honest, but you are definitely right that it is a contradiction to
> > call a DMA function on a device that is not DMA-capable.
> 
> Ah, I finally got it - we are just setting it to the *address* of
> host->dma_mask so the device's DMA mask does not end up being a NULL
> pointer.
> 
> That actually changes things a bit. DMA-capable devices are clearly
> expected to set the mask themselves, but the only one to do it is
> host/mtk-sd.c. And dma_set_mask() is only called in dw_mmc and
> sdhci-acpi's enable_dma callback.
> 
> This means most DMA-capable devices (including Tegra, but not only)
> are simply left with no DMA setup at all.
> 
> Probably we can detect when the host did not do any DMA setup in the
> probe function and attempt some sane defaults depending on what the
> hardware says it is capable of?

When the host leaves an empty DMA mask, the intended meaning is
that the device is not on a DMA capable bus, so if we run into
that case, we should instead fix the creation of the device
rather than the driver that looks at the data.

	Arnd
