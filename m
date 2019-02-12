From: Christoph Hellwig <hch@lst.de>
Subject: remove block layer bounce buffering for MMC v2
Date: Tue, 12 Feb 2019 08:25:14 +0100
Message-ID: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

this series converts the remaining MMC host drivers to properly kmap the
scatterlist entries it does PIO operations on, and then goes on to
remove the usage of block layer bounce buffering (which I plan to remove
eventually) from the MMC layer.

As a bonus I've converted various drivers to the proper scatterlist
helpers so that at least in theory they are ready for chained
scatterlists.

All the changes are compile tested only as I don't have any of the
hardware, so a careful review would be appreciated.

Changes since v1:
 - fix a missing kunmap_atomic in mvsdio
 - fix a stray whitespace in s3cmci
 - add new sg_kmap_atomic and sg_kunmap_atomic helpers
 - set the DMA and block layer dma boundary
 - use pointer arithmetics to reduce the amount of changes in
   various drivers
