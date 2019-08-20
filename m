From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Date: Tue, 20 Aug 2019 01:42:18 +0000
Message-ID: <TYAPR01MB4544A7A255738624E2A405C9D8AB0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<312d6e38-5143-fb07-1efb-01e60cafa2c9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <312d6e38-5143-fb07-1efb-01e60cafa2c9-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org" <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Robin,

> From: Robin Murphy, Sent: Monday, August 19, 2019 9:55 PM
> 
> On 26/07/2019 09:31, Yoshihiro Shimoda wrote:
> > This patch adds a new dma_map_ops of get_merge_boundary() to
> > expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index a7f9c3e..2992ce4 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   	return ret;
> >   }
> >
> > +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_DMA)
> 
> Did you actually need this check? In principle, if the default domain is
> not of type IOMMU_DOMAIN_DMA then the device should be assigned
> dma_direct_ops rather than iommu_dma_ops, thus it shouldn't be possible
> to get here. If you did manage to hit a case where the domain type
> didn't match the ops it would be interesting to figure out how.

Thank you for your review! You're correct. The current dma-iommu.c sets
the iommu_dma_ops to the device dma_ops only when the type is IOMMU_DOMAIN_DMA
like below:
---
	if (domain->type == IOMMU_DOMAIN_DMA) {
		if (iommu_dma_init_domain(domain, dma_base, size, dev))
			goto out_err;
		dev->dma_ops = &iommu_dma_ops;
	}
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/dma-iommu.c#n1118
---

So, I'll remove this check.

Best regards,
Yoshihiro Shimoda

> Robin.
> 
> > +		return 0;	/* can't merge */
> > +
> > +	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> > +}
> > +
> >   static const struct dma_map_ops iommu_dma_ops = {
> >   	.alloc			= iommu_dma_alloc,
> >   	.free			= iommu_dma_free,
> > @@ -1100,6 +1110,7 @@ static const struct dma_map_ops iommu_dma_ops = {
> >   	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
> >   	.map_resource		= iommu_dma_map_resource,
> >   	.unmap_resource		= iommu_dma_unmap_resource,
> > +	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> >   };
> >
> >   /*
> >
