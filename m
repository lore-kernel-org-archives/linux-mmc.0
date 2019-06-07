From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Fri, 7 Jun 2019 07:49:33 +0200
Message-ID: <20190607054933.GA8267@lst.de>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190606070059.GI27033@lst.de>
	<OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OSAPR01MB3089E3E79B0BDF24610FBEC2D8100-OxqQCv4d1nRTvN4vYzcOL3colHNk5qUtvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 07, 2019 at 05:41:56AM +0000, Yoshihiro Shimoda wrote:
> > bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
> > {
> > 	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
> > 		return false;
> 
> As Robin mentioned, all IOMMUs can merge segments so that we don't need
> this condition, IIUC. However, this should check whether the device is mapped
> on iommu by using device_iommu_mapped().

There are plenty of dma_map_ops based drivers that can't merge segments.
Examples:

 - arch/ia64/sn/pci/pci_dma.c
 - arch/mips/jazz/jazzdma.c
 - arch/sparc/mm/io-unit.c
 - arch/sparc/mm/iommu.c
 - arch/x86/kernel/pci-calgary_64.c

Nevermind the diret mapping, swiotlb and other weirdos.

> 
> > 	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
> > 	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));
> 
> By the way, I reported an issue [1] and I'm thinking dima_is_direct() environment
> (especially for swiotlb) is also needed such max_segment_size changes somehow.
> What do you think?
> 
> [1]
> https://marc.info/?l=linux-block&m=155954415603356&w=2

That doesn't seem to be related to the segment merging.  I'll take
a look, but next time please Cc the author of a suspect commit if
you already bisect things.
