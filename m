From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/14] mmc: omap: handle highmem pages
Date: Tue, 12 Feb 2019 10:39:43 -0800
Message-ID: <20190212183943.GM5720@atomide.com>
References: <20190212072528.13167-1-hch@lst.de>
 <20190212072528.13167-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212072528.13167-7-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Christoph Hellwig <hch@lst.de> [190212 07:27]:
> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.

I'm currently having issues booting my test devices (770 and n8x0)
with this MMC controller so I can't test these patches currently.
Aaro, can you please test when you have a chance?

Regards,

Tony
