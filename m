From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: remove block layer bounce buffering for MMC v2
Date: Mon, 25 Feb 2019 14:54:13 +0100
Message-ID: <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Feb 2019 at 08:25, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi everyone,
>
> this series converts the remaining MMC host drivers to properly kmap the
> scatterlist entries it does PIO operations on, and then goes on to
> remove the usage of block layer bounce buffering (which I plan to remove
> eventually) from the MMC layer.
>
> As a bonus I've converted various drivers to the proper scatterlist
> helpers so that at least in theory they are ready for chained
> scatterlists.
>
> All the changes are compile tested only as I don't have any of the
> hardware, so a careful review would be appreciated.
>
> Changes since v1:
>  - fix a missing kunmap_atomic in mvsdio
>  - fix a stray whitespace in s3cmci
>  - add new sg_kmap_atomic and sg_kunmap_atomic helpers
>  - set the DMA and block layer dma boundary
>  - use pointer arithmetics to reduce the amount of changes in
>    various drivers
>

This looks good to me, however the lack of feedback/tests worries me a
bit. So, unless you think it's a bad idea, I intend to apply this when
v5.1 rc1 is out, which allows a lengthy test period in linux-next.

Make sense?

Kind regards
Uffe
