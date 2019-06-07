From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Fri, 7 Jun 2019 05:41:56 +0000
Message-ID: <OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190606070059.GI27033@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190606070059.GI27033-jcswGhMUV9g@public.gmane.org>
Content-Language: ja-JP
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

> From: Christoph Hellwig, Sent: Thursday, June 6, 2019 4:01 PM
> 
> On Thu, Jun 06, 2019 at 06:28:47AM +0000, Yoshihiro Shimoda wrote:
> > > The problem is that we need a way to communicate to the block layer
> > > that more than a single segment is ok IFF the DMA API instance supports
> > > merging.  And of course the answer will depend on futher parameters
> > > like the maximum merged segment size and alignment for the segement.
> >
> > I'm afraid but I don't understand why we need a way to communicate to
> > the block layer that more than a single segment is ok IFF the DMA API
> > instance supports merging.
> 
> Assume a device (which I think is your case) that only supports a single
> segment in hardware.  In that case we set max_segments to 1 if no
> IOMMU is present.  But if we have a merge capable IOMMU we can set
> max_segments to unlimited (or some software limit for scatterlist
> allocation), as long as we set a virt_boundary matching what the IOMMU
> expects, and max_sectors_kb isn't larger than the max IOMMU mapping
> size.  Now we could probably just open code this in the driver, but
> I'd feel much happier having a block layer like this:

Thank you for the explanation in detail!

> bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
> {
> 	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
> 		return false;

As Robin mentioned, all IOMMUs can merge segments so that we don't need
this condition, IIUC. However, this should check whether the device is mapped
on iommu by using device_iommu_mapped().

> 	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
> 	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));

By the way, I reported an issue [1] and I'm thinking dima_is_direct() environment
(especially for swiotlb) is also needed such max_segment_size changes somehow.
What do you think?

[1]
https://marc.info/?l=linux-block&m=155954415603356&w=2

> 	return true;
> }
> 
> and the driver then does:
> 
> 	if (blk_can_use_iommu_merging(q, dev)) {
> 		blk_queue_max_segments(q, MAX_SW_SEGMENTS);
> 		// initialize sg mempool, etc..
> 	}

In this case, I assume that "the driver" is ./drivers/mmc/core/queue.c,
not any drivers/mmc/host/ code.

> Where the SCREAMING pseudo code calls are something we need to find a
> good API for.

I assumed
 - IOMMU_PAGE_SIZE(dev) = dma_get_seg_boundary(dev);
 - IOMMU_MAX_SEGMENT_SIZE(dev) = dma_get_max_seg_size(dev);

I could not find "IOMMU_PAGE_SIZE(dev))" for now.
If it's true, I'll add such a new API.

> And thinking about it the backend doesn't need to be an iommu, swiotlb
> could handle this as well, which might be interesting for devices
> that need to boune buffer anyway.  IIRC mmc actually has some code
> to copy multiple segments into a bounce buffer somewhere.

I see. So, as I mentioned above, this seems that swiotlb is also needed.
IIUC, now mmc doesn't have a bounce buffer from the commit [2].

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?h=v5.2-rc3&id=de3ee99b097dd51938276e3af388cd4ad0f2750a

> > The block layer already has a limit "max_segment_size" for each device so that
> > regardless it can/cannot merge the segments, we can use the limit.
> > Is my understanding incorrect?
> 
> Yes.

Now I understand that block layer's max_segment_size differs with IOMMU's one.

Best regards,
Yoshihiro Shimoda
