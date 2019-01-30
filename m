From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Date: Wed, 30 Jan 2019 09:16:03 +0100
Message-ID: <CAPDyKFq5mMPX6vfbJVqGPFBwSQ0+eG_UVcok74GQqcmTktgkXA@mail.gmail.com>
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-6-hch@lst.de>
 <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com> <20190130080423.GA29937@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130080423.GA29937@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 30 Jan 2019 at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 30, 2019 at 08:57:47AM +0100, Ulf Hansson wrote:
> > On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Instead of setting up a kernel pointer to track the current PIO address,
> > > track the offset in the current page, and do an atomic kmap for the page
> > > while doing the actual PIO operations.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Nitpick: This one have some trailing whitespace errors, which git
> > complains about when I apply it.
> >
> > No need to re-spin due to this, I can fix it  up.
>
> I'll need to respin to limit the segment size to a page anyway, so I
> will take this into account as well for v2.

Okay!

FYI, I have no further comment on the series, it looks okay to me!

Kind regards
Uffe
