From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Thu, 6 Jun 2019 09:00:59 +0200
Message-ID: <20190606070059.GI27033@lst.de>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OSAPR01MB3089448A3D44BE61B127AA73D8170-OxqQCv4d1nRTvN4vYzcOL3colHNk5qUtvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

On Thu, Jun 06, 2019 at 06:28:47AM +0000, Yoshihiro Shimoda wrote:
> > The problem is that we need a way to communicate to the block layer
> > that more than a single segment is ok IFF the DMA API instance supports
> > merging.  And of course the answer will depend on futher parameters
> > like the maximum merged segment size and alignment for the segement.
> 
> I'm afraid but I don't understand why we need a way to communicate to
> the block layer that more than a single segment is ok IFF the DMA API
> instance supports merging.

Assume a device (which I think is your case) that only supports a single
segment in hardware.  In that case we set max_segments to 1 if no
IOMMU is present.  But if we have a merge capable IOMMU we can set
max_segments to unlimited (or some software limit for scatterlist
allocation), as long as we set a virt_boundary matching what the IOMMU
expects, and max_sectors_kb isn't larger than the max IOMMU mapping
size.  Now we could probably just open code this in the driver, but
I'd feel much happier having a block layer like this:

bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
{
	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
		return false;

	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));
	return true;
}

and the driver then does:

	if (blk_can_use_iommu_merging(q, dev)) {
		blk_queue_max_segments(q, MAX_SW_SEGMENTS);
		// initialize sg mempool, etc..
	}


Where the SCREAMING pseudo code calls are something we need to find a
good API for.

And thinking about it the backend doesn't need to be an iommu, swiotlb
could handle this as well, which might be interesting for devices
that need to boune buffer anyway.  IIRC mmc actually has some code
to copy multiple segments into a bounce buffer somewhere.

> The block layer already has a limit "max_segment_size" for each device so that
> regardless it can/cannot merge the segments, we can use the limit.
> Is my understanding incorrect?

Yes.
